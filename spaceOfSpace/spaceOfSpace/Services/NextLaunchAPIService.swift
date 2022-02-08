import Foundation
import SwiftyJSON
import Alamofire

final class NextLaunchAPIService {
    
    private let source: String = "https://ll.thespacedevs.com/2.0.0/launch/upcoming/?format=json&limit=1"
    
    func requestNextLaunch(completion: @escaping (NextLaunchDataSource?) -> ()) {
        AF.request(source).responseJSON { (data) in
            guard let data = data.value else { return }
            let jsonObject = JSON(data)
            completion(self.transferJsonToNextLaunchModel(json: jsonObject))
        }
    }
    
    private func transferJsonToNextLaunchModel(json: JSON) -> NextLaunchDataSource? {
        
        let nextLaunchPath = json["results"].arrayValue[0]
        
        let launchInfoSection = NextLaunchInfo(
            name: nextLaunchPath["name"].stringValue,
            launchServiceProviderTitle: nextLaunchPath["launch_service_provider"]["name"].stringValue,
            date: nextLaunchPath["window_start"].stringValue
        )
        
        let missionSection = NextLaunchMission(
            missionDescription: nextLaunchPath["mission"]["description"].stringValue
        )
        
        let gallerySection = NextLaunchGallery(
            galleryPhotosURL: [
                nextLaunchPath["image"].stringValue,
                nextLaunchPath["pad"]["map_image"].stringValue
            ]
        )
        
        let wikiLinksSection = NextLaunchLinks(
            linkType: .wiki,
            imageURL: nextLaunchPath["image"].stringValue,
            sourceTitle: nextLaunchPath["pad"]["location"]["name"].stringValue,
            sourceDescription: "Wikipedia",
            browserURL: nextLaunchPath["pad"]["wiki_url"].stringValue
        )
        
        let mapLinksSection = NextLaunchLinks(
            linkType: .map,
            imageURL: nextLaunchPath["pad"]["map_image"].stringValue,
            sourceTitle: "Where is \(nextLaunchPath["pad"]["location"]["name"].stringValue)?",
            sourceDescription: "Maps",
            browserURL: nextLaunchPath["pad"]["map_url"].stringValue
        )
        
        let nextLaunchData = NextLaunchDataSource(
            launchInfoSection: launchInfoSection,
            missionSection: missionSection,
            gallerySection: gallerySection,
            linksSection: [wikiLinksSection, mapLinksSection]
        )
        
        return nextLaunchData
    }
}
