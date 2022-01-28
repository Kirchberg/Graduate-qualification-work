//
//  ServicesArPlanetArPlanetInteractor.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 01.04.2021.
//

import UIKit

protocol ServicesArPlanetBusinessLogic{
    func doSomething(request: ServicesArPlanet.Something.Request)
}

protocol ServicesArPlanetDataStore{
    //var name: String { get set }
}

class ServicesArPlanetInteractor: ServicesArPlanetBusinessLogic, ServicesArPlanetDataStore{
    var presenter: ServicesArPlanetPresentationLogic?
    var worker: ServicesArPlanetWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: ServicesArPlanet.Something.Request){
        worker = ServicesArPlanetWorker()
        worker?.doSomeWork()
        
        let response = ServicesArPlanet.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
