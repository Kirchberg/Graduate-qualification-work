//
//  MWPresenter.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 20.04.2021.
//

import UIKit

protocol MWPresentationLogic
{
  func presentSomething(response: MW.Something.Response)
}

class MWPresenter: MWPresentationLogic
{
  weak var viewController: MWDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: MW.Something.Response)
  {
    let viewModel = MW.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
