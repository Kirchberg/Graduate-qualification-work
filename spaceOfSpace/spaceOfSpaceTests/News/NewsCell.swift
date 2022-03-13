@testable import spaceOfSpace
import XCTest
import SnapshotTesting

final class SnapshotNewsCell: XCTestCase {

    // MARK: - Constructors

    override func setUp() {
        super.setUp()
        containerView = UIView()
        newsCell = NewsCell()
        newsCell = newsCell.useConstraints(addToView: containerView)
        NSLayoutConstraint.activate([
            newsCell.topAnchor.constraint(equalTo: containerView.topAnchor),
            newsCell.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            newsCell.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            newsCell.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    override func tearDown() {
        containerView = nil
        newsCell = nil
    }

    func testNewsCellWithOneLineText() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 135.5)
        newsCell.newsImage.image = ImageResources.Placeholder.placeholderImage
        newsCell.newsTitle.text = StringResources.Common.shortText
        newsCell.newsContent.text = StringResources.Common.shortText
        newsCell.newsSource.text = StringResources.Common.shortText
        let res = verifySnapshot(
            matching: containerView,
            as: .image,
            named: StringResources.NewsCell.testNewsCellWithOneLineText,
            record: StringResources.NewsCell.isRecording,
            testName: StringResources.NewsCell.testName
        )
        XCTAssertNil(res)
    }

    func testNewsCellWithTwoLineText() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 146)
        newsCell.newsImage.image = ImageResources.Placeholder.placeholderImage
        newsCell.newsTitle.text = StringResources.Common.normalText
        newsCell.newsContent.text = StringResources.Common.normalText
        newsCell.newsSource.text = StringResources.Common.normalText
        let res = verifySnapshot(
            matching: containerView,
            as: .image,
            named: StringResources.NewsCell.testNewsCellWithTwoLineText,
            record: StringResources.NewsCell.isRecording,
            testName: StringResources.NewsCell.testName
        )
        XCTAssertNil(res)
    }

    func testNewsCellWithLongText() throws {
        containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 181.5)
        newsCell.newsImage.image = ImageResources.Placeholder.placeholderImage
        newsCell.newsTitle.text = StringResources.Common.longText
        newsCell.newsContent.text = StringResources.Common.longText
        newsCell.newsSource.text = StringResources.Common.longText
        let res = verifySnapshot(
            matching: containerView,
            as: .image,
            named: StringResources.NewsCell.testNewsCellWithLongText,
            record: StringResources.NewsCell.isRecording,
            testName: StringResources.NewsCell.testName
        )
        XCTAssertNil(res)
    }


    // MARK: - Private properties

    private var containerView: UIView!
    private var newsCell: NewsCell!
}
