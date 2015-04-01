//
//  Trello.swift
//  Summon
//
//  Created by Feifan Wang on 3/30/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit

class Trello {
    let key = "cdadc9eda9781962d05538691df8cd59"
//    let secret = "f6ca6b3f2d56e808f114646c53d0c830e797ab0e35dc55904490b10dc0e9d91f"
    let summonBoardID = "BVdWWXZA"
    var summonBoardURL: String!
    
    init() {
        summonBoardURL = "https://api.trello.com/1/board/\(summonBoardID)?key=\(key)"
    }
    
    func getCards(callback: ([NSDictionary]) -> ()) {
        request("\(summonBoardURL)&cards=open&lists=open&card_attachments=true&card_attachment_fields=url") {
            (res) in
            let cards = res["cards"]! as [NSDictionary]
            callback(cards)
        }
    }
    
    func request(url: String, callback: (NSDictionary) -> ()) {
        var nsURL = NSURL(string: url)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL) {
            (data, res, error) in
            var error: NSError?
            // &error means a reference to the error
            // re-encode the json into an object
            
            var response = NSJSONSerialization.JSONObjectWithData(
                            data,
                            options: NSJSONReadingOptions.MutableContainers,
                            error: &error) as NSDictionary
            callback(response)
        }
        task.resume()
    }
}