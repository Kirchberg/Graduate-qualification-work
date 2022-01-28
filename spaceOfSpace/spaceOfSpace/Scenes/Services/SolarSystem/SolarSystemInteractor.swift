//
//  SolarSystemInteractor.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 07.05.2021.
//

import UIKit

protocol SolarSystemBusinessLogic {}

protocol SolarSystemDataStore {}

class SolarSystemInteractor: SolarSystemBusinessLogic, SolarSystemDataStore {
    var presenter: SolarSystemPresentationLogic?
    var worker: SolarSystemWorker?
}
