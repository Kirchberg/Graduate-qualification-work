import UIKit

protocol SpaceLibraryCategoriesBusinessLogic {
    func getCategories(request: SpaceLibraryCategoriesModel.Categories.Request)
}

protocol SpaceLibraryCategoriesDataStore {
    var categories: [SpaceLibraryCategory] { get set }
}

class SpaceLibraryCategoriesInteractor: SpaceLibraryCategoriesBusinessLogic, SpaceLibraryCategoriesDataStore {
    var presenter: SpaceLibraryCategoriesPresentationLogic?
    var worker: SpaceLibraryCategoriesWorker?
    
    var categories: [SpaceLibraryCategory] = []
    
    // MARK: Do something
    
    func getCategories(request: SpaceLibraryCategoriesModel.Categories.Request) {
        
        worker = SpaceLibraryCategoriesWorker()
        categories = worker?.getCategories() ?? []
        
        presenter?.presentCategories(response: SpaceLibraryCategoriesModel.Categories.Response(categories: categories))
    }
}
