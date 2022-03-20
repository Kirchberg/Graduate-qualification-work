@testable import spaceOfSpace
import XCTest
import SnapshotTesting

fileprivate typealias Resources = StringResources.SpaceLibrary.SpaceLibraryArticleViewController

final class SnapshotSpaceLibraryArticleViewController: XCTestCase {

    // MARK: - Constructors

    override func setUp() {
        super.setUp()
        spaceLibraryVC = SpaceLibraryArticleViewController()
    }

    override func tearDown() {
        spaceLibraryVC = nil
    }

    func testSpaceLibraryArticleViewControllerWithDefaultState() throws {
        spaceLibraryVC.displayArticles(viewModel: vm)
        let res = verifySnapshot(
            matching: spaceLibraryVC,
            as: .image,
            named: Resources.testSpaceLibraryCategoryDetailedViewControllerWithDefaultState,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    // MARK: - Private properties

    private var spaceLibraryVC: SpaceLibraryArticleViewController!
    private var vm = SpaceLibraryArticleModel.Article.ViewModel(
        displayedItems: SpaceLibraryArticle(
            title: StringResources.Common.shortText,
            imageName: Resources.MockData.imagePlaceholder,
            sections: [
                SpaceLibraryArticleSection(
                    title: StringResources.Common.longText,
                    text: StringResources.Common.shortText
                ),
                SpaceLibraryArticleSection(
                    title: StringResources.Common.normalText,
                    text: StringResources.Common.normalText
                ),
                SpaceLibraryArticleSection(
                    title: StringResources.Common.shortText,
                    text: StringResources.Common.longText
                ),
                SpaceLibraryArticleSection(
                    title: StringResources.Common.shortText,
                    text: StringResources.Common.longText
                )
            ],
            articleText: StringResources.Common.longText
        )
    )
}
