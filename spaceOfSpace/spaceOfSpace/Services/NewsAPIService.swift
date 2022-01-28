//
//  NewsAPIManager.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 01.04.2021.
//

import Alamofire
import SwiftyJSON
import Foundation

class NewsAPIService {
    
    private let source: String = "https://api.spaceflightnewsapi.net/v3/articles?_limit=10&_start="
    
    func requestNewsForOnePage(startFrom: Int, completion: @escaping ([News?]) -> ()) {
        var stringURL = source
        stringURL.append(startFrom.toString)
        
        AF.request(stringURL, method: .get).responseJSON { response in
            guard let data = response.data else { return }
            let jsonObject = JSON(data)
            completion(self.transferJsonToNewsModel(json: jsonObject))
        }
    }
    
    private func transferJsonToNewsModel(json: JSON) -> [News?] {
        var arrayOfNews = [News?]()
        for index in 0..<10 {
            let news = News(
                title: json[index]["title"].stringValue,
                imageURL: json[index]["imageUrl"].stringValue,
                content: json[index]["summary"].stringValue,
                datePublished: json[index]["publishedAt"].stringValue,
                source: json[index]["newsSite"].stringValue,
                hyperlink: json[index]["url"].stringValue
            )
            arrayOfNews.append(news)
        }
        return arrayOfNews
    }
}
