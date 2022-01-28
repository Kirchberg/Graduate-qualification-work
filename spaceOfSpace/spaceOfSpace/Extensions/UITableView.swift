//
//  UITableView.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 31.03.2021.
//

import UIKit

extension UITableView {
    func deselectSelectedRow(animated: Bool) {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
    
    func dequeueCellWithClass<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: NSStringFromClass(cellClass), for: indexPath) as? T else {
            fatalError("Error: cell with identifier: \(NSStringFromClass(cellClass)) for index path: \(indexPath) is not \(T.self)")
        }
        return cell
    }
}
