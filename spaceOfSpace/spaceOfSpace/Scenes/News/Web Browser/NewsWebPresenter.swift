//
//  NewsWebBrowserPresenter.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 03.04.2021.
//

import UIKit

protocol NewsWebBrowserPresentationLogic {
    func presentHyperlink(url: URL)
}

class NewsWebBrowserPresenter: NewsWebBrowserPresentationLogic {
    weak var viewController: NewsWebBrowserDisplayLogic?
    
    // MARK: Do something
    
    func presentHyperlink(url: URL) {
        let viewModel = NewsWebBrowser.showShareMenu.ViewModel(hyperlink: url)
        viewController?.displayWebBrowser(viewModel: viewModel)
    }
}
