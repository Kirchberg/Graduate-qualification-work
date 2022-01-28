//
//  RequestRetryPolicy.swift
//  KinopoiskHD
//
//  Created by Kostarev Kirill on 01.08.2021.
//

import Foundation

/// Enum с описанием типов request retry
enum RequestRetryPolicy {
    case none
    case fixed(delay: TimeInterval, maxAttemptCount: Int)
    case exponential(config: ExponentialRetry)
    
    static let `default`: RequestRetryPolicy = .none
}
