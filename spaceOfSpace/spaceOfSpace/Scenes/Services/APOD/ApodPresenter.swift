//
//  ApodPresenter.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 12.04.2021.
//

import Foundation
import UIKit

protocol ApodPresentationLogic
{
    func presentSomething(response: Apod.GetImgUrl.Response)

    func presentImg(response: Apod.GetImgUrl.Response)
}

class ApodPresenter: ApodPresentationLogic
{
    weak var viewController: ApodDisplayLogic?
    
    func presentSomething(response: Apod.GetImgUrl.Response)
    {
        //    let viewModel = Apod.Something.ViewModel()
        //    viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentImg(response: Apod.GetImgUrl.Response){
        guard let stringUrl=response.url,
            let url=URL(string: stringUrl),
            let title=response.title,
            let desc=response.description
        else {
            return
        }
        let viewModel=Apod.GetImgUrl.ViewModel(
            url: url,
            title: title,
            description: desc
            )
        viewController?.displayImg(viewModel: viewModel)
    }
}
