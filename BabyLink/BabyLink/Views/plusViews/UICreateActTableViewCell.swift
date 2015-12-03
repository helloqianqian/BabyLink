//
//  UICreateActTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UICreateActTableViewCell: UITableViewCell {
    @IBOutlet weak var xingxing: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
