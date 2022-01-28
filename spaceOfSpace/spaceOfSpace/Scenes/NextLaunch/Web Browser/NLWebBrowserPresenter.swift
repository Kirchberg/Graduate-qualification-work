//
//  NLWebBrowserPresenter.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 24.05.2021.
//

import Foundation

protocol NLWebBrowserPresenterInput {
    func update(dataSource: NLWebBrowserDataSource)
}

final class NLWebBrowserPresenter {
    weak var view: (NLWebBrowserViewController)?
}

extension NLWebBrowserPresenter: NLWebBrowserPresenterInput {
    
    func update(dataSource: NLWebBrowserDataSource) {
        if let url = URL(string: dataSource.browserURL.formatToHTTPS) {
            view?.displayWebBrowser(with: url)
        }
    }
}
