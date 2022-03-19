@testable import spaceOfSpace
import XCTest
import SnapshotTesting

fileprivate typealias Resources = StringResources.NextLaunch.NextLaunchGalleryCell

final class SnapshotNextLaunchGalleryCell: XCTestCase {

    // MARK: - Constructors

    override func setUp() {
        super.setUp()
        containerView = UIView()
        nextLaunchGalleryCell = NextLaunchGalleryCell()
        nextLaunchGalleryCell = nextLaunchGalleryCell.useConstraints(addToView: containerView)
        NSLayoutConstraint.activate([
            nextLaunchGalleryCell.topAnchor.constraint(equalTo: containerView.topAnchor),
            nextLaunchGalleryCell.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nextLaunchGalleryCell.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nextLaunchGalleryCell.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    override func tearDown() {
        containerView = nil
        nextLaunchGalleryCell = nil
    }

    func testNextLaunchGalleryCellWithOnePhoto() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 143.5)
        nextLaunchGalleryCell.galleryPhotosURL = Resources.MockData.mockOnePhoto
        let res = verifySnapshot(
            matching: containerView,
            as: .image,
            named: Resources.onePhoto,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    func testNextLaunchGalleryCellWithTwoPhoto() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 143.5)
        nextLaunchGalleryCell.galleryPhotosURL = Resources.MockData.mockTwoPhoto
        let res = verifySnapshot(
            matching: containerView,
            as: .image,
            named: Resources.twoPhoto,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    func testNextLaunchGalleryCellWithMultiplePhoto() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 143.5)
        nextLaunchGalleryCell.galleryPhotosURL = Resources.MockData.mockMultiplePhoto
        let res = verifySnapshot(
            matching: containerView,
            as: .image,
            named: Resources.multiplePhoto,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }


    // MARK: - Private properties

    private var containerView: UIView!
    private var nextLaunchGalleryCell: NextLaunchGalleryCell!
}
