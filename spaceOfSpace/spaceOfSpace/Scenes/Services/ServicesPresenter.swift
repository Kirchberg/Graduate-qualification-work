import UIKit

protocol ServicesPresentationLogic
{
  func presentSomething(response: Services.Something.Response)
}

class ServicesPresenter: ServicesPresentationLogic
{
  weak var viewController: ServicesDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Services.Something.Response)
  {
    let viewModel = Services.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
