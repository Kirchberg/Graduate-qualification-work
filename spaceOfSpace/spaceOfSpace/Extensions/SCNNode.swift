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
