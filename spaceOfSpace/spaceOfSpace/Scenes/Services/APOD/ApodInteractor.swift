//
//  ApodInteractor.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 12.04.2021.
//

import UIKit

protocol ApodBusinessLogic
{
    func doSomething(request: Apod.GetImgUrl.Request)
    func loadImg(request: Apod.GetImgUrl.Request)
}

protocol ApodDataStore
{
    var url: String { get }
}

class ApodInteractor: ApodBusinessLogic, ApodDataStore
{
    var url: String = ""
    
    var presenter: ApodPresentationLogic?
    var worker: ApodWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Apod.GetImgUrl.Request)
    {
        worker = ApodWorker()
        worker?.doSomeWork()
        
        let response = Apod.GetImgUrl.Response()
        presenter?.presentSomething(response: response)
    }
    
    func loadImg(request: Apod.GetImgUrl.Request){
        worker = ApodWorker()
        worker?.getUrl(completion: { (resp) in
            guard let url=resp.url, let title=resp.title, let desc=resp.description else{
                return
            }
            self.url=url
            self.presenter?.presentImg(response: Apod.GetImgUrl.Response(
                url: url,
                title: title,
                description: desc
            ))
        })
    }
}
