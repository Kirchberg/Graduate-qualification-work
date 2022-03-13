import UIKit
import SwiftyJSON

typealias responseHandler = (_ response: NewsModel.FetchNews.Response) -> ()

protocol NewsWorkerLogic {
    func fetch(startFetchFrom: Int, success: @escaping responseHandler)
}

final class NewsWorker: NewsWorkerLogic {
    let newsManager = NewsAPIService()
    func fetch(startFetchFrom: Int, success: @escaping responseHandler) {
        newsManager.requestNewsForOnePage(startFrom: startFetchFrom) { arrayOfNews in
            guard arrayOfNews.count > 0 else { return }
            success(NewsModel.FetchNews.Response(news: arrayOfNews))
        }
    }
}
