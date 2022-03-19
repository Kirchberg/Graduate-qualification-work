@testable import spaceOfSpace
import XCTest
import SnapshotTesting

fileprivate typealias Resources = StringResources.News.NewsViewController

final class SnapshotNewsViewController: XCTestCase {

    // MARK: - Constructors

    override func setUp() {
        super.setUp()
        newsVC = NewsViewController()
    }

    override func tearDown() {
        newsVC = nil
    }

    func testNewsViewControllerWithMultipleCells() throws {
        newsVC.displayFetchedObjects(viewModel: displayedCells)
        let res = verifySnapshot(
            matching: newsVC,
            as: .image,
            named: Resources.testNewsViewControllerWithMultipleCells,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    // MARK: - Private properties

    private var newsVC: NewsViewController!
    private let displayedCells = NewsModel.FetchNews.ViewModel(
        displayedObjects: [
            NewsModel.FetchNews.ViewModel.DisplayedNews(
                title: StringResources.Common.longText,
                imageURL: "http://via.placeholder.com/105x85",
                content: StringResources.Common.longText,
                datePublished: StringResources.Common.longText,
                source: StringResources.Common.longText
            ),
            NewsModel.FetchNews.ViewModel.DisplayedNews(
                title: StringResources.Common.normalText,
                imageURL: "http://via.placeholder.com/105x85",
                content: StringResources.Common.normalText,
                datePublished: StringResources.Common.normalText,
                source: StringResources.Common.normalText
            ),
            NewsModel.FetchNews.ViewModel.DisplayedNews(
                title: StringResources.Common.shortText,
                imageURL: "http://via.placeholder.com/105x85",
                content: StringResources.Common.shortText,
                datePublished: StringResources.Common.shortText,
                source: StringResources.Common.shortText
            ),
            NewsModel.FetchNews.ViewModel.DisplayedNews(
                title: StringResources.Common.longText,
                imageURL: "http://via.placeholder.com/105x85",
                content: StringResources.Common.longText,
                datePublished: StringResources.Common.longText,
                source: StringResources.Common.longText
            )
        ]
    )
}
