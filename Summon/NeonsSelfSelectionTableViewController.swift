//
//  NeonsSelfSelectionTableViewController.swift
//  Summon
//
//  Created by Feifan Wang on 4/17/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit

class NeonsSelfSelectionTableViewController: UITableViewController {

    var neons: [Neon] = []
    let trello = Trello()
    let reuseIdentifier = "NeonSelfSelectionCell"
    
    @IBOutlet var neonsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        neonsTableView.contentInset = UIEdgeInsets(top: 108, left: 0, bottom: 0, right: 0)
        populateCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func populateCells() {
        let fetchCardsQueue = dispatch_queue_create("fetchCardsQueue", nil)
        dispatch_async(fetchCardsQueue) {
            self.trello.getCards() { (cards) in
                for card in cards {
                    let neon = NeonFactory.create(card)
                    self.neons.append(neon)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.neonsTableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NeonSelfSelectionTableViewCell
        let neon = neons[indexPath.row]
        cell.neonImageView.image = neon.imageData
        cell.neonNameLabel.text = neon.name
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Which Neon are you?"
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.contentView.backgroundColor = UIColor.blackColor()
        headerView.textLabel.textColor = UIColor(red: 0/255, green: 211/255, blue: 155/255, alpha: 1)
        headerView.textLabel.textAlignment = NSTextAlignment.Center
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSummonableNeons" {
            var summonableNeonsVC = segue.destinationViewController as! NeonsTableViewController
            let indexPath = neonsTableView.indexPathForCell(sender as! NeonSelfSelectionTableViewCell)!
            let neon = neons[indexPath.row]
            summonableNeonsVC.neons = neons
            summonableNeonsVC.currentNeon = neon
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
