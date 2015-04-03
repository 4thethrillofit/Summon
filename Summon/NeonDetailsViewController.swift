//
//  NeonDetailsViewController.swift
//  Summon
//
//  Created by Feifan Wang on 4/1/15.
//  Copyright (c) 2015 Fei. All rights reserved.
//

import UIKit

class NeonDetailsViewController: UIViewController {

    var neon: Neon!
    
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        let bgImageView = UIImageView(image: neon.imageData)
        view.insertSubview(bgImageView, atIndex: 0)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bgImageView.bounds
        view.insertSubview(blurView, aboveSubview: bgImageView)
        
        descriptionTextField.editable = false
        
        nameLabel.text = neon.name
        specialtyLabel.text = neon.specialty.uppercaseString
        descriptionTextField.text = neon.description
    }
}