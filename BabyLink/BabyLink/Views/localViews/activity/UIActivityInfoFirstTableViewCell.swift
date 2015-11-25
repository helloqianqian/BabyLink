//
//  UIActivityInfoFirstTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/5.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityInfoFirstTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var activityAddressLabel: UILabel!
    @IBOutlet weak var activityTime: UILabel!
    @IBOutlet weak var limitedNum: UILabel!
    @IBOutlet weak var haveNum: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var payStyleLabel: UILabel!
    @IBOutlet weak var gatherAddressLabel: UILabel!
    
    @IBOutlet weak var toolLabel: UILabel!
    @IBOutlet weak var leaderLabel: UILabel!
    
    @IBOutlet weak var phoneNumLabel: UILabel!
    
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        headIcon.layer.masksToBounds = true;
        headIcon.layer.cornerRadius = 3;
    }

    func setContentData(infoModel:NSActInfoObject) {
        if infoModel.images.count>0{
            self.contentImage.sd_setImageWithURL(NSURL(string: infoModel.images[0] as! String), placeholderImage: nil);
        }
        self.titleLabel.text = infoModel.title;
        self.activityAddressLabel.text = "活动地点:  \(infoModel.activity_address)";
        self.activityTime.text = "活动时间:  \(infoModel.jihe_time)";
        self.limitedNum.text = "上限人数:  \(infoModel.max_man)人";
        
        let text = "报名人数:  \(infoModel.count)人" as NSString;
        self.haveNum.attributedText = text.switchContentWithFonts([UIFont.systemFontOfSize(13)], withRanges: [NSStringFromRange(NSMakeRange(7, text.length-7))], withColors: [SPurpleBtnColor]);
        let cost = "报名费用:  ￥\(infoModel.price)" as NSString;
        self.costLabel.attributedText = cost.switchContentWithFonts([UIFont.systemFontOfSize(13)], withRanges: [NSStringFromRange(NSMakeRange(7, cost.length-7))], withColors: [SPurpleBtnColor]);
        self.payStyleLabel.text = "支付方式:  \(infoModel.pay_way)";
        self.gatherAddressLabel.text = "集合地方:  \(infoModel.jihe_address)"
        self.toolLabel.text = "交通工具:  \(infoModel.utils)"
        self.leaderLabel.text = "联系人:  \(infoModel.link_name)"
        self.phoneNumLabel.text = "联系电话:  \(infoModel.link_mobile)"
        
        headIcon.sd_setImageWithURL(NSURL(string: infoModel.member_avar), placeholderImage: UIImage(named: "morentoux"));
        nameLabel.text = infoModel.member_name;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
