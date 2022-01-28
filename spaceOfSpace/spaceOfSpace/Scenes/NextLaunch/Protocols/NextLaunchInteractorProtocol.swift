//
//  NextLaunchInteractorProtocol.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 14.05.2021.
//

import Foundation

protocol NextLaunchInteractorProtocol {
    func viewIsReady()
    func selected(with: CellNameProtocol, didSelectRowAt indexPath: Int)
}
