////
////  SystemManager.swift
////  spaceOfSpace
////
////  Created by Daniil Tchyorny on 12.04.2021.
////
//import SceneKit
//class SystemManager{
//    var Solar:[Planet]=[]
//    init()  {
//
//    }
//    
//    func setup(name:String, pos:SCNVector3, radius:Float){
//        guard let params=conf[name] else {
//            return
//        }
//        var parent:Planet?
//        if params.isSatellite{
//            parent=findParent(ParentName: params.parent)
//        }
//        let obj=Planet.init(params: params, name: name, pos: pos, parent: parent)
//
//        Solar.append(obj)
//    }
//
//    func findParent(ParentName:String)->Planet?{
//        if let parent=self.Solar.first(where: { $0.object.name == ParentName }){
//            return parent
//        }
//        return nil
//    }
//
//    func setPlanets(){
//        var center = SCNVector3()
//        center.x=0
//        center.y=0
//        center.z=0
//
//        guard let sun = Solar.first else {
//            return
//        }
//
//        if let params=conf["Mercury"]{
//            let planet=Planet.init(params: params, name: "Mercury", pos: SCNVector3(0, 0, 0), parent: sun)
//            Solar.append(planet)
//        } else {print("Could not find Mercury")}
//
//        if let params=conf["Venus"]{
//            let planet=Planet.init(params: params, name: "Venus", pos: SCNVector3(0, 0, 0), parent: sun)
//            Solar.append(planet)
//        }else {print("Could not find Venus")}
//
//        if let params=conf["Earth"]{
//            let planet=Planet.init(params: params, name: "Earth", pos: SCNVector3(0, 0, 0), parent: sun)
//            Solar.append(planet)
//            if let par=conf["Moon"]{
//                let moon=Planet.init(params: par, name: "Moon", pos: SCNVector3(0, 0, 0), parent: planet)
//                Solar.append(moon)
//            }else{print("Could not find Moon")}
//
//        }else {print("Could not find Earth")}
//
//
//        if let params=conf["Mars"]{
//            let planet=Planet.init(params: params, name: "Mars", pos: SCNVector3(0, 0, 0), parent: sun)
//            Solar.append(planet)
//        }else {print("Could not find Mars")}
//
//
//        if let params=conf["Jupiter"]{
//            let planet=Planet.init(params: params, name: "Jupiter", pos: SCNVector3(0, 0, 0), parent: sun)
//            Solar.append(planet)
//        }else {print("Could not find Jupiter")}
//
//        if let params=conf["Saturn"]{
//            let planet=Planet.init(params: params, name: "Saturn", pos: SCNVector3(0, 0, 0), parent: sun)
//            Solar.append(planet)
//        }else {print("Could not find Saturn")}
//
//        if let params=conf["Uranus"]{
//            let planet=Planet.init(params: params, name: "Uranus", pos: SCNVector3(0, 0, 0), parent: sun)
//            Solar.append(planet)
//        }else {print("Could not find Uran")}
//
//        if let params=conf["Neptun"]{
//            let planet=Planet.init(params: params, name: "Neptun", pos: SCNVector3(0, 0, 0), parent: sun)
//            Solar.append(planet)
//        }else {print("Could not find Neptun")}
//        showOrbit()
//        showText()
//    }
//
//    func setRadius(SunRadius:Float){
//        Solar.forEach({
//            $0.setRadius(SunRasius: SunRadius)
//        })
//    }
//
//    func SetPosition(pos:SCNVector3){
//        Solar.first?.changePosition(pos: pos)
//    }
//
//
//    func ZoomSystem(radius:CGFloat){
//        Solar.forEach({
//            $0.zoom(radius: radius)
//        })
//    }
//
//    func fixRatio(radiusY:Float, radiusOrbit:Float){
//        Solar.forEach({
//            $0.fixRatio(radiusY: radiusY, radiusOrbit: radiusOrbit)
//        })
//    }
//
//    func showOrbit(){
//        Solar.forEach({
//            $0.setupOrbit()
//        })
//    }
//
//    func showText(){
//        Solar.forEach({
//            $0.setupText()
//        })
//    }
//
//    func stabText(x:Float, y:Float){
//        Solar.forEach({
//            $0.textStab(x: x, y: y)
//        })
//    }
//}
