import UIKit

extension String {
    func componentsSeparatedByStrings(separators: [String]) -> [String] {
        return separators.reduce([self]) { result, separator in
            return result.flatMap { $0.components(separatedBy: separator) }
        }
        .map { $0.trimmingCharacters(in: .whitespaces) }
    }
}

protocol SpaceLibraryArticlePresentationLogic {
    func presentArticle(response: SpaceLibraryArticleModel.Article.Response)
    func setTitle(title: String)
    func goToSection(sectionTitle: String)
}

class SpaceLibraryArticlePresenter: SpaceLibraryArticlePresentationLogic {
    weak var viewController: SpaceLibraryArticleDisplayLogic?
    
    // MARK: Do something
    
    func presentArticle(response: SpaceLibraryArticleModel.Article.Response) {
        guard let article = response.article else { return }
        
        let viewModel = SpaceLibraryArticleModel.Article.ViewModel(displayedItems: article)
        
        viewController?.displayBackgroundImage(viewModel: viewModel)
        viewController?.displayArticles(viewModel: viewModel)
    }
    
    func setTitle(title: String) {
        viewController?.updateTitle(title: title)
    }
    
    func goToSection(sectionTitle: String) {
        viewController?.goToSection(sectionTitle: sectionTitle)
    }
}
