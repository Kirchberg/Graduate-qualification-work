//
//  NextLaunchWorker.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit

final class NextLaunchWorker {
    
    let nextLaunchManager = NextLaunchAPIService()
    
    func requestNextLaunch(success: @escaping (NextLaunchDataSource?)->()) {
        nextLaunchManager.requestNextLaunch { data in
            success(data)
        }
    }
}
