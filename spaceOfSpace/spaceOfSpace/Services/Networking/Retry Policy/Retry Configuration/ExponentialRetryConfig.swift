import Foundation

/// Cтруктура с параметрами для создания exponential retry
struct ExponentialRetryConfig {
    let retryConfig: RetryConfig
    let exponentialRetry: ExponentialRetry
}

/// Cтруктура, описывающая параметры для подсчета задержки
struct ExponentialRetry {
    private let minDelay: Double = 2.0
    private let maxDelay: Double = 120.0
    private let factor: Double = 1.5
    private let jitter: Double = 0.1
    private let jitterGranularity: UInt32 = 10000
}

extension ExponentialRetry {
    /// Подсчет новой задержки для exponential retry
    /// - Parameter lastUsedDelay: Задержка, которая использовалась до подсчета новой
    func calculateNewDelay(lastUsedDelay: TimeInterval? = nil) -> TimeInterval {
        guard let lastUsedDelay = lastUsedDelay else { return minDelay }

        let delay: TimeInterval
        let factoredDelay = min(lastUsedDelay * factor, maxDelay)
        let rand = arc4random_uniform(2 * jitterGranularity)
        let randMultipler = Double(rand) / Double(jitterGranularity)
        let jitteredMultiplier = (randMultipler - 1) * jitter
        delay = factoredDelay * (1 + jitteredMultiplier)
        return delay
    }
}
