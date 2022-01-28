//
//  RequestRetryInfo.swift
//  KinopoiskHD
//
//  Created by Kostarev Kirill on 01.08.2021.
//

import Foundation

typealias RequestID = UUID

/// Enum с информацией о текущем состоянии request retry
enum RequestRetryInfo {
    case attemptCount(Int)
    case lastUsedDelay(TimeInterval)
}
