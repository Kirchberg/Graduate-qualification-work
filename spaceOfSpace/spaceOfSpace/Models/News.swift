//
//  News.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 31.03.2021.
//

import Foundation

struct News {
    var title: String?
    var imageURL: String?
    var content: String?
    var datePublished: String?
    var source: String?
    var hyperlink: String?
    
    init(title: String? = nil, imageURL: String? = nil, content: String? = nil, datePublished: String? = nil, source: String? = nil, hyperlink: String? = nil) {
        self.title = title
        self.imageURL = imageURL
        self.content = content
        self.datePublished = datePublished
        self.source = source
        self.hyperlink = hyperlink
    }
}
