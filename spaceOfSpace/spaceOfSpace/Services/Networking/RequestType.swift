//
//  RequestType.swift
//  KinopoiskHD
//
//  Created by Kostarev Kirill on 31.07.2021.
//

import Foundation

protocol RequestType {
    var urlString: String { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
}

/// Enum для создания запросов
enum MockRequestType: RequestType {
    private static let baseUrlString = ""
    private static let jsonEncoder = JSONEncoder()

    case getAllMocks
    
    // Формирование ручек API относительно базового URL
    var urlString: String {
        switch self {
        case .getAllMocks:
            return "\(Self.baseUrlString)"
        }
    }
    
    // Тип посылаемого запроса
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllMocks:
            return .GET
        }
    }
    
    // Передача данных в запросе
    var httpBody: Data? {
        switch self {
        // Ничего не передаем серверу
        case .getAllMocks:
            return nil
        }
    }
}
