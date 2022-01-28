//
//  PlanetLoop.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.05.2021.
//

import Foundation
import SceneKit

class PlanetLoop: SCNNode {
    
    init(planet: PlanetEnum) {
        super.init()
        self.opacity = 0.4;
        self.geometry = SCNBox(width: 0.55, height: 0, length: 0.55, chamferRadius: 0)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "saturn_loop")
        self.rotation = SCNVector4Make(0, 0, 1, Float(30.degreesToRadians));
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
