////
////  SolARSceneController.swift
////  spaceOfSpace
////
////  Created by Daniil Tchyorny on 12.04.2021.
////
//
//import UIKit
//import SceneKit
//import ARKit
//
//class SolARSceneController: ARSCNView, ARSCNViewDelegate, ARSessionDelegate  {
//    let sys = SystemManager()
//    let sceneView = ARSCNView()
//    let configuration=ARWorldTrackingConfiguration()
//    func setup() {
//        self.sceneView.debugOptions=[ARSCNDebugOptions.showFeaturePoints]
//        self.sceneView.session.run(configuration)
//        self.sceneView.autoenablesDefaultLighting=true
//        sceneView.delegate = self
//        sceneView.session.delegate = self
//        sceneView.delegate = self
//        gestureRecognizer()
//        // Set the scene to the view
//        //rotationButton()
//    }
//
//    @objc func stopSpinning(_ button: UIButton){
//
//        if button.titleLabel?.text=="Pause"{
//            button.setTitle("Run", for: .normal)
//            sys.Solar.forEach({
//                $0.root.removeAllActions()
//                $0.object.removeAllActions()
//
//            })
//        } else {
//            button.setTitle("Pause", for: .normal)
//            sys.Solar.forEach({
//                $0.animate()
//            })
//        }
//    }
//
//
//
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        // Present an error message to the user
//
//    }
//
//    func sessionWasInterrupted(_ session: ARSession) {
//        // Inform the user that the session has been interrupted, for example, by presenting an overlay
//
//    }
//
//    func sessionInterruptionEnded(_ session: ARSession) {
//        // Reset tracking and/or remove existing anchors if consistent tracking is required
//
//    }
//
//    func gestureRecognizer(){
//        let createPlanet=UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer:)))
//        let spinPlanet=UIPanGestureRecognizer(target: self, action: #selector(panned(recognizer:)))
//        let zoomPlanet=UIPinchGestureRecognizer(target: self, action: #selector(pinched(recognizer:)))
//        let movePlanet=UILongPressGestureRecognizer(target: self, action: #selector(longPressed(recognizer:)))
//
//
//        sceneView.addGestureRecognizer(createPlanet)
//        sceneView.addGestureRecognizer(spinPlanet)
//        sceneView.addGestureRecognizer(zoomPlanet)
//        sceneView.addGestureRecognizer(movePlanet)
//    }
//
//    @objc func pinched(recognizer: UIPinchGestureRecognizer){
//        guard recognizer.view != nil else{return}
//        guard sys.Solar.first != nil else{return}
//        if recognizer.state == .began || recognizer.state == .changed{
//            if let sphere=(sys.Solar.first!.object.geometry as? SCNSphere){
//                sys.ZoomSystem(radius: recognizer.scale)
//                if Float(sphere.radius)>sys.Solar.first!.scaleState * 1.03 || Float(sphere.radius)*1.03<sys.Solar.first!.scaleState{
//                        let generator = UIImpactFeedbackGenerator(style: .light)
//                        generator.impactOccurred()
//                    sys.Solar.first!.scaleState=Float(sphere.radius)
//                    }
//                let distance = simd_distance((sys.Solar.first?.object.simdTransform.columns.3)!, (sceneView.session.currentFrame?.camera.transform.columns.3)!);
//                sys.Solar.first!.RadToDist=distance/Float(sphere.radius)
//            }
//            recognizer.scale=1.0
//        }
//    }
//
//    @objc func longPressed(recognizer: UILongPressGestureRecognizer){
//        guard sys.Solar.first != nil else {
//            return
//        }
//        if recognizer.state == .began{
//            let generator = UIImpactFeedbackGenerator(style: .medium)
//            generator.impactOccurred()
//        }
//        if recognizer.state == .ended{
//            let generator = UIImpactFeedbackGenerator(style: .light)
//            generator.impactOccurred()
//        }
//        let results=sceneView.hitTest(recognizer.location(in: recognizer.view), types: ARHitTestResult.ResultType.featurePoint)
//        guard let result: ARHitTestResult=results.first  else {
//            return
//        }
//        let posintion=SCNVector3Make(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
//        sys.Solar.first?.root.position=posintion
//        let distance = simd_distance((sys.Solar.first?.root.simdTransform.columns.3)!, (sceneView.session.currentFrame?.camera.transform.columns.3)!);
//        sys.fixRatio(radiusY: distance/sys.Solar.first!.RadToDist, radiusOrbit: distance/sys.Solar.first!.RadToDist)
//    }
//
//    @objc func panned(recognizer: UIPanGestureRecognizer){
//        guard let nodeToRotate = sys.Solar.first else { return }
//
//       let translation = recognizer.translation(in: recognizer.view!)
//        var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
//        newAngleY += sys.Solar.first!.currentAngleY
//
//        nodeToRotate.object.eulerAngles.y = newAngleY*0.3
//       // nodeToRotate.root.eulerAngles.y = newAngleY*0.3
//
//        var newAngleX = (Float)(translation.y)*(Float)(Double.pi)/180.0
//        newAngleX += sys.Solar.first!.currentAngleX
//
//        nodeToRotate.object.eulerAngles.x = newAngleX*0.3
//
//        //nodeToRotate.root.eulerAngles.x = newAngleX*0.3
//
//        if(recognizer.state == .ended) {
//            sys.Solar.first!.currentAngleX = newAngleX
//            sys.Solar.first!.currentAngleY=newAngleY
//        }
//        sys.stabText(x: newAngleX*0.3, y:newAngleY*0.3)
//    }
//
//    @objc func tapped(recognizer: UIGestureRecognizer){
//        if let sceneView=recognizer.view as? ARSCNView{
//            let point=recognizer.location(in: sceneView)
//            let hitResult=sceneView.hitTest(point, types: .featurePoint)
//                if let first=hitResult.first{
//                    let trasform=first.worldTransform
//                    let pos=SCNVector3(x: trasform.columns.3.x, y: trasform.columns.3.y, z: trasform.columns.3.z)
//                    if sys.Solar.first == nil{
//                        sys.setup(name: "Sun", pos: pos, radius: 0)
//                        sys.setPlanets()
//                        sys.setRadius(SunRadius: 1)
//                        sceneView.scene.rootNode.addChildNode(sys.Solar.first!.root)
//                    }
//                    sys.SetPosition(pos: pos)
//                    let distance = simd_distance((sys.Solar.first?.root.simdTransform.columns.3)!, (sceneView.session.currentFrame?.camera.transform.columns.3)!)
//                    sys.fixRatio(radiusY: distance/sys.Solar.first!.RadToDist, radiusOrbit: distance/sys.Solar.first!.RadToDist)
//                }
//        }
//    }
//}
