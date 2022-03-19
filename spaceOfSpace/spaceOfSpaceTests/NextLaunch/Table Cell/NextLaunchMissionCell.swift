@testable import spaceOfSpace
import XCTest
import SnapshotTesting

fileprivate typealias Resources = StringResources.NextLaunch.NextLaunchMissionCell

final class SnapshotNextLaunchMissionCell: XCTestCase {

    // MARK: - Constructors

    override func setUp() {
        super.setUp()
        containerView = UIView()
        nextLaunchMissionCell = NextLaunchMissionCell()
        nextLaunchMissionCell = nextLaunchMissionCell.useConstraints(addToView: containerView)
        NSLayoutConstraint.activate([
            nextLaunchMissionCell.topAnchor.constraint(equalTo: containerView.topAnchor),
            nextLaunchMissionCell.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nextLaunchMissionCell.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nextLaunchMissionCell.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    override func tearDown() {
        containerView = nil
        nextLaunchMissionCell = nil
    }

    func testNextLaunchMissionCellWithOneLineText() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 41)
        nextLaunchMissionCell.missionDescription.text = StringResources.Common.shortText
        let res = verifySnapshot(
            matching: containerView,
            as: .image,
            named: Resources.oneLineText,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    func testNextLaunchMissionCellWithLongText() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 487.5)
        nextLaunchMissionCell.missionDescription.text = StringResources.Common.longText
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
    private var nextLaunchMissionCell: NextLaunchMissionCell!
}
