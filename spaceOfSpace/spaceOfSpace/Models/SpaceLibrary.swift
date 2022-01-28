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
    var categoryArticleTitles: [String]?

    init(title: String? = nil, imageName: String? = nil, articles: [String]? = []) {
        self.categoryTitle = title
        self.categoryImage = imageName
        self.categoryArticleTitles = articles
    }
}

struct SpaceLibraryArticle {
    var articleTitle: String?
    var articleImage: String?
    var articleSections: [SpaceLibraryArticleSection]?
    var articleText: String?

    init(title: String? = nil, imageName: String? = nil, sections: [SpaceLibraryArticleSection]? = nil, articleText: String? = nil) {
        self.articleTitle = title
        self.articleImage = imageName
        self.articleSections = sections
        self.articleText = articleText
    }
}

struct SpaceLibraryArticleSection {
    var sectionTitle: String?
    var sectionText: String?
    var sectionLevel: Int = 0
    
    init(title: String? = nil, text: String? = nil) {
        self.sectionTitle = title
        self.sectionText = text
    }
}
