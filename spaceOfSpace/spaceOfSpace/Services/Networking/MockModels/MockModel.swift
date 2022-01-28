//
//  MockModel.swift
//  spaceOfSpace
//
//  Created by Kostarev Kirill on 05.08.2021.
//

import Foundation

// На данный момент это заглушка для модели, получаемой после преобразования данных из API
struct MockModel: Decodable {
    init(withDTO dto: NetworkMockModel) throws {
    }
}
