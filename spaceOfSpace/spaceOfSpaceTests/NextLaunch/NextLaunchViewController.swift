@testable import spaceOfSpace
import XCTest
import SnapshotTesting

fileprivate typealias Resources = StringResources.NextLaunch.NextLaunchViewController

final class SnapshotNextLaunchViewController: XCTestCase {

    // MARK: - Constructors

    override func setUp() {
        super.setUp()
        nextLaunchVC = NextLaunchViewController()
        nextLaunchVC.spinnerView.alpha = 0
    }

    override func tearDown() {
        nextLaunchVC = nil
    }

    func testNextLaunchViewControllerWithShortMultipleCells() throws {
        nextLaunchVC.updateAllSections(cellVMs: shortCellVMs)
        let res = verifySnapshot(
            matching: nextLaunchVC,
            as: .image,
            named: Resources.shortMultipleCells,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    func testNextLaunchViewControllerWithNormalMultipleCells() throws {
        nextLaunchVC.updateAllSections(cellVMs: normalCellVMs)
        let res = verifySnapshot(
            matching: nextLaunchVC,
            as: .image,
            named: Resources.normalMultipleCells,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    func testNextLaunchViewControllerWithLongMultipleCells() throws {
        nextLaunchVC.updateAllSections(cellVMs: longCellVMs)
        let res = verifySnapshot(
            matching: nextLaunchVC,
            as: .image,
            named: Resources.longMultipleCells,
            record: Resources.isRecording,
            testName: Resources.testName
        )
        XCTAssertNil(res)
    }

    // MARK: - Private properties

    private var nextLaunchVC: NextLaunchViewController!
    private var shortCellVMs: [[NextLaunchCellVMProtocol]] = [
        [
            NextLaunchInfoCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .launchInfo),
                rocketTitle: StringResources.Common.shortText,
                launchServiceProviderTitle: StringResources.Common.shortText,
                launchDateWithTime: StringResources.Common.shortText
            )
        ],
        [
            NextLaunchMissionCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .mission),
                missionDescription: StringResources.Common.shortText
            )
        ],
        [
            NextLaunchGalleryCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .gallery),
                photosURL: StringResources.NextLaunch.NextLaunchGalleryCell.MockData.mockOnePhoto
            )
        ],
        [
            NextLaunchLinksCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .links),
                imageURL: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockImageLink,
                sourceTitle: StringResources.Common.shortText,
                sourceDescription: StringResources.Common.shortText,
                sourceLink: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockSourceLink
            )
        ]
    ]

    private var normalCellVMs: [[NextLaunchCellVMProtocol]] = [
        [
            NextLaunchInfoCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .launchInfo),
                rocketTitle: StringResources.Common.normalText,
                launchServiceProviderTitle: StringResources.Common.normalText,
                launchDateWithTime: StringResources.Common.normalText
            )
        ],
        [
            NextLaunchMissionCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .mission),
                missionDescription: StringResources.Common.normalText
            )
        ],
        [
            NextLaunchGalleryCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .gallery),
                photosURL: StringResources.NextLaunch.NextLaunchGalleryCell.MockData.mockTwoPhoto
            )
        ],
        [
            NextLaunchLinksCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .links),
                imageURL: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockImageLink,
                sourceTitle: StringResources.Common.normalText,
                sourceDescription: StringResources.Common.normalText,
                sourceLink: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockSourceLink
            ),
            NextLaunchLinksCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .links),
                imageURL: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockImageLink,
                sourceTitle: StringResources.Common.normalText,
                sourceDescription: StringResources.Common.normalText,
                sourceLink: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockSourceLink
            )
        ]
    ]

    private var longCellVMs: [[NextLaunchCellVMProtocol]] = [
        [
            NextLaunchInfoCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .launchInfo),
                rocketTitle: StringResources.Common.longText,
                launchServiceProviderTitle: StringResources.Common.longText,
                launchDateWithTime: StringResources.Common.longText
            )
        ],
        [
            NextLaunchMissionCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .mission),
                missionDescription: StringResources.Common.shortText
            )
        ],
        [
            NextLaunchGalleryCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .gallery),
                photosURL: StringResources.NextLaunch.NextLaunchGalleryCell.MockData.mockMultiplePhoto
            )
        ],
        [
            NextLaunchLinksCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .links),
                imageURL: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockImageLink,
                sourceTitle: StringResources.Common.longText,
                sourceDescription: StringResources.Common.longText,
                sourceLink: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockSourceLink
            ),
            NextLaunchLinksCellVM(
                cellName: NextLaunchPresenter.CommonCellName(name: .links),
                imageURL: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockImageLink,
                sourceTitle: StringResources.Common.longText,
                sourceDescription: StringResources.Common.longText,
                sourceLink: StringResources.NextLaunch.NextLaunchLinksCell.MockData.mockSourceLink
            )
        ]
    ]
}
