//
//  ServicesInteractor.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 27.03.2021.
//

import UIKit

protocol ServicesBusinessLogic
{
  func doSomething(request: Services.Something.Request)
}

protocol ServicesDataStore
{
  //var name: String { get set }
}

class ServicesInteractor: ServicesBusinessLogic, ServicesDataStore
{
  var presenter: ServicesPresentationLogic?
  var worker: ServicesWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Services.Something.Request)
  {
    worker = ServicesWorker()
    worker?.doSomeWork()
    
    let response = Services.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
