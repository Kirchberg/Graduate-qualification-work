import UIKit

@objc protocol SpaceLibraryCategoryDetailedRoutingLogic {
    func routeToArticle()
}

protocol SpaceLibraryCategoryDetailedDataPassing {
    var dataStore: SpaceLibraryCategoryDetailedDataStore? { get }
}

class SpaceLibraryCategoryDetailedRouter: NSObject, SpaceLibraryCategoryDetailedRoutingLogic, SpaceLibraryCategoryDetailedDataPassing {
    weak var viewController: SpaceLibraryCategoryDetailedViewController?
    var dataStore: SpaceLibraryCategoryDetailedDataStore?
    
    // MARK: Routing
    
    func routeToArticle() {
        let articleVC = SpaceLibraryArticleViewController()
        
        guard let dataStore = dataStore else { return }
        guard var destinationDataStore = articleVC.router?.dataStore else { return }
        
        passDataToArticleVC(source: dataStore, destination: &destinationDataStore)
        viewController?.navigationController?.pushViewController(articleVC, animated: true)
    }
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: SpaceLibraryViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    func passDataToArticleVC(source: SpaceLibraryCategoryDetailedDataStore, destination: inout SpaceLibraryArticleDataStore) {
        guard let itemIndex = viewController?.tableView.indexPathForSelectedRow?.section else { return }
        guard let title = source.articles[itemIndex]?.articleTitle else { return }
        
        destination.title = title
    }
}
