@testable import spaceOfSpace
import XCTest
import SnapshotTesting

fileprivate typealias Resources = StringResources.SpaceLibrary.SpaceLibraryCategoryDetailedViewController

final class SnapshotSpaceLibraryCategoryDetailedViewController: XCTestCase {

    // MARK: - Constructors

    override func setUp() {
        super.setUp()
        spaceLibraryVC = SpaceLibraryCategoryDetailedViewController()
        spaceLibraryVC.spinnerView.alpha = 0
    }

    override func tearDown() {
        spaceLibraryVC = nil
    }

    func testSpaceLibraryCategoryDetailedViewControllerWithDefaultState() throws {
        spaceLibraryVC.displayTableItems(viewModel: vm)
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

    private var spaceLibraryVC: SpaceLibraryCategoryDetailedViewController!
    private var vm = SpaceLibraryCategoryDetailedModel.Articles.ViewModel(
        displayedItems: [
            SpaceLibraryArticle(
                title: StringResources.Common.shortText,
                imageName: Resources.MockData.imagePlaceholder,
                sections: nil,
                articleText: StringResources.Common.shortText
            ),
            SpaceLibraryArticle(
                title: StringResources.Common.normalText,
                imageName: Resources.MockData.imagePlaceholder,
                sections: nil,
                articleText: StringResources.Common.normalText
            ),
            SpaceLibraryArticle(
                title: StringResources.Common.longText,
                imageName: Resources.MockData.imagePlaceholder,
                sections: nil,
                articleText: StringResources.Common.longText
            ),
            SpaceLibraryArticle(
                title: StringResources.Common.longText,
                imageName: Resources.MockData.imagePlaceholder,
                sections: nil,
                articleText: StringResources.Common.longText
            ),
            SpaceLibraryArticle(
                title: StringResources.Common.longText,
                imageName: Resources.MockData.imagePlaceholder,
                sections: nil,
                articleText: StringResources.Common.longText
            ),
            SpaceLibraryArticle(
                title: StringResources.Common.longText,
                imageName: Resources.MockData.imagePlaceholder,
                sections: nil,
                articleText: StringResources.Common.longText
            )
        ]
    )
}
