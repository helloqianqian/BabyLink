//
//  UIFindInviteTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/29.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindInviteTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 4;
        backView.layer.masksToBounds = true;
        
        headIcon.layer.cornerRadius = 3;
        headIcon.layer.masksToBounds = true;
        
        
    }

    
    func setContentData(findModel:NSFind){
        headIcon.sd_setImageWithURL(NSURL(string: findModel.member_avar), placeholderImage: UIImage(named: "morentoux"));
        nameLabel.text = findModel.member_name;
        titleLabel.text = findModel.store_name;
        
        if findModel.flag == "1" {
            checkBtn.setTitle("查看", forState: UIControlState.Normal);
            checkBtn.makeBackGroundColor_Purple();
        } else {
            checkBtn.setTitle("已结束", forState: UIControlState.Normal);
            checkBtn.makeBackGroundColor_DarkGray();
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
