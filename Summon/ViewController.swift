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

    var neons: [Neon] = [
        Neon(name: "Fei"),
        Neon(name: "Alex")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var trello = Trello()
        trello.getCards() {
            (res) in
            println(res)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "NeonCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as NeonTableViewCell
        cell.neonNameLabel.text = neons[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neons.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("SELECTED")
    }
}