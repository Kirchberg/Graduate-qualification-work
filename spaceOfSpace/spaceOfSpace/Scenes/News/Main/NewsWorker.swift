//
//  NewsWorker.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit
import SwiftyJSON

typealias responseHadler = (_ response: NewsModel.FetchNews.Response) -> ()

class NewsWorker {
    let newsManager = NewsAPIService()
    func fetch(startFetchFrom: Int, success: @escaping responseHadler) {
        newsManager.requestNewsForOnePage(startFrom: startFetchFrom) { arrayOfNews in
            guard arrayOfNews.count > 0 else { return }
            success(NewsModel.FetchNews.Response(news: arrayOfNews))
        }
    }
}
