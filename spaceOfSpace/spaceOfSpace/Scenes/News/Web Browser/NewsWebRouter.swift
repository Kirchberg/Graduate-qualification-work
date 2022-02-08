import UIKit

@objc protocol NewsWebBrowserRoutingLogic {}

protocol NewsWebBrowserDataPassing {
    var dataStore: NewsWebBrowserDataStore? { get }
}

class NewsWebBrowserRouter: NSObject, NewsWebBrowserRoutingLogic, NewsWebBrowserDataPassing {
    weak var viewController: NewsWebBrowserViewController?
    var dataStore: NewsWebBrowserDataStore?
}
