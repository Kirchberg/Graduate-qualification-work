//
//  NextLaunchMissionCellVM.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 13.05.2021.
//

import UIKit

class NextLaunchMissionCellVM: NextLaunchCellVMProtocol {
    
    var height: CGFloat = UITableView.automaticDimension
    var sectionTitle: String = "Mission Description"
    var cellType: UITableViewCell.Type = NextLaunchMissionCell.self
    var cellName: CellNameProtocol
    
    var missionDescription: String
    
    internal init(cellName: CellNameProtocol, missionDescription: String) {
        self.cellName = cellName
        self.missionDescription = missionDescription
    }
}
