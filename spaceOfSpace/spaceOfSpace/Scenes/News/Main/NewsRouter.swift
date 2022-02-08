import UIKit

@objc protocol NewsRoutingLogic {
    func routeToShowBrowser()
}

protocol NewsDataPassing {
    var dataStore: NewsDataStore? { get }
}

class NewsRouter: NSObject, NewsRoutingLogic, NewsDataPassing {
    
    weak var viewController: NewsViewController?
    var dataStore: NewsDataStore?
    
    // MARK: Routing
    
    func routeToShowBrowser() {
        let newsWebBrowserVC = NewsWebConfigurator.build()
        guard let dataStore = dataStore else { return }
        guard var destinationDataStore = newsWebBrowserVC.router?.dataStore else { return }
        passDataToNewsWebBrowser(source: dataStore, destination: &destinationDataStore)
        viewController?.navigationController?.pushViewController(newsWebBrowserVC, animated: true)
        
    }
    
    // MARK: Passing data
    
    func passDataToNewsWebBrowser(source: NewsDataStore, destination: inout NewsWebBrowserDataStore) {
        guard let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row else { return }
        guard let news = source.news[selectedRow] else { return }
        destination.hyperlink = news.hyperlink?.formatToHTTPS
    }
}
