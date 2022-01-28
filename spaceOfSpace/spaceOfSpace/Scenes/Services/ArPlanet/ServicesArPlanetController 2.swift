//
//  ServicesArPlanetArPlanetController.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 01.04.2021.
//

import Foundation

import UIKit

protocol ServicesArPlanetDisplayLogic: class
{
    func displaySomething(viewModel: ServicesArPlanet.Something.ViewModel)
}

class ServicesArPlanetViewController: UIViewController, ServicesArPlanetDisplayLogic
{
    var interactor: ServicesArPlanetBusinessLogic?
    var router: (NSObjectProtocol & ServicesArPlanetRoutingLogic & ServicesArPlanetDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ServicesArPlanetInteractor()
        let presenter = ServicesArPlanetPresenter()
        let router = ServicesArPlanetRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.systemGray4
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = ServicesArPlanet.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ServicesArPlanet.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}
