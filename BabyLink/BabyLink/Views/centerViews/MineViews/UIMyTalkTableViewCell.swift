//
//  UIMyTalkTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/2.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIMyTalkTableViewCell: UITableViewCell {

    @IBOutlet weak var heightInfo: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var commetLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5;
        backView.layer.masksToBounds = true;
        
        headIcon.layer.cornerRadius = 3;
        headIcon.layer.masksToBounds = true;
        
    }

    func setContentData(talkModel:NSTalk){
        headIcon.sd_setImageWithURL(NSURL(string: talkModel.member_avar), placeholderImage: nil);
        nameLabel.text = talkModel.member_name;
        timeLabel.text = talkModel.add_time;
        heightInfo.constant = talkModel.tableViewHeight;
        infoLabel.text = talkModel.info;
        let str = "有\(talkModel.commends.count)人评论" as NSString
        commetLabel.attributedText = str.switchContentWithFonts([UIFont.systemFontOfSize(13)], withRanges: [NSStringFromRange(NSMakeRange(1, ("\(talkModel.commends.count)" as NSString).length))], withColors: [SPurpleBtnColor]);        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
