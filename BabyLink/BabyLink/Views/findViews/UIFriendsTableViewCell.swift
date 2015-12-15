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
        headIcon.layer.cornerRadius = 3;
        headIcon.layer.masksToBounds = true;
        inviteBtn.makeBackGroundColor_Purple();
    }

    
    func setContentData(friend:NSFriendObject){
        headIcon.sd_setImageWithURL(NSURL(string: friend.friend_avar), placeholderImage: UIImage(named: "morentoux"));
        nameLabel.text = friend.friend_name;
        addressLabel.text = friend.text;
        if friend.status == 1{
            inviteBtn.userInteractionEnabled = true;
            inviteBtn.makeBackGroundColor_Purple();
            inviteBtn.setTitle("邀请", forState: UIControlState.Normal)
        } else {
            inviteBtn.userInteractionEnabled = false;
            inviteBtn.makeBackGroundColor_DarkGray();
            inviteBtn.setTitle("已邀请", forState: UIControlState.Normal)
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
