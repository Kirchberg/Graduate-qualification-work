//
//  SpaceLibraryCategory.swift
//  spaceOfSpace
//
//  Created by Aleksandr Dergachev on 11.04.2021.
//

import Foundation

struct SpaceLibraryCategory {
    var categoryTitle: String?
    var categoryImage: String?

    init(title: String? = nil, imageName: String? = nil) {
        self.categoryTitle = title
        self.categoryImage = imageName
    }
}
