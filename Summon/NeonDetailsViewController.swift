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
    @IBOutlet weak var dismissViewBtn: UIButton!
    @IBOutlet weak var summonBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        addBlurredBgImage()
        descriptionTextField.editable = false
        
        nameLabel.text = neon.name
        specialtyLabel.text = neon.specialty.uppercaseString
        descriptionTextField.text = neon.description
        dismissViewBtn.setTitle(String(format: "%C", 0xf00d), forState: UIControlState.Normal)
//        summonBtn.setImage(UIImage(named: "sword-icon"), forState: UIControlState.Normal)
    }
    
    @IBAction func summonBtnPressed(sender: UIButton) {
        SlackClient.summonUser(neon.slackHandle)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func dismissViewBtnPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addBlurredBgImage() {
        let bgImageView = UIImageView(image: neon.imageData)
        view.insertSubview(bgImageView, atIndex: 0)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bgImageView.bounds
        view.insertSubview(blurView, aboveSubview: bgImageView)
    }
}