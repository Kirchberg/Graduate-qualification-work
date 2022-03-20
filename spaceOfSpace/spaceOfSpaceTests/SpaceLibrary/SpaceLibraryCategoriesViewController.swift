@testable import spaceOfSpace
import XCTest
import SnapshotTesting

fileprivate typealias Resources = StringResources.SpaceLibrary.SpaceLibraryCategoriesViewController

final class SnapshotSpaceLibraryCategoriesViewController: XCTestCase {

    // MARK: - Constructors

    override func setUp() {
        super.setUp()
        spaceLibraryVC = SpaceLibraryCategoriesViewController()
    }

    override func tearDown() {
        spaceLibraryVC = nil
    }

    func testSpaceLibraryCategoriesViewControllerWithDefaultState() throws {
        spaceLibraryVC.displayCollectionItems(
            viewModel: SpaceLibraryCategoriesModel.Categories.ViewModel(displayedItems: testCategories)
        )
        let res = verifySnapshot(
            matching: spaceLibraryVC,
            as: .image,
            named: Resources.testSpaceLibraryCategoriesViewControllerWithDefaultState,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    // MARK: - Private properties

    private var spaceLibraryVC: SpaceLibraryCategoriesViewController!
}
