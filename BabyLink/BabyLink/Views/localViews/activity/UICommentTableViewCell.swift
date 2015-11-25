//
//  UICommentTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/25.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit



class UICommentTableViewCell: UITableViewCell {

    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headIcon.layer.masksToBounds = true;
        headIcon.layer.cornerRadius = 3;
    }

    
    func setContentData(infoModel:NSCommentObject){
        headIcon.sd_setImageWithURL(NSURL(string: infoModel.from_userAvar), placeholderImage: UIImage(named: "morentoux"))
        if infoModel.to_userId == NSUserInfo.shareInstance().member_id {
            nameLabel.text = infoModel.from_userName;
        } else {
            let attribute1 = [NSForegroundColorAttributeName : UIColor.blackColor() ,NSFontAttributeName:UIFont.systemFontOfSize(13.0)];
            let infoStr = NSMutableAttributedString(string: "\(infoModel.from_userName)回复\(infoModel.to_userName)")
            infoStr.setAttributes(attribute1, range: NSMakeRange((infoModel.from_userName as NSString).length, 2));
            nameLabel.attributedText = infoStr;
        }
        timeLabel.text = infoModel.add_time;
        contentLabel.text = infoModel.info;
        contentLabel.sizeToFit()
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
