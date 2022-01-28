import Foundation

typealias RequestID = UUID

/// Enum с информацией о текущем состоянии request retry
enum RequestRetryInfo {
    case attemptCount(Int)
    case lastUsedDelay(TimeInterval)
}
