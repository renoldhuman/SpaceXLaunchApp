//
//  ViewController.swift
//  SpaceXLaunchApp
//
//  Created by Tyler Helmrich on 11/13/19.
//  Copyright © 2019 Tyler Helmrich. All rights reserved.
//

import UIKit

class LaunchTableViewController: UITableViewController {

    private var launches: [Launch]?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Gets all launches from the api
        SpacexApiManager.getLaunches(launchDataDelegate: self);
    }
    
    // handles transition to the mission details page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "missionDetailSegue") {
            let controller = segue.destination as! MissionDescriptionViewController;
            let cell = sender as! UITableViewCell;
            
            guard let index = tableView.indexPath(for: cell) else {
                return;
            }
            
            guard let launches = launches else {
                return;
            }
            
            controller.launch = launches[index.row];
        }
    }


}

extension LaunchTableViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches?.count ?? 0;
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "launchTableCell")!;
        let launchTableCell = cell.viewWithTag(1000) as! LaunchTableCell
        launchTableCell.setView(from: launches![indexPath.row]);
        
        return cell;
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isHighlighted = false;
        performSegue(withIdentifier: "missionDetailSegue", sender: tableView.cellForRow(at: indexPath));
    }
}

extension LaunchTableViewController: LaunchDataDelegate {
    // Delegate method to handle api data
    func getLaunches(from data: Data) {
        
        // creates launch data structure from the data received
        // BY DEFAULT ANY LAUNCH THAT DOES NOT HAVE A MISSION ID IS IGNORED
        launches = SpacexDataStructuresFactory.getLaunches(from: data, usingSorting: .descending) { launch in
            return launch.missionId.isEmpty
        }
        
        // reloads the tableview
        if (launches != nil) {
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
        }
    }
    
    
}

