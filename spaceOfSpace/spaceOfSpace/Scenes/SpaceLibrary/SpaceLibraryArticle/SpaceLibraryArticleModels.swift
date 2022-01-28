import UIKit

enum SpaceLibraryArticleModel {
    // MARK: Use cases
    
    enum Article {
        struct Request {
            var articleTitle: String
        }
        
        struct Response {
            var article: SpaceLibraryArticle?
        }
        
        struct ViewModel {
            var displayedItems: SpaceLibraryArticle
        }
    }
}
