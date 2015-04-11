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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateCells()
        neonsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func populateCells() {
        let fetchCardsQueue = dispatch_queue_create("fetchCardsQueue", nil)
        dispatch_async(fetchCardsQueue) {
            self.trello.getCards() { (cards) in
                for card in cards {
                    let name = card["name"]! as String
                    let (profileImageURL, slackHandle) =
                        self.extractAttachments(card["attachments"] as [NSDictionary])
                    let imageData = self.fetchImage(profileImageURL)
                    let description = card["desc"]! as String
                    let specialty = card["labels"]![0]["name"]! as String
                    let neon = Neon(name: name,
                                    description: description,
                                    slackHandle: slackHandle,
                                    specialty: specialty,
                                    imageData: imageData)
                    self.neons.append(neon)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.neonsTableView.reloadData()
                }
            }
        }
    }
    
    func extractAttachments(attachments: [NSDictionary]) -> (String, String) {
        // TODO: is there a better way?
        var imageURL: String = "placeholder.jpg"
        var slackHandle: String = "placeholder"
        
        for attachment in attachments {
            let attachmentURL = attachment["url"]! as String
            if attachmentURL.lowercaseString.rangeOfString("slack") != nil {
                slackHandle = split(attachmentURL) { $0 == "=" }[1]
            } else {
                imageURL = attachmentURL
            }
        }
        return (imageURL, slackHandle)
    }
    
    func fetchImage(imageURL: String) -> UIImage {
        var fetchedImage: UIImage
        let url = NSURL(string: imageURL)
        if let imageData = NSData(contentsOfURL: url!) {
            fetchedImage = UIImage(data: imageData)!
        } else {
            println("NO IMAGE!")
            println(imageURL)
            fetchedImage = UIImage()
        }
        return fetchedImage
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "NeonCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as NeonTableViewCell
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
            var neonDetailsVC = segue.destinationViewController as NeonDetailsViewController
            let indexPath = neonsTableView.indexPathForCell(sender as UITableViewCell)!
            neonDetailsVC.neon = neons[indexPath.row]
        } else {
            println("No such segue was found")
        }
    }
}