//
//  FixedRetryConfig.swift
//  KinopoiskHD
//
//  Created by Kostarev Kirill on 01.08.2021.
//

import Foundation

/// Cтруктура с параметрами для создания fixed retry
struct FixedRetryConfig {
    let retryConfig: RetryConfig
    let delay: TimeInterval
    let maxAttemptCount: Int
}
