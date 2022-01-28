//
//  MWRouter.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 20.04.2021.
//

import UIKit

@objc protocol MWRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MWDataPassing
{
  var dataStore: MWDataStore? { get }
}

class MWRouter: NSObject, MWRoutingLogic, MWDataPassing
{
  weak var viewController: MWViewController?
  var dataStore: MWDataStore?
  
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
  
  //func navigateToSomewhere(source: MWViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: MWDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
