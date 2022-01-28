//
//  CustomTabBarController.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    private var tabNextLaunchViewController: VerticalNavigationController?
    private var tabNewsViewController: VerticalNavigationController?
    private var tabServicesViewController: VerticalNavigationController?
    private var tabSpaceLibraryViewController: VerticalNavigationController?
    private var subviewControllers: [VerticalNavigationController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        setupTabBarUI()
    }
    
    private func setupVCs() {
        tabNextLaunchViewController = VerticalNavigationController(rootViewController: NextLaunchModule.build())
        tabNewsViewController = VerticalNavigationController(rootViewController: NewsViewController())
        tabServicesViewController = VerticalNavigationController(rootViewController: ServicesViewController())
        tabSpaceLibraryViewController = VerticalNavigationController(rootViewController: SpaceLibraryCategoriesViewController())
        
        setupNavigationController(title: "Next Launch", navigationVC: tabNextLaunchViewController!)
        setupNavigationController(title: "News", navigationVC: tabNewsViewController!)
        setupNavigationController(title: "Services", navigationVC: tabServicesViewController!)
        setupNavigationController(title: "Space Library", navigationVC: tabSpaceLibraryViewController!)
        
        subviewControllers.append(tabNextLaunchViewController!)
        subviewControllers.append(tabNewsViewController!)
        subviewControllers.append(tabServicesViewController!)
        subviewControllers.append(tabSpaceLibraryViewController!)
        
        setupItems()
        
        self.setViewControllers(subviewControllers, animated: true)
        
        self.selectedIndex = 1
        self.selectedViewController = tabNewsViewController
    }
    
    private func setupItems() {
        let itemNextLaunch = UITabBarItem(title: "Next Launch", image: UIImage(named: "nextlaunch_default"), selectedImage: UIImage(named: "nextlaunch_selected.svg"))
        itemNextLaunch.tag = 0
        tabNextLaunchViewController?.tabBarItem = itemNextLaunch
        
        let itemNews = UITabBarItem(title: "News", image: UIImage(named: "news_default"), selectedImage: UIImage(named: "news_selected"))
        itemNextLaunch.tag = 1
        tabNewsViewController?.tabBarItem = itemNews
        
        let itemServices = UITabBarItem(title: "Services", image: UIImage(named: "services_default"), selectedImage: UIImage(named: "services_selected"))
        itemNextLaunch.tag = 2
        tabServicesViewController?.tabBarItem = itemServices
        
        let itemSpaceLibrary = UITabBarItem(title: "Space Library", image: UIImage(named: "spacelibrary_default"), selectedImage: UIImage(named: "spacelibrary_selected"))
        itemNextLaunch.tag = 3
        tabSpaceLibraryViewController?.tabBarItem = itemSpaceLibrary
    }
    
    private func setupTabBarUI() {
        UITabBar.appearance().barTintColor = UIColor(red: 0.086, green: 0.086, blue: 0.086, alpha: 0.94)
        UITabBar.appearance().isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Medium", size: 10)!, NSAttributedString.Key.foregroundColor: UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)], for: .normal)
    }
    
    private func setupNavigationController(title: String, navigationVC: VerticalNavigationController) {
        navigationVC.navigationBar.topItem?.title = title
        navigationVC.navigationBar.isTranslucent = false
        navigationVC.navigationBar.prefersLargeTitles = true
        navigationVC.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 0.114, green: 0.114, blue: 0.114, alpha: 0.94)
        navigationVC.navigationBar.standardAppearance = appearance
        navigationVC.navigationBar.scrollEdgeAppearance = appearance
    }
}
