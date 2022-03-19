import UIKit
import Kingfisher

protocol NextLaunchPresenterInput {
    func update(dataSource: NextLaunchDataSource)
}

final class NextLaunchPresenter {
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    enum CellName {
        case launchInfo, mission, gallery, links
    }
    
    struct CommonCellName: CellNameProtocol {
        var name: CellName
    }
    
    weak var view: (NextLaunchViewController)?
    
    var launchInfoSection = [NextLaunchCellVMProtocol]()
    var missionSection = [NextLaunchCellVMProtocol]()
    var gallerySection = [NextLaunchCellVMProtocol]()
    var linksSection = [NextLaunchCellVMProtocol]()
}

extension NextLaunchPresenter: NextLaunchPresenterInput {
    
    func update(dataSource: NextLaunchDataSource) {
        setupSections(dataSource: dataSource)
        view?.updateAllSections(
            cellVMs: [
                launchInfoSection,
                missionSection,
                gallerySection,
                linksSection
            ]
        )
    }
    
    private func setupSections(dataSource: NextLaunchDataSource) {
        setupLaunchInfoSection(dataSource: dataSource)
        setupGallerySection(dataSource: dataSource)
        setupMissionSection(dataSource: dataSource)
        setupLinksSection(dataSource: dataSource)
    }
    
    private func setupLaunchInfoSection(dataSource: NextLaunchDataSource) {
        launchInfoSection.removeAll()
        
        let nextLaunchInfo = dataSource.launchInfoSection
        
        guard let rocketTitle = nextLaunchInfo.name,
              let launchServiceProviderTitle = nextLaunchInfo.launchServiceProviderTitle,
              let launchDate = nextLaunchInfo.date
        else { return }
        
        launchInfoSection.append(
            NextLaunchInfoCellVM(
                cellName: CommonCellName(name: .launchInfo),
                rocketTitle: rocketTitle,
                launchServiceProviderTitle: launchServiceProviderTitle,
                launchDateWithTime: formatTime(for: launchDate)
            )
        )
    }
    
    private func setupMissionSection(dataSource: NextLaunchDataSource) {
        missionSection.removeAll()
        
        let mission = dataSource.missionSection
        
        guard let missionDescription = mission.missionDescription else { return }
        
        missionSection.append(
            NextLaunchMissionCellVM(
                cellName: CommonCellName(name: .mission),
                missionDescription: missionDescription
            )
        )
    }
    
    private func setupGallerySection(dataSource: NextLaunchDataSource) {
        gallerySection.removeAll()
        
        let gallery = dataSource.gallerySection
        guard let photosStringURL = gallery.galleryPhotosURL else { return }
        
        let photosURL = photosStringURL.compactMap { URL(string: $0) }
        
        gallerySection.append(
            NextLaunchGalleryCellVM(
                cellName: CommonCellName(name: .gallery),
                photosURL: photosURL
            )
        )
    }
    
    private func setupLinksSection(dataSource: NextLaunchDataSource) {
        linksSection.removeAll()
        
        let linksArray = dataSource.linksSection
        
        linksArray.forEach { link in
            
            if let linkType = link.linkType,
               let imageStringURL = link.imageURL,
               let sourceTitle = link.sourceTitle,
               let sourceDescription = link.sourceDescription,
               let browserStringURL = link.browserURL {
                
                if let imageURL = URL(string: imageStringURL),
                   !browserStringURL.isEmpty,
                   let browserURL = URL(string: browserStringURL) {
                    
                    if linkType == .wiki {
                        setTableViewBackgroundView(withURL: imageURL)
                    }
                    
                    linksSection.append(
                        NextLaunchLinksCellVM(
                            cellName: CommonCellName(name: .links),
                            imageURL: imageURL,
                            sourceTitle: sourceTitle,
                            sourceDescription: sourceDescription,
                            sourceLink: browserURL
                        )
                    )
                }
            }
        }
    }
    
    //MARK: - Private Methods
    
    private func formatTime(for launchDate: String) -> String {
        if let date = launchDate.components(separatedBy: "T").first {
            let formattedDate = dateFormatter.date(from: date)?.toString(withFormat: "MMMM d, yyyy") ?? ""
            return formattedDate
        } else {
            return ""
        }
    }
    
    //MARK: ViewController
    
    private func setTableViewBackgroundView(withURL imageURL: URL) {
        let backgroundView = UIImageView()
        backgroundView.kf.setImage(with: imageURL, options: [.transition(.fade(0.25))])
        view?.tableView.backgroundView = backgroundView
        view?.tableView.backgroundView?.contentMode = .scaleAspectFill
        view?.tableView.backgroundView?.alpha = 0.2
    }
}
