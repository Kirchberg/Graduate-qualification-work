//
//  NextLaunchRouter.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit

protocol NextLaunchRouterInput {
    var transitionHandler: UIViewController? { get set }
    func openSecondScreen(withURL: String)
}

final class NextLaunchRouter {
    var transitionHandler: UIViewController?
}

extension NextLaunchRouter: NextLaunchRouterInput {
    
    func openSecondScreen(withURL stringURL: String) {
        let webBrowserVC = NLWebBrowserModule.build(withURL: stringURL)
        transitionHandler?.navigationController?.pushViewController(webBrowserVC, animated: true)
    }
}
