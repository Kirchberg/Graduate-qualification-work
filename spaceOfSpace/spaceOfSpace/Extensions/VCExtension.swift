//
//  VCExtension.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 10.04.2021.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        // First, add the view of the child to the view of the parent
        addChild(child)
        
        // Then, add the child to the parent
        view.addSubview(child.view)
        
        // Finally, notify the child that it was moved to a parent
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        // First, notify the child that it’s about to be removed
        willMove(toParent: nil)
        
        // Then, remove the child from its parent
        removeFromParent()
        
        // Finally, remove the child’s view from the parent’s
        view.removeFromSuperview()
    }
}
