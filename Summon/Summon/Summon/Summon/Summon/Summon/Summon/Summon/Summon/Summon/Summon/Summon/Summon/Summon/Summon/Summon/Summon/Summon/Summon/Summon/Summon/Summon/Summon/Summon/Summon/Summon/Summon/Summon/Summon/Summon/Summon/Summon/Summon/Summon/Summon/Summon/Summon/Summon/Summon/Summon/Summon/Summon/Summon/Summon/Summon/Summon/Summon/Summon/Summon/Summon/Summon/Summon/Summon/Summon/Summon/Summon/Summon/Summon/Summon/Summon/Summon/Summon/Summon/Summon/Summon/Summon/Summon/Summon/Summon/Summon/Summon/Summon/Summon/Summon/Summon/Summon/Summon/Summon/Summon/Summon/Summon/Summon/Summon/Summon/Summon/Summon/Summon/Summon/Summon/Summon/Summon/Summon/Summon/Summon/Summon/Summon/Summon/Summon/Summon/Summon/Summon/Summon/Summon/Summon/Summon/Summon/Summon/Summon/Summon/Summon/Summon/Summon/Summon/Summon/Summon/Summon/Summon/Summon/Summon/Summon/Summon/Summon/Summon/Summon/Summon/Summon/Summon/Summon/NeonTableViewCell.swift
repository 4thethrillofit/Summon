//
//  NeonTableViewCell.swift
//  Summon
//
//  Created by Feifan Wang on 3/30/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit

class NeonTableViewCell: UITableViewCell {

    @IBOutlet weak var neonNameLabel: UILabel!
    @IBOutlet weak var neonImageView: UIImageView!
    @IBOutlet weak var neonSpecialtyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
