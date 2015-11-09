//
//  UIFindInfoSecondTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindInfoSecondTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var weixinCircle: UIButton!
    @IBOutlet weak var weixinFriends: UIButton!
    @IBOutlet weak var sinaWeibo: UIButton!
    @IBOutlet weak var qqFriends: UIButton!
    
    @IBOutlet weak var inviteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        self.backView.layer.borderWidth = 0.5;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
