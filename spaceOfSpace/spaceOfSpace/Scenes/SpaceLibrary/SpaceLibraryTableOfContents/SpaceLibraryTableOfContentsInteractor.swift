import UIKit

protocol SpaceLibraryTableOfContentsBusinessLogic {
    var articleBusinessLogicDelegate: SpaceLibraryArticleBusinessLogic? { get set }
    func getArticle()
    func goToSection(sectionTitle: String)
}

protocol SpaceLibraryTableOfContentsDataStore {
    var article: SpaceLibraryArticle? { get set }
}

class SpaceLibraryTableOfContentsInteractor: SpaceLibraryTableOfContentsBusinessLogic, SpaceLibraryTableOfContentsDataStore {
    var presenter: SpaceLibraryTableOfContentsPresentationLogic?
    var worker: SpaceLibraryTableOfContentsWorker?
    var article: SpaceLibraryArticle?
    var articleBusinessLogicDelegate: SpaceLibraryArticleBusinessLogic?
    
    // MARK: Do something
    
    func getArticle() {
        presenter?.presentTitles(sections: article?.articleSections ?? [])
    }
    
    func goToSection(sectionTitle: String) {
        articleBusinessLogicDelegate?.goToSection(sectionTitle: sectionTitle)
    }
}
