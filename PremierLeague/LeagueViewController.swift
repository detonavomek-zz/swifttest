//
//  LeagueViewController.swift
//  PremierLeague
//
//  Created by anton on 7/11/16.
//  Copyright © 2016 organization. All rights reserved.
//

import UIKit
import CoreData

class LeagueViewController: UITableViewController {
    
    var leagueTeamsOld:[LeagueTeam] = leagueTeamsData
    
    var leagueTeams = [NSManagedObject]()
    
    func saveLeagueTeam(leagueTeam: LeagueTeam) {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("LeagueTeam",
                                                        inManagedObjectContext:managedContext)
        
        let leagueTeamObj = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        //3
        leagueTeamObj.setValue(leagueTeam.number, forKey: "number")
        leagueTeamObj.setValue(leagueTeam.name, forKey: "name")
        leagueTeamObj.setValue(leagueTeam.P, forKey: "p")
        leagueTeamObj.setValue(leagueTeam.W, forKey: "w")
        leagueTeamObj.setValue(leagueTeam.D, forKey: "d")
        leagueTeamObj.setValue(leagueTeam.L, forKey: "l")
        leagueTeamObj.setValue(leagueTeam.GF, forKey: "gf")
        leagueTeamObj.setValue(leagueTeam.GA, forKey: "ga")
        leagueTeamObj.setValue(leagueTeam.GD, forKey: "gd")
        leagueTeamObj.setValue(leagueTeam.Pts, forKey: "pts")

        
        //4
        do {
            try managedContext.save()
            //5
            leagueTeams.append(leagueTeamObj)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "                                 P   W  D   L   GF  GA   GD   Pts"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagueTeams.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("LeagueTeamCell", forIndexPath: indexPath) as! LeagueTeamCell
            
            let leagueTeam = leagueTeams[indexPath.row] as NSManagedObject
            cell.leagueTeam = leagueTeam
            
            return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "LeagueTeam")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            leagueTeams = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

}
