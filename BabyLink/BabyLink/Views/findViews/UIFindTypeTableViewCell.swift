//
//  UIFindTypeTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        numLabel.layer.cornerRadius = 9;
        numLabel.layer.masksToBounds = true;
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
