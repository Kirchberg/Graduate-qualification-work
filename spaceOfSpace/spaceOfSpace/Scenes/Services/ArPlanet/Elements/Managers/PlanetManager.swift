import UIKit
import QuartzCore
import SceneKit

class PlanetManager{
    var Objects:[Planet]=[]
    var ChoosenObject: Planet? = Optional.none
    
    func addPlanet(name:String, _ newPosition: SIMD3<Float>, relativeTo cameraTransform: matrix_float4x4)->Planet?{
        guard let params=conf[name] else {
            return nil
        }
        var parent:Planet?
        if params.isSatellite{
            parent=findParent(ParentName: params.parent)
        }
        let obj=Planet.init(params: params, name: name, parent: parent, newPosition, relativeTo: cameraTransform)
        Objects.append(obj)
        return obj
    }
    
    func findParent(ParentName:String)->Planet?{
        if let parent=self.Objects.first(where: { $0.object.name == ParentName }){
            return parent
        }
        return nil
    }
    
    func findNodeInComplexObject(node:SCNNode, parent:SCNNode)->Bool{
        for child in parent.childNodes {
            if child==node{
                return true
            }
            let a=findNodeInComplexObject(node: node, parent: child)
            if a{
                return a
            }
        }
        return false
    }
    
    func setChoosenByNode(node:SCNNode){
        if let obj=self.Objects.first(where: { $0.object == node }){
            setChoosen(obj: obj)
        }
        self.Objects.forEach({
            let flag=findNodeInComplexObject(node: node, parent: $0.object)
            
            if flag{
                setChoosen(obj: $0)
                print("seted")
                return
            }
        })
        
    }
    
    func setChoosen(obj:Planet){
        if let prev=self.ChoosenObject{
            prev.object.setUnHighlighted()
        }
        obj.object.setHighlighted()
        
        self.ChoosenObject=obj
    }
}

extension SCNNode {
    func setHighlighted( _ highlighted : Bool = true, _ highlightedBitMask : Int = 3 ) {
        categoryBitMask = highlightedBitMask
        for child in self.childNodes {
            child.setHighlighted()
        }
    }
    func setUnHighlighted( _ highlighted : Bool = false, _ highlightedBitMask : Int = 200 ) {
        categoryBitMask = highlightedBitMask
        for child in self.childNodes {
            child.setUnHighlighted()
        }
    }
}
