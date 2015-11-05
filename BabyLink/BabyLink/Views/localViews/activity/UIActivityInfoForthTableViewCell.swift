//
//  UIActivityInfoForthTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/5.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityInfoForthTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var commentNumLabel: UILabel!
    @IBOutlet weak var headIcon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commetLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        headIcon.layer.masksToBounds = true;
        headIcon.layer.cornerRadius = 3;
        headIcon.backgroundColor = UIColor.redColor();
        
        commentBtn.makeBackGroundColor_Purple();
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
