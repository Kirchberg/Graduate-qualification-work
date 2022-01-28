//
//  NetworkingServiceImpl.swift
//  KinopoiskHD
//
//  Created by Kostarev Kirill on 31.07.2021.
//

import Foundation

final class NetworkingServiceImpl {
    
    // MARK: - Private Properties
    
    private let session: URLSession = {
        let session = URLSession(configuration: .default)
        session.configuration.timeoutIntervalForRequest = 30.0
        return session
    }()
    
    private let queue: DispatchQueue = DispatchQueue.global(qos: .utility)

    // Параметры для реализации повторного запроса в случае ошибок
    private var retryInfo: [RequestID: RequestRetryInfo] = [:]
    private let existingRequestLock = NSRecursiveLock()
    private var existingRequestIDs: Set<RequestID> = []

    // MARK: - Private Methods

    /// Создание URL-запроса
    /// - Parameter requestType: Параметры запроса
    /// - Returns: Результат с созданным запросом или ошибкой
    private func makeUrlRequest(for requestType: RequestType) -> Result<URLRequest, NetworkingServiceError> {
        guard let url = URL(string: requestType.urlString) else {
            return .failure(NetworkingServiceError.failedToCreateUrl(requestType.urlString))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.httpMethod.rawValue
        
        var headers: [String: String]
        if let existingHeaders = urlRequest.allHTTPHeaderFields {
            headers = existingHeaders
        } else {
            headers = .init()
        }
        
        headers["Content-Type"] = "application/json"
        urlRequest.allHTTPHeaderFields = headers
        
        if let httpBody = requestType.httpBody {
            urlRequest.httpBody = httpBody
        }
        
        return .success(urlRequest)
    }

    /// Выполнение URL-запроса
    /// - Parameters:
    ///   - urlRequest: URL-запрос
    ///   - decodeAs: Ответ сервера в виде какой-то модели
    ///   - retryPolicy: Тип повторного запроса в случае ошибки
    ///   - requestID: Идентификатор данного запроса
    ///   - map: Правило расшифровки ответа сервера
    ///   - completion: Результат выполнения запроса
    private func performRequest<Model: Decodable, T>(
        _ urlRequest: URLRequest,
        decodeAs: Model.Type,
        retryPolicy: RequestRetryPolicy,
        requestID: RequestID? = nil,
        map: @escaping (Model) throws -> T,
        completion: @escaping (Result<T, NetworkingServiceError>) -> Void
    ) {
        let requestID = requestID ?? RequestID()
        self.existingRequestLock.lock()
        self.existingRequestIDs.insert(requestID)
        self.existingRequestLock.unlock()
        
        let complete = { [weak self] (_ result: Result<T, NetworkingServiceError>) -> Void in
            let retryConfig = RetryConfig(
                urlRequest: urlRequest,
                retryPolicy: retryPolicy,
                requestID: requestID
            )
            self?.completeWithRetry(
                result,
                completion,
                map,
                decodeAs: decodeAs,
                retryConfig: retryConfig
            )
        }
        
        queue.async { [weak self] in
            guard let self = self else { return }
            let task = self.session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    complete(.failure(.networkingError(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...499).contains(httpResponse.statusCode),
                      let data = data else {
                    complete(.failure(.noResponseOrData))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let model = try jsonDecoder.decode(Model.self, from: data)
                    let mappedModel = try map(model)
                    complete(.success(mappedModel))
                } catch {
                    complete(.failure(.deserializationError(error)))
                }
            }
            
            task.resume()
        }
    }

    /// Выполнить запрос с ретраем
    private func completeWithRetry<Model: Decodable, T>(
        _ result: Result<T, NetworkingServiceError>,
        _ completion: @escaping (Result<T, NetworkingServiceError>) -> Void,
        _ map: @escaping (Model) throws -> T,
        decodeAs: Model.Type,
        retryConfig: RetryConfig
    ) {
        switch result {
        case .failure:
            break

        // В случае успеха выполнения запроса, ретрай не нужен
        case .success:
            completion(result)
            return
        }

        // Выбор и подготовка ретрая
        switch retryConfig.retryPolicy {
        case .none:
            completion(result)
        case let .fixed(delay, maxAttemptCount):
            let fixedRetryConfig = FixedRetryConfig(
                retryConfig: retryConfig,
                delay: delay,
                maxAttemptCount: maxAttemptCount
            )
            self.completeWithFixedRetry(
                result,
                map,
                completion,
                decodeAs: decodeAs,
                fixedRetryConfig: fixedRetryConfig
            )
        case let .exponential(config):
            let exponentialRetryConfig = ExponentialRetryConfig(
                retryConfig: retryConfig,
                exponentialRetry: config
            )
            self.completeWithExponentialRetry(
                map,
                completion,
                decodeAs: decodeAs,
                exponentialRetryConfig: exponentialRetryConfig
            )
        }
    }
    
    private func completeWithFixedRetry<Model: Decodable, T>(
        _ result: Result<T, NetworkingServiceError>,
        _ map: @escaping (Model) throws -> T,
        _ completion: @escaping (Result<T, NetworkingServiceError>) -> Void,
        decodeAs: Model.Type,
        fixedRetryConfig: FixedRetryConfig
    ) {
        let newAttemptCount: Int
        if case let .attemptCount(attemptCount) = retryInfo[fixedRetryConfig.retryConfig.requestID] {
            newAttemptCount = attemptCount + 1
        } else {
            newAttemptCount = 0
        }

        // Если не достигнут лимит определенного запроса, то повторяем его в случае ошибки
        if newAttemptCount < fixedRetryConfig.maxAttemptCount {
            retryInfo[fixedRetryConfig.retryConfig.requestID] = .attemptCount(newAttemptCount)
            queue.asyncAfter(deadline: .now() + fixedRetryConfig.delay) {
                self.performRequest(
                    fixedRetryConfig.retryConfig.urlRequest,
                    decodeAs: decodeAs,
                    retryPolicy: fixedRetryConfig.retryConfig.retryPolicy,
                    requestID: fixedRetryConfig.retryConfig.requestID,
                    map: map,
                    completion: completion
                )
            }
        } else {
            completion(result)
        }
    }

    private func completeWithExponentialRetry<Model: Decodable, T>(
        _ map: @escaping (Model) throws -> T,
        _ completion: @escaping (Result<T, NetworkingServiceError>) -> Void,
        decodeAs: Model.Type,
        exponentialRetryConfig: ExponentialRetryConfig
    ) {
        let delay: TimeInterval
        if case let .lastUsedDelay(lastUsedDelay) = retryInfo[exponentialRetryConfig.retryConfig.requestID] {
            delay = exponentialRetryConfig.exponentialRetry.calculateNewDelay(lastUsedDelay: lastUsedDelay)
        } else {
            delay = exponentialRetryConfig.exponentialRetry.calculateNewDelay()
        }

        retryInfo[exponentialRetryConfig.retryConfig.requestID] = .lastUsedDelay(delay)
        queue.asyncAfter(deadline: .now() + delay) {
            self.performRequest(
                exponentialRetryConfig.retryConfig.urlRequest,
                decodeAs: decodeAs,
                retryPolicy: exponentialRetryConfig.retryConfig.retryPolicy,
                requestID: exponentialRetryConfig.retryConfig.requestID,
                map: map,
                completion: completion
            )
        }
    }
}

// MARK: - NetworkingService

extension NetworkingServiceImpl: NetworkingService {
    /// GET-запрос
    /// - Parameters:
    ///   - retryPolicy: Тип повторного запроса в случае ошибки
    ///   - completion: Результат выполения запроса
    func getItems(retryPolicy: RequestRetryPolicy, completion: @escaping (MockItemsResult) -> Void) {
        func complete(with result: MockItemsResult) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let urlRequest: URLRequest
        switch makeUrlRequest(for: MockRequestType.getAllMocks) {
        case let .failure(error):
            complete(with: .failure(error))
            return

        case let .success(request):
            urlRequest = request
        }

        performRequest(
            urlRequest,
            decodeAs: [NetworkMockModel].self,
            retryPolicy: retryPolicy,
            map: { try $0.map { try MockModel.init(withDTO: $0) } },
            completion: complete(with:)
        )
    }
}
