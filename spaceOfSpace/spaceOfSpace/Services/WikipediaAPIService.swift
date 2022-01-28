//
//  WikipediaAPIService.swift
//  spaceOfSpace
//
//  Created by Aleksandr Dergachev on 20.04.2021.
//
//  https://en.wikipedia.org/w/api.php?action=query&format=json&list=categorymembers&cmtitle=Category%3AAstronomical_objects_known_since_antiquity&cmtype=subcat
//  https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages&titles=Earth&piprop=original
//  https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cextracts&titles=Earth&piprop=original&explaintext=1

import Alamofire
import SwiftyJSON
import Foundation

class WikipediaAPIService {
    
    private let source: String = "https://en.wikipedia.org/w/api.php?action=query&format=json"
    
    func requestArticles(articleTitles: [String], completion: @escaping ([SpaceLibraryArticle?]) -> ()) {
        
        var articleTitlesS = String()
        for title in articleTitles {
            articleTitlesS += title + "|"
        }
        articleTitlesS = String(articleTitlesS.dropLast(1))
        
        let optionalStringURL = "\(source)&prop=pageimages&titles=\(articleTitlesS)&piprop=original".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        guard let stringURL = optionalStringURL else { return }
        
        AF.request(stringURL).responseJSON { (data) in
            guard let data = data.value else { return }
            let jsonObject = JSON(data)
            completion(self.transferJsonToArticlesModel(json: jsonObject))
        }
    }
    
    func requestArticle(articleTitle: String, completion: @escaping (SpaceLibraryArticle?) -> ()) {
        
        let optionalStringURL = "\(source)&prop=extracts|pageimages&titles=\(articleTitle)&explaintext=1&piprop=original".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        guard let stringURL = optionalStringURL else { return }
        
        AF.request(stringURL).responseJSON { (data) in
            guard let data = data.value else { return }
            let jsonObject = JSON(data)
            completion(self.transferJsonToArticleModel(json: jsonObject))
        }
    }
    
    private func transferJsonToArticlesModel(json: JSON) -> [SpaceLibraryArticle?] {
        var arrayOfArticles = [SpaceLibraryArticle?]()
        
        for (_, articleElement) in json["query"]["pages"] {
            let article = SpaceLibraryArticle(title: articleElement["title"].stringValue, imageName: articleElement["original"]["source"].stringValue)
            arrayOfArticles.append(article)
        }
        
        return arrayOfArticles
    }
    
    private func transferJsonToArticleModel(json: JSON) -> SpaceLibraryArticle? {
        var articleModel = SpaceLibraryArticle()
        
        let (_, article) = json["query"]["pages"].first ?? ("", JSON())
        
        articleModel.articleTitle = article["title"].stringValue
        articleModel.articleImage = article["original"]["source"].stringValue
        articleModel.articleText = article["extract"].stringValue
        
        return articleModel
    }
}
