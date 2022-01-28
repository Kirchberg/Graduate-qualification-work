//
//  SolarSystemViewController+Actions.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.05.2021.
//

import UIKit
import SceneKit

extension SolarSystemViewController: UIGestureRecognizerDelegate {
    
    // MARK: - Interface Actions

    func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        return !self.isObjectVisible
    }
    
    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
        return true
    }
}
