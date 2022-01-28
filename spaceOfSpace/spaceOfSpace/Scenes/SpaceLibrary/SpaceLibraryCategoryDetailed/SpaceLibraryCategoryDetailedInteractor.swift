//
//  SpaceLibraryCategoryDetailedInteractor.swift
//  spaceOfSpace
//
//  Created by Aleksandr Dergachev on 01.04.2021.
//

import UIKit

protocol SpaceLibraryCategoryDetailedBusinessLogic {
    func getArticles()
    func getTitle()
}

protocol SpaceLibraryCategoryDetailedDataStore {
    var title: String { get set }
    var articleTitles: [String]? { get set }
    var articles: [SpaceLibraryArticle?] { get set }
}

class SpaceLibraryCategoryDetailedInteractor: SpaceLibraryCategoryDetailedBusinessLogic, SpaceLibraryCategoryDetailedDataStore {
    var presenter: SpaceLibraryCategoryDetailedPresentationLogic?
    var worker: SpaceLibraryCategoryDetailedWorker?
    
    var title: String = ""
    var articleTitles: [String]? = []
    var articles: [SpaceLibraryArticle?] = []


    // MARK: Do something
    
    func getArticles() {
        
        worker = SpaceLibraryCategoryDetailedWorker()
        
        guard let articleTitles = articleTitles else { return }
        
        worker?.fetch(articleTitles: articleTitles, success: { arrayOfArticles in
            self.articles.append(contentsOf: arrayOfArticles.articles)
            self.presenter?.presentArticles(response: SpaceLibraryCategoryDetailedModel.Articles.Response(articles: self.articles))
        })
    }
    
    func getTitle() {
        presenter?.setTitle(title: title)
    }
}
