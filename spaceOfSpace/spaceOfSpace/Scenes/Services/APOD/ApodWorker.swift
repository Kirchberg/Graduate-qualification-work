import UIKit
import Alamofire
import SwiftyJSON

class ApodWorker
{
    func doSomeWork()
    {
    }
    
    
    //3afgxJeXOiRbF2GSm5w6ervmc5XEjaT1gN2oAnj7
//    https://api.nasa.gov/planetary/apod?api_key=3afgxJeXOiRbF2GSm5w6ervmc5XEjaT1gN2oAnj7
    
//    https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=1
    func getUrl(completion: @escaping (Apod.GetImgUrl.Response) -> ()){
        AF.request("https://api.nasa.gov/planetary/apod?api_key=3afgxJeXOiRbF2GSm5w6ervmc5XEjaT1gN2oAnj7&count=1").responseJSON { (data) in
            guard let data=data.value else{return}
            let js=JSON(data)
            completion(self.getImgUrl(js: js))
        }
    }
    
    
    private func getImgUrl(js: JSON)->Apod.GetImgUrl.Response{
        return Apod.GetImgUrl.Response(
            url: js[0]["url"].stringValue,
            title: js[0]["title"].stringValue,
            description: js[0]["explanation"].stringValue
        )
    }
}
