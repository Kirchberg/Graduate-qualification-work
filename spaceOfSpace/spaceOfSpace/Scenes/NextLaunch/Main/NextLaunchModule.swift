//
//  NextLaunchModule.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 14.05.2021.
//

import Foundation

final class NextLaunchModule {
    
    static func build() -> NextLaunchViewController {
        
        let viewController = NextLaunchViewController()
        
        let router = NextLaunchRouter()
        router.transitionHandler = viewController
        
        let presenter = NextLaunchPresenter()
        presenter.view = viewController
        
        let interactor = NextLaunchInteractor()
        interactor.presenter = presenter
        interactor.router = router
        
        viewController.interactor = interactor
        
        return viewController
    }
}
