//
//  UIExchangeTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIExchangeTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var villageLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var haveIcon: UILabel!
    @IBOutlet weak var changeIcon: UILabel!
    @IBOutlet weak var haveLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        haveIcon.layer.masksToBounds = true;
        haveIcon.layer.cornerRadius = 8;
        changeIcon.layer.masksToBounds = true;
        changeIcon.layer.cornerRadius = 8;
        
        contentImage.backgroundColor = UIColor.redColor();
        
        checkBtn.makeBackGroundColor_Purple();
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
