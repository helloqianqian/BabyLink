//
//  UIPersonTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIPersonTableViewCell: UITableViewCell {

    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headIcon.layer.cornerRadius = 3;
        headIcon.layer.masksToBounds = true;
        addBtn.makeBackGroundColor_Purple();
    }

    
    func setContentOfFriends(friend:NSFriendObject) {
        addressLabel.hidden = true;
        addBtn.hidden = false;
        addBtn.setTitle("移除", forState: UIControlState.Normal);
        nameLabel.text = friend.friend_name;
        headIcon.sd_setImageWithURL(NSURL(string: friend.friend_avar), placeholderImage: UIImage(named: "morentoux"));
    }
    func setContentOfNeighbors(neighbor:NSNeighborObject) {
        addBtn.hidden = true;
        addressLabel.hidden = false;
        addressLabel.text = neighbor.home;
        nameLabel.text = neighbor.member_name;
        headIcon.sd_setImageWithURL(NSURL(string: neighbor.member_avar), placeholderImage: UIImage(named: "morentoux"));
    }
    func setContentOfFans(fan:NSFanObject) {
        addressLabel.hidden = true;
        addBtn.setTitle("加关注", forState: UIControlState.Normal);
        headIcon.sd_setImageWithURL(NSURL(string: fan.fans_avar), placeholderImage: UIImage(named: "morentoux"));
        nameLabel.text = fan.fans_name;
        if fan.flag == "1" {
            addBtn.hidden = true;
        } else {
            addBtn.hidden = false;
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
