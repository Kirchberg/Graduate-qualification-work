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
