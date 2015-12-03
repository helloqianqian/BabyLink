//
//  UIFriendsTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/9.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var inviteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headIcon.backgroundColor = UIColor.redColor();
        inviteBtn.makeBackGroundColor_Purple();
    }

    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
