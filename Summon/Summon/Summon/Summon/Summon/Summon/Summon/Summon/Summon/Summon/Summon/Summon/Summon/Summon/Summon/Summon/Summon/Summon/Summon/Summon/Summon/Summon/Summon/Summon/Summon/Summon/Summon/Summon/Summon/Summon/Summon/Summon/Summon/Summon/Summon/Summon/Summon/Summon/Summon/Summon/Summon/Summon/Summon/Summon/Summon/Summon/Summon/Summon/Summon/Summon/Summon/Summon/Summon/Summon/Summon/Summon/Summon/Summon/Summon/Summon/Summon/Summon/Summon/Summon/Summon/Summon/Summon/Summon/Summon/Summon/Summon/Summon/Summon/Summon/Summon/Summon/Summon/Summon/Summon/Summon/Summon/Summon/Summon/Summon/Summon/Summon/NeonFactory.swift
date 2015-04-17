//
//  NeonFactory.swift
//  Summon
//
//  Created by Feifan Wang on 4/16/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit

struct NeonFactory {
    static func create(card: NSDictionary) -> Neon {
        println("HIM HEre")
        let name = card["name"]! as! String
        let (profileImageURL, slackHandle) = extractAttachments(card["attachments"] as! [NSDictionary])
        let imageData = fetchImage(profileImageURL)
        let description = card["desc"]! as! String
        let specialty = card["labels"]![0]["name"]! as! String
        println(name)
        println(slackHandle)
        return Neon(
            name: name,
            description: description,
            slackHandle: slackHandle,
            specialty: specialty,
            imageData: imageData
        )
    }
    
    static private func extractAttachments(attachments: [NSDictionary]) -> (String, String) {
        // TODO: is there a better way?
        var imageURL = "placeholder.jpg"
        var slackHandle = "placeholder"
        
        for attachment in attachments {
            let attachmentURL = attachment["url"]! as! String
            if attachmentURL.lowercaseString.rangeOfString("slack") != nil {
                slackHandle = split(attachmentURL) { $0 == "=" }[1]
            } else {
                imageURL = attachmentURL
            }
        }
        return (imageURL, slackHandle)
    }
    
    static private func fetchImage(imageURL: String) -> UIImage {
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
}