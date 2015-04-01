//
//  ViewController.swift
//  Summon
//
//  Created by Feifan Wang on 3/30/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                      UITableViewDelegate,
                      UITableViewDataSource {

    
    @IBOutlet weak var neonsTableView: UITableView!
    
    var neons: [Neon] = []
    let trello = Trello()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    let name = card["name"]! as String
                    let (profileImageURL, slackHandle) =
                        self.extractAttachments(card["attachments"] as [NSDictionary])
                    let imageData = self.fetchImage(profileImageURL)
                    self.neons.append(Neon(name: name, imageData: imageData))
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.neonsTableView.reloadData()
                }
            }
        }
    }
    
    func extractAttachments(attachments: [NSDictionary]) -> (String, String) {
        // TODO: is there a better way?
        var imageURL: String = "error.jpg"
        var slackHandle: String = "error"
        
        for attachment in attachments {
            let attachmentURL = attachment["url"]! as String
            if attachmentURL.lowercaseString.rangeOfString("slack") != nil {
                slackHandle = attachmentURL
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
        cell.neonNameLabel.text = neons[indexPath.row].name
        cell.neonImageView.image = neons[indexPath.row].imageData
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neons.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("SELECTED")
    }
}