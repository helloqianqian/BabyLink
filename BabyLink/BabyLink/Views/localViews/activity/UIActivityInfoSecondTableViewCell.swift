//
//  UIActivityInfoSecondTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/5.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityInfoSecondTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var introduceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
    }

    func resetContent(infoModel:NSActInfoObject, AtIndexPath row:Int){
        if row == 1 {
            titleLabel.text = "活动介绍";
            introduceLabel.text = infoModel.info;
            
        } else {
            titleLabel.text = "babylink已提供支持"
            introduceLabel.text = infoModel.help;
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
