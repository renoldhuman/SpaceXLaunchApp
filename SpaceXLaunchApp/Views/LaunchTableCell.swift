//
//  LaunchTableCell.swift
//  SpaceXLaunchApp
//
//  Created by Tyler Helmrich on 11/14/19.
//  Copyright © 2019 Tyler Helmrich. All rights reserved.
//

import Foundation
import UIKit

class LaunchTableCell: UIView {
    
    @IBOutlet var containingView: UIView!
    @IBOutlet weak var launchPatch: UIImageView!
    @IBOutlet weak var mission: UILabel!
    @IBOutlet weak var rocket: UILabel!
    @IBOutlet weak var launchSite: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        commonInit();
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        commonInit();
    }
    
    // Loads the nib and adds the parent view
    func commonInit() {
        super.awakeFromNib();
        Bundle.main.loadNibNamed("LaunchTableCell", owner: self, options: nil);
        addSubview(containingView);
        containingView.frame = self.bounds;
        containingView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
    }
    
    // Gets image data from the small url associated with the launch
    // otherwise sets to the default space x logo
    // sets cell data
    func setView(from launch: Launch) {
        if let imageUrl = launch.smallLaunchPatchUrl {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.launchPatch.image = UIImage(data: data);
                    }
                }
            }
        }
        else {
            launchPatch.image = UIImage(named: "spaceXLogo");
        }
        
        
        mission.text = launch.missionName;
        rocket.text = launch.rocketName;
        launchSite.text = launch.launchSiteName;
        launchDate.text = "\(launch.launchDate)";
    }
}
