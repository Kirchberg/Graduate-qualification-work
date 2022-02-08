import UIKit

protocol SpaceLibraryArticleBusinessLogic{
    func getTitle()
    func getArticleText()
    func goToSection(sectionTitle: String)
}

protocol SpaceLibraryArticleDataStore{
    var title: String { get set }
    var article: SpaceLibraryArticle? { get set }
}

class SpaceLibraryArticleInteractor: SpaceLibraryArticleBusinessLogic, SpaceLibraryArticleDataStore {
    var presenter: SpaceLibraryArticlePresentationLogic?
    var worker: SpaceLibraryArticleWorker?
    var title: String = ""
    var article: SpaceLibraryArticle?
    
    
    // MARK: Do something
    
    func getTitle() {
        presenter?.setTitle(title: title)
    }
    
    func getArticleText() {
        let worker = SpaceLibraryArticleWorker()
        
        worker.fetch(articleTitle: title, success: { article in
            self.article = article.article
            self.article?.articleSections = self.parseArticleText(text: article.article?.articleText ?? "")
            self.presenter?.presentArticle(response: SpaceLibraryArticleModel.Article.Response(article: self.article))
        })
    }
    
    func goToSection(sectionTitle: String) {
        presenter?.goToSection(sectionTitle: sectionTitle)
    }
    
    func parseArticleText(text: String) -> [SpaceLibraryArticleSection] {
        var array: [SpaceLibraryArticleSection] = []
        
        let stringArray = text.componentsSeparatedByStrings(separators: ["\n=", "=\n"])
        var trimmedArray: [String] = []
        for element in stringArray {
            let trimmedString = element.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedString.count != 0 {
                trimmedArray.append(trimmedString)
            }
        }
        
        var i = 0
        while i < trimmedArray.count {
            var newSection = SpaceLibraryArticleSection()
            if trimmedArray[i].starts(with: "=") {
                
                let calcLevelArr = trimmedArray[i].components(separatedBy: "=")
                newSection.sectionLevel = (calcLevelArr.count - 1) / 2
                
                newSection.sectionTitle = trimmedArray[i].trimmingCharacters(in: CharacterSet(charactersIn: "= "))
                
                if !trimmedArray[i + 1].starts(with: "=") {
                    newSection.sectionText = trimmedArray[i + 1]
                    i += 2
                } else {
                    i += 1
                }
                
            } else {
                newSection.sectionText = trimmedArray[i]
                i += 1
            }
            
            array.append(newSection)
        }
        
        return array
    }
}
