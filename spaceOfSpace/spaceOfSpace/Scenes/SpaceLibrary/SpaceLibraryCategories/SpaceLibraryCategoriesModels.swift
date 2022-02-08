import UIKit

enum SpaceLibraryCategoriesModel {
    
    enum Categories {
        struct Request {
            
        }
        
        struct Response {
            var categories: [SpaceLibraryCategory]
        }
        
        struct ViewModel {
            var displayedItems: [SpaceLibraryCategory]
        }
    }
}
