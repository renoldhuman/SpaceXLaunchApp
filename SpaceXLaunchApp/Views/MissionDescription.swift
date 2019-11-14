//
//  MissionDescription.swift
//  SpaceXLaunchApp
//
//  Created by Tyler Helmrich on 11/14/19.
//  Copyright © 2019 Tyler Helmrich. All rights reserved.
//

import Foundation
import UIKit

class MissionDescription: UIView {
    @IBOutlet var containingView: UIView!
    @IBOutlet weak var missionName: UILabel!
    @IBOutlet weak var missionDescription: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        commonInit();
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        commonInit();
    }
    
    func commonInit() {
        super.awakeFromNib();
        Bundle.main.loadNibNamed("MissionDescription", owner: self, options: nil);
        addSubview(containingView);
        containingView.frame = self.bounds;
        containingView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
    }
    
    func setView(from mission: Mission) {
        missionName.text = mission.missionName;
        missionDescription.text = mission.description;
    }
}
