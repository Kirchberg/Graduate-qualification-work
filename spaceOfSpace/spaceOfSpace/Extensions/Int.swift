//
//  Int.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 01.04.2021.
//

import Foundation

extension Int {
    var toString: String {
        return String(self)
    }
    
    var degreesToRadians: Double {
        return Double(self) * .pi/180
    }
}
