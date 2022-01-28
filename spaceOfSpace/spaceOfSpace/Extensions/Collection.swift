//
//  Collection.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.05.2021.
//

import Foundation

extension Collection where Iterator.Element == Float {
    /// Return the mean of a list of Floats. Used with `recentVirtualObjectDistances`.
    var average: Float? {
        guard !isEmpty else {
            return nil
        }
        
        let sum = reduce(Float(0)) { current, next -> Float in
            return current + next
        }
        
        return sum / Float(count)
    }
}
