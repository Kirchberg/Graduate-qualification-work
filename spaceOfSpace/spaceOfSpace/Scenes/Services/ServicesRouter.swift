import UIKit

@objc protocol ServicesRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ServicesDataPassing
{
  var dataStore: ServicesDataStore? { get }
}

class ServicesRouter: NSObject, ServicesRoutingLogic, ServicesDataPassing
{
  weak var viewController: ServicesViewController?
  var dataStore: ServicesDataStore?
  
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
