//
//  SpaceLibraryCategoriesRouter.swift
//  spaceOfSpace
//
//  Created by Aleksandr Dergachev on 01.04.2021.
//

import UIKit

@objc protocol SpaceLibraryCategoriesRoutingLogic {
    func routeToCategoryDetailed()
}

protocol SpaceLibraryCategoriesDataPassing {
    var dataStore: SpaceLibraryCategoriesDataStore? { get }
}

class SpaceLibraryCategoriesRouter: NSObject, SpaceLibraryCategoriesRoutingLogic, SpaceLibraryCategoriesDataPassing {
    weak var viewController: SpaceLibraryCategoriesViewController?
    var dataStore: SpaceLibraryCategoriesDataStore?
    
    // MARK: Routing
    
    func routeToCategoryDetailed() {
        let categoryDetailedVC = SpaceLibraryCategoryDetailedViewController()
        
        guard let dataStore = dataStore else { return }
        guard var destinationDataStore = categoryDetailedVC.router?.dataStore else { return }
        
        passDataToCategoryDetailedVC(source: dataStore, destination: &destinationDataStore)
        viewController?.navigationController?.pushViewController(categoryDetailedVC, animated: true)
    }
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: SpaceLibraryViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    func passDataToCategoryDetailedVC(source: SpaceLibraryCategoriesDataStore, destination: inout SpaceLibraryCategoryDetailedDataStore) {
        guard let itemIndex = viewController?.collectionView.indexPathsForSelectedItems?[0].item else { return }
        guard let title = source.categories[itemIndex].categoryTitle else { return }
        guard let articles = source.categories[itemIndex].categoryArticleTitles else { return }
        
        destination.title = title
        destination.articleTitles = articles
    }
}
