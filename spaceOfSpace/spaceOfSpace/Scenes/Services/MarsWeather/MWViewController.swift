//
//  MWViewController.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 20.04.2021.
//

import UIKit

protocol MWDisplayLogic: AnyObject {
    func displaySomething(viewModel: MW.Something.ViewModel)
}

class MWViewController: VerticalViewController, MWDisplayLogic {
    var interactor: MWBusinessLogic?
    var router: (NSObjectProtocol & MWRoutingLogic & MWDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MWInteractor()
        let presenter = MWPresenter()
        let router = MWRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemPink
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = MW.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: MW.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }

//    let title = UILabel().useConstraints()
    var labelLeadingConstraint: NSLayoutConstraint?

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .red
//        let newView = UIView().useConstraints()
//
//        view.addSubview(newView)
//
//        NSLayoutConstraint.activate([
//            newView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            newView.topAnchor.constraint(equalTo: view.topAnchor),
//            newView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            newView.heightAnchor.constraint(equalToConstant: 500)
//        ])
//
//        guard let labelLeadingConstraint = labelLeadingConstraint else {
//            return
//        }
//    }
}
