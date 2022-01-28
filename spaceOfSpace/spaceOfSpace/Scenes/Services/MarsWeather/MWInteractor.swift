//
//  MWInteractor.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 20.04.2021.
//

import UIKit

protocol MWBusinessLogic
{
  func doSomething(request: MW.Something.Request)
}

protocol MWDataStore
{
  //var name: String { get set }
}

class MWInteractor: MWBusinessLogic, MWDataStore
{
  var presenter: MWPresentationLogic?
  var worker: MWWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: MW.Something.Request)
  {
    worker = MWWorker()
    worker?.doSomeWork()
    
    let response = MW.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
