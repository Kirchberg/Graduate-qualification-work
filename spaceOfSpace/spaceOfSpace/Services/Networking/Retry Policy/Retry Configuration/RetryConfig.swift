//
//  RetryConfig.swift
//  KinopoiskHD
//
//  Created by Kostarev Kirill on 01.08.2021.
//

import Foundation

/// Структура, описывающая общие поля любого типа retry
struct RetryConfig {
    let urlRequest: URLRequest
    let retryPolicy: RequestRetryPolicy
    let requestID: RequestID
}
