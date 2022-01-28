//
//  NewsInteractor.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit

protocol NewsBusinessLogic {
    func fetchNews(request: NewsModel.FetchNews.Request)
}

protocol NewsDataStore {
    var news: [News?] { get }
}

class NewsInteractor: NewsBusinessLogic, NewsDataStore {
    var presenter: NewsPresentationLogic?
    var worker: NewsWorker?
    var news: [News?] = []
    
    func fetchNews(request: NewsModel.FetchNews.Request) {
        worker = NewsWorker()
        worker?.fetch(startFetchFrom: request.startFetchFrom, success: { arrayOfNews in
            self.news.append(contentsOf: arrayOfNews.news)
            self.presenter?.presentFetchedNews(response: NewsModel.FetchNews.Response(news: self.news))
        })
    }
}
