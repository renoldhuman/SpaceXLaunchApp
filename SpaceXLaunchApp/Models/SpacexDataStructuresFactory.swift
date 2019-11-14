//
//  SpacexDataStructuresFactory.swift
//  SpaceXLaunchApp
//
//  Created by Tyler Helmrich on 11/13/19.
//  Copyright © 2019 Tyler Helmrich. All rights reserved.
//

import Foundation

class SpacexDataStructuresFactory {
    
    public enum LaunchSortOrder {
        case ascending
        case descending
    }
    
    // Custom date formats
    private static let dateFormats = [
        "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX",
        "yyyy-MM-dd'T'HH:mm:ssXXXXX"
    ];
    
    // Allows for filtering and sorting of launches
    public static func getLaunches(from data: Data, usingSorting sort: LaunchSortOrder, usingFilter filter: (Launch) -> Bool) -> [Launch]? {
        
        if var launches = getLaunches(from: data) {
            
            launches.removeAll { launch in
                return filter(launch);
            }
            
            if (sort == .ascending) {
                launches.sort(by: <);
            }
            else {
                launches.sort(by: >);
            }
            
            return launches;
        }
        
        return nil;
    }
    
    private static func getLaunches(from data: Data) -> [Launch]? {
        let decoder = getDecoder(usingDateFormatters: dateFormats);
        
        do {
            let launches: [Launch] = try decoder.decode([Launch].self, from: data);
            return launches;
        }
        catch {
            print(error);
        }
        
        return nil;
    }
    
    // Custom decoder for handling parsing of launch dates from api
    private static func getDecoder(usingDateFormatters dateFormats: [String]) -> JSONDecoder {
        let decoder = JSONDecoder();
        let formatter = DateFormatter();
        formatter.calendar = Calendar(identifier: .iso8601);
        formatter.locale = Locale(identifier: "en_US_POSIX");
        formatter.timeZone = TimeZone(secondsFromGMT: 0);
        
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let jsonDate = try container.decode(String.self)
            
            for format in dateFormats {
                formatter.dateFormat = format
                if let date = formatter.date(from: jsonDate) {
                    return date
                }
            }
            
            return Date.distantPast
        });
        
        return decoder;
    }
    
    public static func getMission(from data: Data) -> Mission? {
        let decoder = JSONDecoder();
        
        do {
            let mission: Mission = try decoder.decode(Mission.self, from: data);
            return mission;
        }
        catch {
            print(error);
        }
        
        return nil;
    }
}
