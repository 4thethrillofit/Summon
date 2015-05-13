//
//  NeonsSelfSelectionTableViewController.swift
//  Summon
//
//  Created by Feifan Wang on 4/17/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit
import MBProgressHUD

class NeonsSelfSelectionViewController: UIViewController,
                                             UITableViewDataSource,
                                             UITableViewDelegate {

    var neons: [Neon] = []
    let trello = Trello()
    let reuseIdentifier = "NeonSelfSelectionCell"
    var currentNeon: Neon?
    
    
    var neonsFilePath: String {
        let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
        return url.URLByAppendingPathComponent("neonsArray").path!
    }
    
//    var currentNeonFilePath: String {
//        let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
//        return url.URLByAppendingPathComponent("currentNeon").path!
//    }
    
    @IBOutlet var neonsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        neonsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        loadCachedNeons()
    }
    
    override func viewDidAppear(animated: Bool) {
//        let cachedCurrentNeon = NSKeyedUnarchiver.unarchiveObjectWithFile(currentNeonFilePath) as? Neon
        var cachedCurrentNeon: Neon?
        if let currentNeonData = NSUserDefaults.standardUserDefaults().objectForKey("currentNeon") as? NSData {
            cachedCurrentNeon = NSKeyedUnarchiver.unarchiveObjectWithData(currentNeonData) as? Neon
        }
        if (cachedCurrentNeon != nil  && neons.count > 0) {
            currentNeon = cachedCurrentNeon
            performSegueWithIdentifier("ShowSummonableNeons", sender: self)
        } else { populateCells() }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadCachedNeons() {
        if let neons = NSKeyedUnarchiver.unarchiveObjectWithFile(neonsFilePath) as? [Neon] {
            self.neons = neons
        }
    }
    
    func populateCells() {
        let loadingHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingHUD.mode = MBProgressHUDMode.Indeterminate
        loadingHUD.labelText = "Fetching Neons data"
        let fetchCardsQueue = dispatch_queue_create("fetchCardsQueue", nil)
        dispatch_async(fetchCardsQueue) {
            self.trello.getCards() { (cards) in
                for card in cards {
                    let neon = NeonFactory.create(card)
                    self.neons.append(neon)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                    NSKeyedArchiver.archiveRootObject(self.neons, toFile: self.neonsFilePath)
                    self.neonsTableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    { return 1 }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return neons.count }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NeonSelfSelectionTableViewCell
        let neon = neons[indexPath.row]
        cell.neonImageView.image = neon.imageData
        cell.neonNameLabel.text = neon.name
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    { return 65.0 }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    { return "Which Neon are you?" }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.contentView.backgroundColor = UIColor(red: 39/255, green: 39/255, blue: 39/255, alpha: 1)
        headerView.textLabel.textColor = UIColor(red: 0/255, green: 211/255, blue: 155/255, alpha: 1)
        headerView.textLabel.textAlignment = NSTextAlignment.Center
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSummonableNeons" {
            var neon: Neon?
            var summonableNeonsVC = segue.destinationViewController as! NeonsTableViewController

            if currentNeon == nil {
                let indexPath = neonsTableView.indexPathForCell(sender as! NeonSelfSelectionTableViewCell)!
                neon = neons[indexPath.row]
                let neonData = NSKeyedArchiver.archivedDataWithRootObject(neon!)
                NSUserDefaults.standardUserDefaults().setObject(neonData, forKey: "currentNeon")
//                NSKeyedArchiver.archiveRootObject(neon!, toFile: currentNeonFilePath)
            } else {
                neon = currentNeon!
            }
            
            summonableNeonsVC.neons = neons
            summonableNeonsVC.currentNeon = neon
        }
    }
}
