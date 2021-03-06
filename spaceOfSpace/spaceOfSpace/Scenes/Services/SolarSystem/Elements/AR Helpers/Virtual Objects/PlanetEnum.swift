//
//  PlanetEnum.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.05.2021.
//

import UIKit

enum PlanetEnum {

    case sun
    case mercury
    case venus
    case earth
    case moon
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    
    func getPlanet() -> SolarPlanet {
        
        switch self {
        case .sun:
            return SolarPlanet(radius: 0.1, diffuse: #imageLiteral(resourceName: "sun"), specular: nil, emission: #imageLiteral(resourceName: "sun"), normal: nil, anxisTime: 0, revolTime: 0, distance: 0, hasChild: true)
        case .mercury:
            return SolarPlanet(radius: 0.02, diffuse: #imageLiteral(resourceName: "mercury.jpg"), anxisTime: 10, revolTime: 12, distance: 0.4)
        case .venus:
            return SolarPlanet(radius: 0.04, diffuse: #imageLiteral(resourceName: "venus"), anxisTime: 12, revolTime: 14, distance: 0.6)
        case .earth:
            return SolarPlanet(radius: 0.05, diffuse: #imageLiteral(resourceName: "earth_diffuse"), specular: #imageLiteral(resourceName: "earth_specular"), emission: #imageLiteral(resourceName: "earth-emissive"), normal: nil, anxisTime: 16, revolTime: 18, distance: 0.8, hasChild:true)
        case .moon:
            return SolarPlanet(radius: 0.01, diffuse: #imageLiteral(resourceName: "moon"), specular: nil, emission: nil, normal: nil, anxisTime: 2, revolTime: 6, distance: 0.1)
        case .mars:
            return SolarPlanet(radius: 0.03, diffuse: #imageLiteral(resourceName: "mars"), specular: nil, emission: nil, normal: nil, anxisTime: 14, revolTime: 16, distance: 1.0)
        case .jupiter:
            return SolarPlanet(radius: 0.15, diffuse: #imageLiteral(resourceName: "jupiter"), specular: nil, emission: nil, normal: nil, anxisTime: 24, revolTime: 28, distance: 1.4)
        case .saturn:
            return SolarPlanet(radius: 0.12, diffuse: #imageLiteral(resourceName: "saturn"), specular: nil, emission: nil, normal: nil, anxisTime: 32, revolTime: 30, distance: 1.68, hasChild:true)
        case .uranus:
            return SolarPlanet(radius: 0.09, diffuse: #imageLiteral(resourceName: "uranus"), specular: nil, emission: nil, normal: nil, anxisTime: 20, revolTime: 32, distance: 1.95)
        case .neptune:
            return SolarPlanet(radius: 0.08, diffuse: #imageLiteral(resourceName: "neptune"), specular: nil, emission: nil, normal: nil, anxisTime: 28, revolTime: 36, distance: 2.14)
        }
    }
}
