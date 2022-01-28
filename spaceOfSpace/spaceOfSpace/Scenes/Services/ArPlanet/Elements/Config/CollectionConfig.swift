//
//  CollectionConfig.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 10.04.2021.
//
import Foundation
struct ConfigCollection {
    var sizeOfFirstCell:Int
    var showNavbar: Bool
    var image:[String]
    var text:[String]
    var hasCustomCells:Bool
    var nextCollections:[String]
    var items:[String]
    var viewTitle:String
    var parentTitle:String
}

var collections=[
    "main" :ConfigCollection(sizeOfFirstCell: 177,
                             showNavbar: false,
                             image: ["planet", "rocket", "engine", "staff"],
                             text: ["Stars and Planets", "Rockets", "Engines", "Space   staff"],
                             hasCustomCells: false,
                             nextCollections: ["planet", "rocket", "engine", "staff"],
                             items:[],
                             viewTitle: "Categories",
                             parentTitle: ""
    ),
    "planet" :ConfigCollection(sizeOfFirstCell: 177,
                               showNavbar: true,
                               image: ["SunPromo", "MercuryPromo", "VenusPromo", "EarthPromo", "MoonPromo", "MarsPromo", "JupiterPromo", "SaturnPromo", "UranusPromo", "NeptunPromo"],
                               text: ["Sun", "Mercury", "Venus", "Earth", "Moon", "Mars", "Jupiter", "Saturn", "Uranus", "Neptun"],
                               
                               hasCustomCells: false,
                               nextCollections: [],
                               items:["Sun", "Mercury", "Venus", "Earth", "Moon", "Mars", "Jupiter", "Saturn", "Uranus", "Neptun"],
                               viewTitle: "Stars ans planets",
                               parentTitle: "Categories"
                        
    ),
    "rocket" :ConfigCollection(sizeOfFirstCell: 177,
                               showNavbar: true,
                               image: ["falcone9Promo", "falcon1Promo", "falconHeavyPromo", "shuttlePromo", "saturnvPromo", "soyuzfgPromo", "vostok1Promo"],
                               text: ["Falcon 9", "Falcon 1", "Falcon Heavy", "Space Shuttle", "Saturn V", "Soyuz FG", "Vostok 1"],
                               hasCustomCells: false,
                               nextCollections: [],
                               items:["falcon9", "falcon1", "falconHeavy", "shuttle", "Saturn5", "Soyuz-FG", "Vostok-1"],
                               viewTitle: "Rockets",
                               parentTitle: "Categories"
    ),
    "engine" :ConfigCollection(sizeOfFirstCell: 177,
                               showNavbar: true,
                               image: ["engine.rd180Promo", "engine.1dPromo", "engine.1dvacuumPromo", "engine.be-4Promo", "engine.f1Promo", "engine.raptorPromo", "engine.rs25Promo", "engine.tdj2sPromo"],
                               text: ["RD-180", "Merlin 1D", "Merlin 1D Vacuum", "BE-4", "F1", "Raptor", "RS-25", "TD-J 2S"],
                               hasCustomCells: false,
                               nextCollections: [],
                               items:["rd-180", "1D", "1DVacuum", "be-4", "F1", "Raptor", "RS-25", "TDJ2S"],
                               viewTitle: "Engines",
                               parentTitle: "Categories"
    ),
    "staff" :ConfigCollection(sizeOfFirstCell: 177,
                              showNavbar: true,
                               image: ["apollo11Promo", "curiosityPromo","helmetPromo","issPromo", "perseverancePromo", "vostokCapsulePromo", "voyagerPromo"],
                               text: ["Apollo 11", "Curiosity", "USSR helmet", "ISS", "Perseverance", "Vostok 1 capsule", "Voyager"],
                               hasCustomCells: false,
                               nextCollections: [],
                               items:["apollo11", "curiosity","helmet","iss", "perseverance", "vostok1", "voyager"],
                               viewTitle: "Staff",
                               parentTitle: "Categories"
    ),
]
