//
//  Neon.swift
//  Summon
//
//  Created by Feifan Wang on 3/30/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit

@objc(Neon)

class Neon: NSObject, NSCoding {
    var name: String = ""
    var desc: String = ""
    var slackHandle: String = ""
    var specialty: String = ""
    var imageData: UIImage = UIImage()
    
    init(name: String, desc: String, slackHandle: String, specialty: String, imageData: UIImage) {
        self.name = name
        self.desc = desc
        self.slackHandle = slackHandle
        self.specialty = specialty
        self.imageData = imageData
    }
    
    required init(coder unarchiver: NSCoder) {
        super.init()
        name = unarchiver.decodeObjectForKey("name") as! String
        desc = unarchiver.decodeObjectForKey("desc") as! String
        slackHandle = unarchiver.decodeObjectForKey("slackHandle") as! String
        specialty = unarchiver.decodeObjectForKey("specialty") as! String
        imageData = unarchiver.decodeObjectForKey("imageData") as! UIImage
    }
    
    func encodeWithCoder(archiver: NSCoder) {
        archiver.encodeObject(name, forKey: "name")
        archiver.encodeObject(desc, forKey: "desc")
        archiver.encodeObject(slackHandle, forKey: "slackHandle")
        archiver.encodeObject(specialty, forKey: "specialty")
        archiver.encodeObject(imageData, forKey: "imageData")
    }
}