import Foundation

/// Структура, описывающая общие поля любого типа retry
struct RetryConfig {
    let urlRequest: URLRequest
    let retryPolicy: RequestRetryPolicy
    let requestID: RequestID
}
