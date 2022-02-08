import Foundation

/// Cтруктура с параметрами для создания fixed retry
struct FixedRetryConfig {
    let retryConfig: RetryConfig
    let delay: TimeInterval
    let maxAttemptCount: Int
}
