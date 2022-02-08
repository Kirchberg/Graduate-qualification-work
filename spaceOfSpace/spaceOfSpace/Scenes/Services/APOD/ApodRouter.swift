import UIKit

@objc protocol ApodRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ApodDataPassing
{
  var dataStore: ApodDataStore? { get }
}

class ApodRouter: NSObject, ApodRoutingLogic, ApodDataPassing
{
    
  weak var viewController: ApodViewController?
  var dataStore: ApodDataStore?
  
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
  
  //func navigateToSomewhere(source: ServicesViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ServicesDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

