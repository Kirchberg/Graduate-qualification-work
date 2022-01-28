//
//  SCNNode.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.05.2021.
//

import SceneKit

extension SCNNode {
    ///Deallocates memory for all nodes in hierarchy
    func removeAllNodes() {
        for child in childNodes {
            child.removeAllNodes()
        }
        
        removeFromParentNode()
        removeAllActions()
        geometry = nil
    }
    
    ///Removes actions for all nodes in hierarchy
    func removeAllNodesActions() {
        for child in childNodes {
            child.removeAllNodesActions()
        }
        removeAllActions()
    }
}
