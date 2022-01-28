//
//  VerticalViewController.swift
//  spaceOfSpace
//
//  Created by d.chernyi on 06.05.2021.
//

import UIKit

class VerticalViewController: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

class VerticalNavigationController: UINavigationController{
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
