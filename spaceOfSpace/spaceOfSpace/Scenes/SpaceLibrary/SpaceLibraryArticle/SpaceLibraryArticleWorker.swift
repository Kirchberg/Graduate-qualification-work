import UIKit

class SpaceLibraryArticleWorker {
    let articlesManager = WikipediaAPIService()
    
    func fetch(articleTitle: String, success: @escaping (_ response: SpaceLibraryArticleModel.Article.Response) -> ()) {
        articlesManager.requestArticle(articleTitle: articleTitle) { article in
            guard article != nil else { return }
            success(SpaceLibraryArticleModel.Article.Response(article: article))
        }
    }
    
    func doSomeWork() {
    }
}
