//
//  SpaceLibraryArticle.swift
//  spaceOfSpace
//
//  Created by Aleksandr Dergachev on 12.04.2021.
//

import Foundation

struct SpaceLibraryArticle {
    var articleTitle: String?
    var articleImage: String?
    var articleText: String?

    init(title: String? = nil, imageName: String? = nil, articleText: String? = nil) {
        self.articleTitle = title
        self.articleImage = imageName
        self.articleText = articleText
    }
}
