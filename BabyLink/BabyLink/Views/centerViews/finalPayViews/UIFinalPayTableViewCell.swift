//
//  UIFinalPayTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFinalPayTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var centerIcon: UIImageView!
    @IBOutlet weak var centerName: UILabel!
    
    @IBOutlet weak var finalPriceLabel: UILabel!
    
    @IBOutlet weak var payPriceLabel: UILabel!
    @IBOutlet weak var leftPriceLabel: UILabel!
    @IBOutlet weak var payBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.borderWidth = 0.5;
        backView.layer.borderColor = SGrayBorderColor.CGColor;
        
        payBtn.makeBackGroundColor_Purple();
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
