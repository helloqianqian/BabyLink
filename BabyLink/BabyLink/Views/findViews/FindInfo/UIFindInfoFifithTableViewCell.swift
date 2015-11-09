//
//  UIFindInfoFifithTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/9.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindInfoFifithTableViewCell: UITableViewCell {

    @IBOutlet weak var contactInfo: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var customStyle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.layer.borderWidth = 0.5;
        self.backView.layer.borderColor = hexRGB(0xACACB4).CGColor;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
