//
//  Trello.swift
//  Summon
//
//  Created by Feifan Wang on 3/30/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import Foundation

class Trello {
    let key = "cdadc9eda9781962d05538691df8cd59"
    let secret = "f6ca6b3f2d56e808f114646c53d0c830e797ab0e35dc55904490b10dc0e9d91f"
    let summonBoardID = "BVdWWXZA"
    var summonBoardURL: String!
    
    init() {
        summonBoardURL = "https://api.trello.com/1/board/\(summonBoardID)?key=\(key)"
    }
}