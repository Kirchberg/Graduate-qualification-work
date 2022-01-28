//
//  SceneController.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 01.04.2021.
//

import UIKit
import ARKit
import SceneKit
import RealityKit
import Toaster



protocol ViewControllerDelegate: AnyObject
{
    func chooseObject()
    func loseObject()
}

class SceneController: ARSCNView, ARSCNViewDelegate  {
    
    var nameObj:String = "Earth"

    weak var vc:ViewControllerDelegate?
    var isChoosen=false
    let sceneView = VirtualObjectARView()
    let configuration=ARWorldTrackingConfiguration()
    let manager=PlanetManager()
    
    func setup() {
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting=true
        gestureRecognizer()
        highlinting()
    }
    
    func gestureRecognizer(){
        let createPlanet=UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer:)))
        let spinPlanet=UIPanGestureRecognizer(target: self, action: #selector(panned(recognizer:)))
        let zoomPlanet=UIPinchGestureRecognizer(target: self, action: #selector(pinched(recognizer:)))
        let movePlanet=UILongPressGestureRecognizer(target: self, action: #selector(longPressed(recognizer:)))
        
        sceneView.addGestureRecognizer(createPlanet)
        sceneView.addGestureRecognizer(spinPlanet)
        sceneView.addGestureRecognizer(zoomPlanet)
        sceneView.addGestureRecognizer(movePlanet)
    }
    
}

extension SceneController {
    @objc func pinched(recognizer: UIPinchGestureRecognizer){
        guard recognizer.view != nil else{return}
        guard manager.ChoosenObject != nil else{return}
        if recognizer.state == .began || recognizer.state == .changed{
            if let sphere=(manager.ChoosenObject!.object.geometry as? SCNSphere){
                sphere.radius *= recognizer.scale
                if Float(sphere.radius)>manager.ChoosenObject!.scaleState*1.03 || Float(sphere.radius)*1.03<manager.ChoosenObject!.scaleState{
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    manager.ChoosenObject?.scaleState=Float(sphere.radius)
                }
                let distance = simd_distance((manager.ChoosenObject?.root.simdTransform.columns.3)!, (sceneView.session.currentFrame?.camera.transform.columns.3)!);
                manager.ChoosenObject?.RadToDist=distance/Float(sphere.radius)
            } else {
                manager.ChoosenObject?.object.scale.x *= Float(recognizer.scale)
                manager.ChoosenObject?.object.scale.y *= Float(recognizer.scale)
                manager.ChoosenObject?.object.scale.z *= Float(recognizer.scale)
                if Float((manager.ChoosenObject?.object.scale.x)!)>manager.ChoosenObject!.scaleState*1.03 || Float((manager.ChoosenObject?.object.scale.x)!)*1.03<manager.ChoosenObject!.scaleState{
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    manager.ChoosenObject?.scaleState=Float((manager.ChoosenObject?.object.scale.x)!)
                }
                let distance = simd_distance((manager.ChoosenObject?.root.simdTransform.columns.3)!, (sceneView.session.currentFrame?.camera.transform.columns.3)!);
                manager.ChoosenObject?.RadToDist=distance/Float((manager.ChoosenObject?.object.scale.x)!)
            }
            recognizer.scale=1.0
        }
    }
    
    @objc func longPressed(recognizer: UILongPressGestureRecognizer){
        guard manager.ChoosenObject != nil else {
            return
        }
        
        if recognizer.state == .began{
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        if recognizer.state == .ended{
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        let results=self.sceneView.hitTest(recognizer.location(in: recognizer.view), types: ARHitTestResult.ResultType.featurePoint)
        guard let result: ARHitTestResult=results.first  else {
            return
        }
        let posintion=SCNVector3Make(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
        manager.ChoosenObject!.root.position=posintion
        let distance = simd_distance(manager.ChoosenObject!.root.simdTransform.columns.3, (sceneView.session.currentFrame?.camera.transform.columns.3)!);
        if let sphere=manager.ChoosenObject!.object.geometry as? SCNSphere{
            sphere.radius=CGFloat(distance/manager.ChoosenObject!.RadToDist)
        } else {
            manager.ChoosenObject!.object.scale.x=distance/manager.ChoosenObject!.RadToDist
            manager.ChoosenObject!.object.scale.y=distance/manager.ChoosenObject!.RadToDist
            manager.ChoosenObject!.object.scale.z=distance/manager.ChoosenObject!.RadToDist
        }
        print("Dist to planet: ", distance)
        
    }
    
    @objc func panned(recognizer: UIPanGestureRecognizer){
        guard let nodeToRotate = manager.ChoosenObject else { return }
        
        let translation = recognizer.translation(in: recognizer.view!)
        var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
        newAngleY += nodeToRotate.currentAngleY
        
        nodeToRotate.object.eulerAngles.y = newAngleY*0.3
        // nodeToRotate.root.eulerAngles.y = newAngleY*0.3
        
        var newAngleX = (Float)(translation.y)*(Float)(Double.pi)/180.0
        newAngleX += nodeToRotate.currentAngleX
        
        nodeToRotate.object.eulerAngles.x = newAngleX*0.3
        //nodeToRotate.root.eulerAngles.x = newAngleX*0.3
        
        if(recognizer.state == .ended) {
            nodeToRotate.currentAngleX = newAngleX
            nodeToRotate.currentAngleY=newAngleY
        }
    }
    
    @objc func tapped(recognizer: UIGestureRecognizer){
        if let sceneView=recognizer.view as? ARSCNView{
            let point=recognizer.location(in: sceneView)
            guard sceneView.hitTest(point, options: [SCNHitTestOption.searchMode: 1]).first != nil else {
                if !manager.Objects.isEmpty{
                    setUnhighlited()
                }
                return
            }
            sceneView.hitTest(point, options: [SCNHitTestOption.searchMode: 1]).forEach {
                print($0.node.name as Any)
                if ($0.node.name != nil){
                    let prev=manager.ChoosenObject
                    manager.setChoosenByNode(node: $0.node)
                    if prev !== manager.ChoosenObject{
                        vc?.chooseObject()
                        isChoosen=true
                    }
                }
            }
        }
    }
    
    func setUnhighlited(){
        isChoosen=false
        manager.ChoosenObject?.object.setUnHighlighted()
        vc?.loseObject()
        manager.ChoosenObject=nil
    }
    
    func setObject(_ newPosition: SIMD3<Float>, relativeTo cameraTransform: matrix_float4x4){
        let obj=manager.addPlanet(name: nameObj, newPosition, relativeTo: cameraTransform)
        if let obj=obj{
            let distance = simd_distance((obj.root.simdTransform.columns.3), (sceneView.session.currentFrame?.camera.transform.columns.3)!);
            obj.setScaling(distance: distance)
            sceneView.scene.rootNode.addChildNode(obj.root)
            
            if isChoosen{
                vc?.loseObject()
            }
            isChoosen=false
            if manager.Objects.count>=10{
                let o=manager.Objects[0]
                o.object.removeFromParentNode()
                o.orbitView.removeFromParentNode()
                o.root.removeFromParentNode()
                manager.Objects.remove(at: 0)
            }
            //  manager.setChoosen(obj: obj)
        }
        
    }
        
    
    
}


extension SceneController{
    func highlinting(){
        let scnView = self.sceneView as SCNView

        // set the scene to the view
        scnView.scene = scene

        if let path = Bundle.main.path(forResource: "NodeTechnique", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path)  {
                let dict2 = dict as! [String : AnyObject]
                let technique = SCNTechnique(dictionary:dict2)

                // set the glow color to yellow
                let color = SCNVector3(1.0, 1.0, 1.0)
                technique?.setValue(NSValue(scnVector3: color), forKeyPath: "glowColorSymbol")

                scnView.technique = technique
            }
        }
    }

}
