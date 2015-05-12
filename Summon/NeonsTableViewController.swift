//
//  ViewController.swift
//  Summon
//
//  Created by Feifan Wang on 3/30/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit

class NeonsTableViewController: UIViewController,
                      UITableViewDelegate,
                      UITableViewDataSource {

    
    @IBOutlet weak var neonsTableView: UITableView!
    
    var neons: [Neon] = []
    let trello = Trello()
    var currentNeon: Neon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        neonsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        if neons.count == 0 {
            println(currentNeon)
            populateCells()
        }
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "NeonCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! NeonTableViewCell
        let neon = neons[indexPath.row]
        cell.neonNameLabel.text = neon.name
        cell.neonImageView.image = neon.imageData
        cell.neonSpecialtyLabel.text = neon.specialty.uppercaseString
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neons.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowNeonDetails" {
            var neonDetailsVC = segue.destinationViewController as! NeonDetailsViewController
            let indexPath = neonsTableView.indexPathForCell(sender as! UITableViewCell)!
            neonDetailsVC.neon = neons[indexPath.row]
            neonDetailsVC.currentNeon = currentNeon
        } else {
            println("No such segue was found")
        }
    }
}