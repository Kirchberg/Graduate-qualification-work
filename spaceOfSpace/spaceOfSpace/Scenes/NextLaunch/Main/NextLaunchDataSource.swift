//
//  NextLaunchDataSource.swift
//  spaceOfSpace
//
//  Created by Kirill Kostarev on 14.05.2021.
//

import Foundation

enum linkType: String {
    case wiki
    case map
}

struct NextLaunchInfo {
    var name: String?
    var launchServiceProviderTitle: String?
    var date: String?
}

struct NextLaunchMission {
    var missionDescription: String?
}

struct NextLaunchGallery {
    var galleryPhotosURL: [String]?
}

struct NextLaunchLinks {
    var linkType: linkType?
    var imageURL: String?
    var sourceTitle: String?
    var sourceDescription: String?
    var browserURL: String?
}

final class NextLaunchDataSource {
    
    var launchInfoSection: NextLaunchInfo
    var missionSection: NextLaunchMission
    var gallerySection: NextLaunchGallery
    var linksSection: [NextLaunchLinks]
    
    init(launchInfoSection: NextLaunchInfo, missionSection: NextLaunchMission, gallerySection: NextLaunchGallery, linksSection: [NextLaunchLinks]) {
        self.launchInfoSection = launchInfoSection
        self.missionSection = missionSection
        self.gallerySection = gallerySection
        self.linksSection = linksSection
    }
}
