//
//  Launch.swift
//  SpaceXLaunchApp
//
//  Created by Tyler Helmrich on 11/13/19.
//  Copyright © 2019 Tyler Helmrich. All rights reserved.
//

import Foundation


struct Launch: Decodable, Comparable {
    static func < (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.launchDate < rhs.launchDate;
    }
    
    let missionName: String
    let missionId: [String]
    let launchDate: Date
    let rocketName: String
    let launchSiteName: String
    let launchPatchUrl: URL?
    let smallLaunchPatchUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case missionId = "mission_id"
        case launchDate = "launch_date_utc"
        case rocket = "rocket"
        case rocketName = "rocket_name"
        case launchSite = "launch_site"
        case launchSiteName  = "site_name"
        case links = "links"
        case launchPatchUrl = "mission_patch"
        case smallLaunchPatchUrl = "mission_patch_small"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        missionName = try container.decode(String.self , forKey: .missionName)
        missionId = try container.decode([String].self, forKey: .missionId)
        launchDate = try container.decode(Date.self, forKey: .launchDate)
        
        let rocket = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .rocket)
        rocketName = try rocket.decode(String.self, forKey: .rocketName)
        
        let launchSite = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .launchSite)
        launchSiteName = try launchSite.decode(String.self, forKey: .launchSiteName)
        
        let links = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .links)
        do {
            launchPatchUrl = try links.decode(URL.self, forKey: .launchPatchUrl)
        }
        catch {
            launchPatchUrl = nil
        }
        do {
            smallLaunchPatchUrl = try links.decode(URL.self, forKey: .smallLaunchPatchUrl)
        }
        catch {
            smallLaunchPatchUrl = nil
        }
    }
}
