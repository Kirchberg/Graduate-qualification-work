import UIKit

@objc protocol SpaceLibraryArticleRoutingLogic {
    func presentToc()
}

protocol SpaceLibraryArticleDataPassing {
    var dataStore: SpaceLibraryArticleDataStore? { get }
}

class SpaceLibraryArticleRouter: NSObject, SpaceLibraryArticleRoutingLogic, SpaceLibraryArticleDataPassing {
    weak var viewController: SpaceLibraryArticleViewController?
    var dataStore: SpaceLibraryArticleDataStore?
    
    // MARK: Routing
    
    func presentToc() {
        let tocVC = SpaceLibraryTableOfContentsViewController()
        tocVC.interactor?.articleBusinessLogicDelegate = viewController?.interactor
        guard let dataStore = dataStore else { return }
        guard var destinationDataStore = tocVC.router?.dataStore else { return }
        
        passDataToToc(source: dataStore, destination: &destinationDataStore)
        
        viewController?.present(tocVC, animated: true, completion: nil)
    }
    
    // MARK: Passing data
    
    func passDataToToc(source: SpaceLibraryArticleDataStore, destination: inout SpaceLibraryTableOfContentsDataStore) {
        destination.article = source.article
    }
}
