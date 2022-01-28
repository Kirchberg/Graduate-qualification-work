import UIKit

class SpaceLibraryCategoryDetailedWorker {
    
    let articlesManager = WikipediaAPIService()
    
    func fetch(articleTitles: [String], success: @escaping (_ response: SpaceLibraryCategoryDetailedModel.Articles.Response) -> ()) {
        articlesManager.requestArticles(articleTitles: articleTitles) { arrayOfArticles in
            guard arrayOfArticles.count > 0 else { return }
            success(SpaceLibraryCategoryDetailedModel.Articles.Response(articles: arrayOfArticles))
        }
    }
}
