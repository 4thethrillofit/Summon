//
//  SlackClient.swift
//  Summon
//
//  Created by Feifan Wang on 4/10/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import Foundation

struct SlackClient {
    static func summonUser(summonee: String, summoner: String="Summoner") {
        let message = "\(summoner) needs your help!"
        let url = NSURL(string: "https://hooks.slack.com/services/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")!
        let payload = ["channel": "@\(summonee)",
                       "username": summoner,
                       "text": message]
        
        let stringifiedJSON = stringifyJSON(payload)
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = stringifiedJSON.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            println(error)
            println("==============")
            println(response)
        }
        task.resume()
    }
    
    static func stringifyJSON(JSONData: NSDictionary) -> String {
        // https://gist.github.com/santoshrajan/97aa46871cde0c0cb8a8
        if NSJSONSerialization.isValidJSONObject(JSONData) {
            if let data = NSJSONSerialization.dataWithJSONObject(JSONData, options: NSJSONWritingOptions.PrettyPrinted, error: nil) {
                return NSString(data: data, encoding: NSUTF8StringEncoding)!
            }
        }
        return ""
    }
}