//
//  ServicesArPlanetPresenter.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 01.04.2021.
//

import UIKit

protocol ServicesArPlanetPresentationLogic {
  func presentSomething(response: ServicesArPlanet.Something.Response)
}

class ServicesArPlanetPresenter: ServicesArPlanetPresentationLogic
{
    func presentSomething(response: ServicesArPlanet.Something.Response) {
        let viewModel = ServicesArPlanet.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
  weak var viewController: ServicesArPlanetDisplayLogic?

}
