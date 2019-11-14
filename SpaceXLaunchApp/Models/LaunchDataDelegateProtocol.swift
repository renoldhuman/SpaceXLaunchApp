//
//  LaunchDataDelegateProtocol.swift
//  SpaceXLaunchApp
//
//  Created by Tyler Helmrich on 11/14/19.
//  Copyright © 2019 Tyler Helmrich. All rights reserved.
//

import Foundation

public protocol LaunchDataDelegate: class {
    func getLaunches(from data: Data)
}
