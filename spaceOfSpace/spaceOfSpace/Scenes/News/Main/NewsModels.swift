import UIKit

protocol DisplayedObject {}

enum NewsModel {
    enum FetchNews {
        struct Request {
            var startFetchFrom: Int
        }
        struct Response {
            var news: [News?]
        }
        struct ViewModel {
            struct DisplayedNews: DisplayedObject {
                var title: String
                var imageURL: String
                var content: String
                var datePublished: String
                var source: String
            }
            
            var displayedObjects: [DisplayedNews]
            
        }
    }
}
