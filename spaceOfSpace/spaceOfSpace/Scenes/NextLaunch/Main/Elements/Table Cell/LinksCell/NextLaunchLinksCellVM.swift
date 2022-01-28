//
//  NextLaunchLinksCellVM.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 13.05.2021.
//

import UIKit

class NextLaunchLinksCellVM: NextLaunchCellVMProtocol {
    
    var height: CGFloat = UITableView.automaticDimension
    var sectionTitle: String = "Links"
    var cellType: UITableViewCell.Type = NextLaunchLinksCell.self
    var cellName: CellNameProtocol
    
    var imageURL: URL
    var sourceTitle: String
    var sourceDescription: String
    var sourceLink: URL
    
    internal init(cellName: CellNameProtocol, imageURL: URL, sourceTitle: String, sourceDescription: String, sourceLink: URL) {
        self.cellName = cellName
        self.imageURL = imageURL
        self.sourceTitle = sourceTitle
        self.sourceDescription = sourceDescription
        self.sourceLink = sourceLink
    }
}
