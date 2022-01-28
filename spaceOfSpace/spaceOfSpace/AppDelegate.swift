//
//  AppDelegate.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let customTabBarController = CustomTabBarController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = customTabBarController
        window?.makeKeyAndVisible()
        return true
    }
}
