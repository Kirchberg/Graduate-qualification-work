//
//  SpaceLibraryCategoriesModels.swift
//  spaceOfSpace
//
//  Created by Aleksandr Dergachev on 01.04.2021.
//

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
