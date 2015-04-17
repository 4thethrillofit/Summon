//
//  NeonSelfSelectionTableViewCell.swift
//  Summon
//
//  Created by Feifan Wang on 4/17/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit

class NeonSelfSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var neonImageView: UIImageView!
    @IBOutlet weak var neonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
