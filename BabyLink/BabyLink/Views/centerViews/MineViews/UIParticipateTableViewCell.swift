//
//  UIParticipateTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/2.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIParticipateTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var headIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5;
        backView.layer.masksToBounds = true;
        headIcon.layer.cornerRadius = 3;
        headIcon.layer.masksToBounds = true;
    }

    func setContentData(log:NSLogListObject){
        headIcon.sd_setImageWithURL(NSURL(string: log.member_avar), placeholderImage: UIImage(named: "morentoux"))
        contentLabel.text = "姓名：\(log.link_man)\n联系方式：\(log.member_mobile)\n参与人数：\(log.num)人"
        nickName.text = log.member_name;
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
