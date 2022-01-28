import Foundation

protocol NLWebBrowserInteractorInput {
}

final class NLWebBrowserInteractor {
    var presenter: NLWebBrowserPresenterInput?
    var router: NLWebBrowserRouterInput?
    var worker: NLWebBrowserWorker?
    var dataSource: NLWebBrowserDataSource
    
    init(browserURL: String) {
        dataSource = NLWebBrowserDataSource(browserURL: browserURL)
    }
}

extension NLWebBrowserInteractor: NLWebBrowserInteractorProtocol {
    func viewIsReady() {
        presenter?.update(dataSource: dataSource)
    }
    
    func selected(at: CellNameProtocol) {
    }
}

extension NLWebBrowserInteractor: NLWebBrowserInteractorInput {
}
