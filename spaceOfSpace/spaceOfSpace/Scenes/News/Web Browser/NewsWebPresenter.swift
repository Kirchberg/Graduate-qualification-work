import UIKit

protocol NewsWebBrowserPresentationLogic {
    func presentHyperlink(url: URL)
}

class NewsWebBrowserPresenter: NewsWebBrowserPresentationLogic {
    weak var viewController: NewsWebBrowserDisplayLogic?
    
    // MARK: Do something
    
    func presentHyperlink(url: URL) {
        let viewModel = NewsWebBrowser.showShareMenu.ViewModel(hyperlink: url)
        viewController?.displayWebBrowser(viewModel: viewModel)
    }
}
