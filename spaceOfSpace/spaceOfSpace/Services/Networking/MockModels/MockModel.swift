import Foundation

// На данный момент это заглушка для модели, получаемой после преобразования данных из API
struct MockModel: Decodable {
    init(withDTO dto: NetworkMockModel) throws {
    }
}
