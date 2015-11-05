//
//  UIActivityInfoFirstTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/5.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityInfoFirstTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var activityAddressLabel: UILabel!
    @IBOutlet weak var activityTime: UILabel!
    @IBOutlet weak var limitedNum: UILabel!
    @IBOutlet weak var haveNum: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var payStyleLabel: UILabel!
    @IBOutlet weak var gatherAddressLabel: UILabel!
    
    @IBOutlet weak var toolLabel: UILabel!
    @IBOutlet weak var leaderLabel: UILabel!
    
    @IBOutlet weak var phoneNumLabel: UILabel!
    
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        contentImage.backgroundColor = UIColor.redColor()
        
        headIcon.layer.masksToBounds = true;
        headIcon.layer.cornerRadius = 3;
        headIcon.backgroundColor = UIColor.redColor()
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
