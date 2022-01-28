//
//  ApodModels.swift
//  spaceOfSpace
//
//  Created by Daniil Tchyorny on 12.04.2021.
//

import UIKit

enum Apod
{
  // MARK: Use cases
  
  enum GetImgUrl
  {
    struct Request
    {
    }
    struct Response
    {
        var url:String?
        var title:String?
        var description:String?
    }
    struct ViewModel {
        var url: URL?
        var title:String?
        var description:String?
    }
  }
}
