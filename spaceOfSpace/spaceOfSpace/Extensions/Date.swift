//
//  Date.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 01.04.2021.
//

import Foundation

extension Date {
    func toString(withFormat format: String = "MMMM d, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
