//
//  MissionDescriptionViewController.swift
//  SpaceXLaunchApp
//
//  Created by Tyler Helmrich on 11/14/19.
//  Copyright © 2019 Tyler Helmrich. All rights reserved.
//

import Foundation
import UIKit

class MissionDescriptionViewController: UIViewController {
    @IBOutlet weak var missionDescriptionView: MissionDescription!
    @IBOutlet weak var tableView: UITableView!
    
    // Opens the url when clicking on the associated icon
    @IBAction func wikipediaClick(_ sender: Any) {
        openUrl(with: mission?.wikipediaUrl ?? nil);
    }
    @IBAction func websiteClick(_ sender: Any) {
        openUrl(with: mission?.launchWebsiteUrl ?? nil);
    }
    @IBAction func twitterClick(_ sender: Any) {
        openUrl(with: mission?.twitterUrl ?? nil);
    }
    
    
    
    public var launch: Launch?;
    private var mission: Mission?;
    
    override func viewDidLoad() {
        if let launch = launch {
            SpacexApiManager.getMission(from: launch.missionId[0], missionDataDelegate: self);
            tableView.dataSource = self;
        }
    }
    
    private func openUrl(with url: URL?) {
        if let urlToOpen = url {
            UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil);
        }
    }
    
}

extension MissionDescriptionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // One section for manufacturers and one for payloads
        return 2;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Manufacturers" : "Payloads";
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let mission = mission {
            return section == 0 ? mission.manufacturers.count : mission.payloadIds.count;
        }
        else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "missionInfoCell")!;
        let label = cell.viewWithTag(1000) as! UILabel;
        if let mission = mission {
            let section = indexPath.section;
            label.text = section == 0 ? mission.manufacturers[indexPath.row] : mission.payloadIds[indexPath.row];
        }
        
        return cell;
    }
    
}

extension MissionDescriptionViewController: MissionDataDelegate {
    func getMission(from data: Data) {
        if let mission = SpacexDataStructuresFactory.getMission(from: data) {
            self.mission = mission;
            
            // Handle UI update after getting the mission from the API
            DispatchQueue.main.async {
                self.missionDescriptionView.setView(from: mission);
                self.tableView.reloadData();
            }
        }
    }
}
