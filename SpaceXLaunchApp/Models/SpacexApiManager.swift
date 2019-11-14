//
//  SpacexApiManager.swift
//  SpaceXLaunchApp
//
//  Created by Tyler Helmrich on 11/13/19.
//  Copyright © 2019 Tyler Helmrich. All rights reserved.
//

import Foundation

class SpacexApiManager {
    
    private static let launchesQuery: String = "https://api.spacexdata.com/v3/launches";
    private static let missionQuery: String = "https://api.spacexdata.com/v3/missions/";
    
    public static func getLaunches(launchDataDelegate: LaunchDataDelegate) {
        let url: URL = URL(string: launchesQuery)!;
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else{
                return;
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    return;
            }
            
            if let data = data {
                launchDataDelegate.getLaunches(from: data)
            }
        }

        task.resume();
    }
    
    public static func getMission(from missionName: String, missionDataDelegate: MissionDataDelegate) {
        
        let url: URL = URL(string: "" + missionQuery + missionName)!;
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else{
                return;
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    return;
            }
            
            if let data = data {
                missionDataDelegate.getMission(from: data);
            }
        }

        task.resume();
    }
}
