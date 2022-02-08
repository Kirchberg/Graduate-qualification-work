import Foundation

final class NLWebBrowserModule {
    
    static func build(withURL browserURL: String) -> NLWebBrowserViewController {
        
        let viewController = NLWebBrowserViewController()
        
        let router = NLWebBrowserRouter()
//        router.transitionHandler = viewController
        
        let presenter = NLWebBrowserPresenter()
        presenter.view = viewController
        
        let interactor = NLWebBrowserInteractor(browserURL: browserURL)
        interactor.presenter = presenter
        interactor.router = router
        
        viewController.interactor = interactor
        
        return viewController
    }
}
