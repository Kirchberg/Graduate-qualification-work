import UIKit

protocol NewsPresentationLogic {
    func presentFetchedNews(response: NewsModel.FetchNews.Response)
}

class NewsPresenter: NewsPresentationLogic {
    weak var viewController: NewsDisplayLogic?
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    func presentFetchedNews(response: NewsModel.FetchNews.Response) {
        let viewModel = NewsModel.FetchNews.ViewModel(displayedObjects: formatFetchedNews(arrayOfNews: response.news))
        viewController?.displayFetchedObjects(viewModel: viewModel)
    }
    
    private func formatFetchedNews(arrayOfNews: [News?]) -> [NewsModel.FetchNews.ViewModel.DisplayedNews] {
        var arrayOfFormattedNews = [NewsModel.FetchNews.ViewModel.DisplayedNews]()
        let recentNews = arrayOfNews
        for news in recentNews {
            if let title = news?.title, let imageURL = news?.imageURL, let content = news?.content, let source = news?.source, let datePublished = news?.datePublished, let url = news?.hyperlink {
                if !title.isEmpty, !imageURL.isEmpty, !content.isEmpty, !source.isEmpty, !datePublished.isEmpty, !url.isEmpty {
                    var date = formatTime(for: datePublished)
                    date.append("   \(source)")
                    let formatNews = NewsModel.FetchNews.ViewModel.DisplayedNews(title: title, imageURL: imageURL, content: content, datePublished: date, source: source)
                    arrayOfFormattedNews.append(formatNews)
                }
            }
        }
        return arrayOfFormattedNews
    }
    
    private func formatTime(for newsDatePublished: String) -> String {
        if let date = newsDatePublished.components(separatedBy: "T").first {
            let formattedDate = dateFormatter.date(from: date)?.toString() ?? ""
            return formattedDate
        } else {
            return ""
        }
    }
}
