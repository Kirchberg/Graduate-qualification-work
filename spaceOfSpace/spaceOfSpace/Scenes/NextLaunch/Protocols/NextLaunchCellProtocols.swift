//
//  NextLaunchCellProtocol.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 11.05.2021.
//

import UIKit

protocol CellNameProtocol {}

protocol NextLaunchCellVMProtocol {
    var height: CGFloat { get }
    var sectionTitle: String { get }
    var cellType: UITableViewCell.Type { get }
    var cellName: CellNameProtocol { get }
}

protocol CellProtocol {
    var parentViewController: UIViewController? { get set }
    static var identifier: String { get }
    func updateWith(vm: NextLaunchCellVMProtocol)
}
