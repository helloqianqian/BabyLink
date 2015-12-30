//
//  UICenterTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UICenterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var numLabel:UILabel!;
    @IBOutlet weak var contentLabel:UILabel!;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        numLabel.layer.cornerRadius = 8;
        numLabel.layer.masksToBounds = true;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
