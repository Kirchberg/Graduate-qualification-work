import UIKit

@objc protocol SolarSystemRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SolarSystemDataPassing {
    var dataStore: SolarSystemDataStore? { get }
}

class SolarSystemRouter: NSObject, SolarSystemRoutingLogic, SolarSystemDataPassing {
    weak var viewController: SolarSystemViewController?
    var dataStore: SolarSystemDataStore?
    
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
    
    //func navigateToSomewhere(source: SolarSystemViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: SolarSystemDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
