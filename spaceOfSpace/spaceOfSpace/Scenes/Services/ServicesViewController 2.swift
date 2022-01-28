//
//  ServicesViewController.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit

protocol ServicesDisplayLogic: class
{
  func displaySomething(viewModel: Services.Something.ViewModel)
}

class ServicesViewController: UIViewController, ServicesDisplayLogic
{
    let tableview: UITableView = {
            let tv = UITableView()
            tv.backgroundColor = UIColor.systemGray4
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.separatorColor = UIColor.systemGray4
            return tv
        }()
    var interactor: ServicesBusinessLogic?
    var router: (NSObjectProtocol & ServicesRoutingLogic & ServicesDataPassing)?

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
      let interactor = ServicesInteractor()
      let presenter = ServicesPresenter()
      let router = ServicesRouter()
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
        setupTableView()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
      let request = Services.Something.Request()
      interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Services.Something.ViewModel)
    {
      //nameTextField.text = viewModel.name
    }
}
