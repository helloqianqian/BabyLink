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
    
//    @IBOutlet weak var heightImage: NSLayoutConstraint!
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
//            contentImage.sd_setImageWithURL(NSURL(string: infoModel.images[0] as! String), placeholderImage: nil) { (image, error, type, url) -> Void in
//                if image != nil {
//                    self.contentImage.image = image;
//                    self.heightImage.constant = self.contentImage.frame.size.width / image.size.width * image.size.height;
//                }
//            }
        }
        self.titleLabel.text = infoModel.title;
        self.activityAddressLabel.text = "活动地点:  \(infoModel.activity_address)";
        self.activityTime.text = "报名截止:  \(infoModel.end_time)";
        self.limitedNum.text = "集合时间:  \(infoModel.jihe_time)";
        self.haveNum.text = "集合地点:  \(infoModel.jihe_address)"
        self.costLabel.text = "上限人数:  \(infoModel.max_man)"
        let cost = "报名费用:  ￥\(infoModel.price)" as NSString;
        self.payStyleLabel.attributedText = cost.switchContentWithFonts([UIFont.systemFontOfSize(13)], withRanges: [NSStringFromRange(NSMakeRange(7, cost.length-7))], withColors: [SPurpleBtnColor]);
        self.gatherAddressLabel.text = "支付方式:  \(infoModel.pay_way)";
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
