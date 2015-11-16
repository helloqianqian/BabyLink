//
//  UIFindTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var earnestLabel: UILabel!
    
    @IBOutlet weak var institutionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 4;
        backView.layer.masksToBounds = true;
        
        self.earnestLabel.text = "定金\n￥29.00";        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
