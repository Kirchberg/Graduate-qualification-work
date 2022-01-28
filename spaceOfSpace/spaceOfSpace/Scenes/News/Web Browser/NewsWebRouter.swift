//
//  NewsWebBrowserRouter.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 03.04.2021.
//

import UIKit

@objc protocol NewsWebBrowserRoutingLogic {}

protocol NewsWebBrowserDataPassing {
    var dataStore: NewsWebBrowserDataStore? { get }
}

class NewsWebBrowserRouter: NSObject, NewsWebBrowserRoutingLogic, NewsWebBrowserDataPassing {
    weak var viewController: NewsWebBrowserViewController?
    var dataStore: NewsWebBrowserDataStore?
}
