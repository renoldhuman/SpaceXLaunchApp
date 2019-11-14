//
//  Mission.swift
//  SpaceXLaunchApp
//
//  Created by Tyler Helmrich on 11/13/19.
//  Copyright © 2019 Tyler Helmrich. All rights reserved.
//

import Foundation

struct Mission: Decodable {
    var missionName: String
    var missionId: String
    var manufacturers: [String]
    var payloadIds: [String]
    var wikipediaUrl: URL?
    var launchWebsiteUrl: URL?
    var twitterUrl: URL?
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case missionId = "mission_id"
        case manufacturers = "manufacturers"
        case payloadIds = "payload_ids"
        case wikipediaUrl = "wikipedia"
        case launchWebsiteUrl = "website"
        case twitterUrl = "twitter"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        missionName = try container.decode(String.self , forKey: .missionName)
        missionId = try container.decode(String.self, forKey: .missionId)
        manufacturers = try container.decode([String].self, forKey: .manufacturers)
        payloadIds = try container.decode([String].self, forKey: .payloadIds)
        description = try container.decode(String.self, forKey: .description)
        
        do {
            wikipediaUrl = try container.decode(URL.self, forKey: .wikipediaUrl)
        }
        catch {
            wikipediaUrl = nil
        }
        do {
            launchWebsiteUrl = try container.decode(URL.self, forKey: .launchWebsiteUrl)
        }
        catch {
            launchWebsiteUrl = nil
        }
        do {
            twitterUrl = try container.decode(URL.self, forKey: .twitterUrl)
        }
        catch {
            twitterUrl = nil
        }
    }
}
