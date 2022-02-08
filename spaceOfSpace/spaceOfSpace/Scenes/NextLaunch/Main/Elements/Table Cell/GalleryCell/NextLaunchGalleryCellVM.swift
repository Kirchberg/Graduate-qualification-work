import UIKit

class NextLaunchGalleryCellVM: NextLaunchCellVMProtocol {
    
    var height: CGFloat = UITableView.automaticDimension
    var sectionTitle: String = "Gallery"
    var cellType: UITableViewCell.Type = NextLaunchGalleryCell.self
    var cellName: CellNameProtocol
    
    var photosURL: [URL]
    
    internal init(cellName: CellNameProtocol, photosURL: [URL]) {
        self.cellName = cellName
        self.photosURL = photosURL
    }
}
