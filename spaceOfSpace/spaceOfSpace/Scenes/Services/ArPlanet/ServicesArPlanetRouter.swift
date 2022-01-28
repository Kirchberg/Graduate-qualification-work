//
//  ServicesArPlanetArPlanetRouter.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 01.04.2021.
//

import UIKit

@objc protocol ServicesArPlanetRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ServicesArPlanetDataPassing
{
  var dataStore: ServicesArPlanetDataStore? { get }
}

class ServicesArPlanetRouter: NSObject, ServicesArPlanetRoutingLogic, ServicesArPlanetDataPassing
{
  weak var viewController: ServicesArPlanetViewController?
  var dataStore: ServicesArPlanetDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: ServicesArPlanetViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ServicesArPlanetDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

