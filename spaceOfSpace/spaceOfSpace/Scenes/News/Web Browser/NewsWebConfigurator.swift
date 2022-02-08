import UIKit

class NewsWebConfigurator {
    static func build() -> NewsWebBrowserViewController {
        let viewController = NewsWebBrowserViewController()
        let interactor = NewsWebBrowserInteractor()
        let presenter = NewsWebBrowserPresenter()
        let router = NewsWebBrowserRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
