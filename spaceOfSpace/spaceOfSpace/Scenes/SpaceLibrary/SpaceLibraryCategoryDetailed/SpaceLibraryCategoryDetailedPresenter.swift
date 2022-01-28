import UIKit

protocol SpaceLibraryCategoryDetailedPresentationLogic {
    func presentArticles(response: SpaceLibraryCategoryDetailedModel.Articles.Response)
    func setTitle(title: String)
}

class SpaceLibraryCategoryDetailedPresenter: SpaceLibraryCategoryDetailedPresentationLogic {
    weak var viewController: SpaceLibraryCategoryDetailedDisplayLogic?
    
    // MARK: Do something
    
    func presentArticles(response: SpaceLibraryCategoryDetailedModel.Articles.Response) {
        let articles = response.articles.compactMap { $0 }

        let viewModel = SpaceLibraryCategoryDetailedModel.Articles.ViewModel(displayedItems: articles)
        viewController?.displayTableItems(viewModel: viewModel)
    }
    
    func setTitle(title: String) {
        viewController?.updateTitle(title: title)
    }
}
