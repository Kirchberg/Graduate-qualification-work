import UIKit

protocol SpaceLibraryTableOfContentsPresentationLogic {
    func presentTitles(sections: [SpaceLibraryArticleSection])
}

class SpaceLibraryTableOfContentsPresenter: SpaceLibraryTableOfContentsPresentationLogic {
    weak var viewController: SpaceLibraryTableOfContentsDisplayLogic?
    
    // MARK: Do something
    
    func presentTitles(sections: [SpaceLibraryArticleSection]) {
        viewController?.displayTitles(sections: sections)
    }
}
