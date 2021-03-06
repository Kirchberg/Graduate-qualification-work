import UIKit

final class NextLaunchInfoCellVM: NextLaunchCellVMProtocol {
    
    var height: CGFloat = UITableView.automaticDimension
    var sectionTitle: String = "Launch Info"
    var cellType: UITableViewCell.Type = NextLaunchInfoCell.self
    var cellName: CellNameProtocol
    
    var rocketTitle: String
    var launchServiceProviderTitle: String
    var launchDateWithTime: String
    
    init(cellName: CellNameProtocol, rocketTitle: String, launchServiceProviderTitle: String, launchDateWithTime: String) {
        self.cellName = cellName
        self.rocketTitle = rocketTitle
        self.launchServiceProviderTitle = launchServiceProviderTitle
        self.launchDateWithTime = launchDateWithTime
    }
}
