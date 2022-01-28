//
//  SpaceLibraryCategoryDetailedModels.swift
//  spaceOfSpace
//
//  Created by Aleksandr Dergachev on 01.04.2021.
//

import UIKit

enum SpaceLibraryCategoryDetailedModel {
    
    enum Articles {
        struct Request {
            var articleTitles: [String]
        }
        
        struct Response {
            var articles: [SpaceLibraryArticle?]
        }
        
        struct ViewModel {
            var displayedItems: [SpaceLibraryArticle]
        }
    }
}
