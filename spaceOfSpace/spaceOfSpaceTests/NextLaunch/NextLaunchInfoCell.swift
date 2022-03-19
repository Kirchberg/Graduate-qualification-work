@testable import spaceOfSpace
import XCTest
import SnapshotTesting

fileprivate typealias Resources = StringResources.NextLaunch.NextLaunchInfoCell

final class SnapshotNextLaunchInfoCell: XCTestCase {

    // MARK: - Constructors

    override func setUp() {
        super.setUp()
        containerView = UIView()
        nextLaunchInfoCell = NextLaunchInfoCell()
        nextLaunchInfoCell = nextLaunchInfoCell.useConstraints(addToView: containerView)
        NSLayoutConstraint.activate([
            nextLaunchInfoCell.topAnchor.constraint(equalTo: containerView.topAnchor),
            nextLaunchInfoCell.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nextLaunchInfoCell.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nextLaunchInfoCell.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    override func tearDown() {
        containerView = nil
        nextLaunchInfoCell = nil
    }

    func testNewsCellWithOneLineText() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 178)
        nextLaunchInfoCell.rocketTitle.text = StringResources.Common.shortText
        nextLaunchInfoCell.launchServiceProviderTitle.text = StringResources.Common.shortText
        nextLaunchInfoCell.launchDateWithTime.text = StringResources.Common.shortText
        nextLaunchInfoCell.launchServiceProviderTitle.text = StringResources.Common.shortText
        let res = verifySnapshot(
            matching: containerView,
            as: .image,
            named: Resources.oneLineText,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    func testNewsCellWithLongText() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 214)
        nextLaunchInfoCell.rocketTitle.text = StringResources.Common.longText
        nextLaunchInfoCell.launchServiceProviderTitle.text = StringResources.Common.longText
        nextLaunchInfoCell.launchDateWithTime.text = StringResources.Common.longText
        nextLaunchInfoCell.launchServiceProviderTitle.text = StringResources.Common.longText
        let res = verifySnapshot(
            matching: containerView,
            as: .image,
            named: Resources.longText,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }


    // MARK: - Private properties

    private var containerView: UIView!
    private var nextLaunchInfoCell: NextLaunchInfoCell!
}
