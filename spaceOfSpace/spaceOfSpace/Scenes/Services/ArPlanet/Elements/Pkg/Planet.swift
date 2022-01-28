//
//  Planet.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 01.04.2021.
//

import SceneKit
import SceneKit.ModelIO

class Planet {
    var object=SCNNode()
    var root=SCNNode()
    var orbitView=SCNNode()
    var titleView=SCNNode()
    var global:Planet?
    
    
    var charectiristic:SpaceObject
    var orbitRoot=SCNVector3()
    var currentAngleY: Float = 0.0
    var currentAngleX: Float = 0.0
    
    var scaleState:Float = 0
    var RadToDist:Float=3
    
    var isSpinning=true
    
    let titleConst:Float=0.09
    let pipeConst:Float=0.02
    
    private var angle:Float = 0.0
    init(params:SpaceObject, name:String, parent:Planet?, _ newPosition: SIMD3<Float>, relativeTo cameraTransform: matrix_float4x4) {
        object.name=name
        charectiristic=params
        if let p=parent{
            global=p
        }
        setupObject()
        setPosition(newPosition, relativeTo: cameraTransform, smoothMovement: false)
        animate()
//        stopSelfSpeed()
    }
    
    func setupObject(){
        if charectiristic.notRounded{
            guard let url = Bundle.main.url(forResource: charectiristic.diffuse, withExtension:charectiristic.fileExtension
                                            ,subdirectory: charectiristic.normal
            )
            else { return }
            let referenceNode = SCNReferenceNode(url: url)
            referenceNode!.load()
            object = referenceNode!
            RadToDist=charectiristic.initScale
        } else {
            object.geometry=SCNSphere(radius: CGFloat(1))
            SetDiffuse()
        }
    }

    func setupOrbit(){
        if let g=global {
            orbitView.geometry=SCNTorus(ringRadius: 0, pipeRadius:  0.0025)
            orbitView.geometry?.firstMaterial?.diffuse.contents=UIColor.systemGray
            g.object.addChildNode(orbitView)
            let action=compensation(time: TimeInterval(g.charectiristic.selfSpeed))
            orbitView.runAction(action)
        }
    }
    
    func setupText(){
        titleView.geometry=SCNText(string: object.name, extrusionDepth: 1)
        titleView.geometry?.firstMaterial?.diffuse.contents=UIColor.systemGray
        object.addChildNode(titleView)
//        let reverse = compensation(time: TimeInterval(charectiristic.selfSpeed))
//        titleView.runAction(reverse)
        titleView.geometry?.firstMaterial!.specular.contents = UIColor.white
    }
    
    func SetDiffuse(){
        object.geometry?.firstMaterial?.diffuse.contents=charectiristic.diffuse
        object.geometry?.firstMaterial?.emission.contents=charectiristic.emission
        object.geometry?.firstMaterial?.normal.contents=charectiristic.normal
        object.geometry?.firstMaterial?.specular.contents=charectiristic.specular
    }
    
    func pauseAnimation(){
        if charectiristic.notRounded == true{
            object.isPaused=false
            object.isPaused=true
        }

        object.removeAllActions()
        root.removeAllActions()
        isSpinning=false
    }
    
    func animate(){
        isSpinning=true
//        root.position=orbitRoot
        let planetRotation = setRotation(time: TimeInterval(charectiristic.selfSpeed))
        let rootRotation = setRotation(time: TimeInterval(charectiristic.orbitSpeed))
        if charectiristic.notRounded == true{
            object.isPaused=false
        } else {
            object.runAction(planetRotation)
                // root.runAction(rootRotation)
        }
        root.addChildNode(object)
        //root.addChildNode(orbitView)
        guard let g=global else {
            return
        }
        let reverse = compensation(time: TimeInterval(g.charectiristic.selfSpeed))
        root.runAction(reverse)
        g.object.addChildNode(root)
    }
    
    func setPosition(_ newPosition: SIMD3<Float>, relativeTo cameraTransform: matrix_float4x4, smoothMovement: Bool) {
        let cameraWorldPosition = cameraTransform.translation
        var positionOffsetFromCamera = newPosition - cameraWorldPosition
        
        // Limit the distance of the object from the camera to a maximum of 10 meters.
        if simd_length(positionOffsetFromCamera) > 10 {
            positionOffsetFromCamera = simd_normalize(positionOffsetFromCamera)
            positionOffsetFromCamera *= 10
        }
        
        /*
         Compute the average distance of the object from the camera over the last ten
         updates. Notice that the distance is applied to the vector from
         the camera to the content, so it affects only the percieved distance to the
         object. Averaging does _not_ make the content "lag".
         */
        if smoothMovement {
//            let hitTestResultDistance = simd_length(positionOffsetFromCamera)

            let averagedDistancePosition = simd_normalize(positionOffsetFromCamera) //* averageDistance
            root.simdPosition = cameraWorldPosition + averagedDistancePosition
        } else {
            root.simdPosition = cameraWorldPosition + positionOffsetFromCamera
        }
    }
    
    
    private func setRotation(time: TimeInterval) -> SCNAction{
        let rotation = time != 0 ? 360.degreesToRadians : 0
        let rotator = SCNAction.rotateBy(x:0, y: CGFloat(rotation), z: 0, duration: time != 0 ? time : 1)
        let foreverRotator = SCNAction.repeatForever(rotator)
        return foreverRotator
    }
    
    private func compensation(time: TimeInterval) -> SCNAction{
        let rotation = time != 0 ? -360.degreesToRadians : 0
        let rotator = SCNAction.rotateBy(x:0, y: CGFloat(rotation), z: 0, duration: time != 0 ? time : 1)
        let foreverRotator = SCNAction.repeatForever(rotator)
        
        return foreverRotator
    }
    
    func zoom(radius:CGFloat){
        let sphere=object.geometry as! SCNSphere
        sphere.radius*=radius
        if (object.name?.compare("Sun").rawValue != 0){
            object.position.x *= Float(radius)
            if let orbit=orbitView.geometry as? SCNTorus{
                orbit.ringRadius *= radius
                orbit.pipeRadius *= radius
            }
            
        }
        titleView.scale.x *= Float(radius)
        titleView.scale.y *= Float(radius)
        titleView.scale.z *= Float(radius)
        titleView.position.y *= Float(radius)
    }
    
    func changePosition(pos: SCNVector3){
        if global == nil{
            root.position=pos
        }
    }
    
    func fixRatio(radiusY:Float, radiusOrbit:Float){
        if let sphere=object.geometry as? SCNSphere{
            sphere.radius=CGFloat(radiusY*charectiristic.radiusRatio)
            titleView.position.y =  Float(sphere.radius * 1.09)
        }
        if global != nil{
            object.position.x=radiusOrbit*charectiristic.orbitRatio
            if let tor=orbitView.geometry as? SCNTorus{
                tor.ringRadius=CGFloat(object.position.x)
                tor.pipeRadius=CGFloat(pipeConst*radiusOrbit)
            }
        }
       
    }
    
    func setRadius(SunRasius:Float){
        let const=3
        if let sphere=object.geometry as? SCNSphere{
            sphere.radius=CGFloat(SunRasius*charectiristic.radiusRatio*Float(const))
            
            let (minBound, maxBound) = titleView.boundingBox
            
            
            titleView.pivot = SCNMatrix4MakeTranslation( (maxBound.x - minBound.x)/2, minBound.y, 0.02/2)
            titleView.position.y =  Float(sphere.radius * 0.09)
            
            titleView.position.z =  0.0
            titleView.scale=SCNVector3(sphere.radius*0.0025, sphere.radius*0.0025, sphere.radius*0.0025)
            constr=titleView.position.y
        }
        
    }
    
    func setScaling (distance:Float){
        if let sphere=self.object.geometry as? SCNSphere{
            sphere.radius=CGFloat(distance/Float((self.RadToDist)))
        }
        else {
            self.root.scale.x=distance/Float((self.RadToDist))
            self.root.scale.y=distance/Float((self.RadToDist))
            self.root.scale.z=distance/Float((self.RadToDist))
        }
    }
    var constr:Float=0.0
    func textStab(x:Float, y:Float){
//        titleView.position.y = constr * cos(-x)
//        titleView.position.z = constr * sin(-x)
//
//
//        titleView.eulerAngles.x = -x
////        titleView.position.y = constr * cos(-x)
////        titleView.position.x = constr * sin(-x)
//        titleView.eulerAngles.y = -y
//        //titleView.eulerAngles.z = -y - -x
        
    }
}
