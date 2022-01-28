import UIKit

protocol SpaceLibraryCategoriesPresentationLogic {
    func presentCategories(response: SpaceLibraryCategoriesModel.Categories.Response)
}

class SpaceLibraryCategoriesPresenter: SpaceLibraryCategoriesPresentationLogic {
    weak var viewController: SpaceLibraryCategoriesDisplayLogic?
    
    // MARK: Do something
    
    func presentCategories(response: SpaceLibraryCategoriesModel.Categories.Response) {
        let viewModel = SpaceLibraryCategoriesModel.Categories.ViewModel(displayedItems: response.categories)
        viewController?.displayCollectionItems(viewModel: viewModel)
    }
}
