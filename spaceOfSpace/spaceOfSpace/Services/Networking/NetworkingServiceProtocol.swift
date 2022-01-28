import Foundation

typealias MockItemsResult = Result<[MockModel], NetworkingServiceError>

protocol NetworkingService: AnyObject {
    func getItems(
        retryPolicy: RequestRetryPolicy,
        completion: @escaping (MockItemsResult) -> Void
    )
}

// Стандтартное значение для RetryPolicy = .none
extension NetworkingService {
    func getItems(
        retryPolicy: RequestRetryPolicy,
        completion: @escaping (MockItemsResult) -> Void
    ) {
        getItems(retryPolicy: .none, completion: completion)
    }
}
