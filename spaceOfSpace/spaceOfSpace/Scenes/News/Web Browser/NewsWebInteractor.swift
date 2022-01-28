import UIKit

protocol NewsWebBrowserBusinessLogic {
    func getHyperlink()
}

protocol NewsWebBrowserDataStore {
    var hyperlink: String? { get set }
}

class NewsWebBrowserInteractor: NewsWebBrowserBusinessLogic, NewsWebBrowserDataStore {
    var presenter: NewsWebBrowserPresentationLogic?
    var worker: NewsWebBrowserWorker?
    var hyperlink: String?
    
    func getHyperlink() {
        guard let hyperlink = hyperlink else { return }
        let url = (!hyperlink.isEmpty) ? URL(string: hyperlink) : URL(string: "https://www.google.com/")
        guard let urlToShow = url else { return }
        self.presenter?.presentHyperlink(url: urlToShow)
    }
}
