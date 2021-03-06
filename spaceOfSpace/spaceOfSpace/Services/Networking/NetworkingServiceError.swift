import Foundation

/// Enum с ошибками при работе с сетью
enum NetworkingServiceError: Error {
    case failedToCreateUrl(String)
    case networkingError(Error)
    case noResponseOrData
    case deserializationError(Error)
    case serializationError(Error)
    case invalidStatusCode(Int)
    case forcedFailure
}
