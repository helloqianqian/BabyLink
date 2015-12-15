//
//  UIFindInfoFirstTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindInfoFirstTableViewCell: UITableViewCell {

    @IBOutlet weak var institutionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reserveLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.borderColor = SGrayBorderColor.CGColor;
        backView.layer.borderWidth = 0.5;
    }

    func setContentData(infoModel:NSInfoFind ,withListModel listModel:NSFind){
        self.institutionLabel.text = listModel.store_name;
        let price = "价格:￥\(listModel.goods_oprice)-￥\(listModel.goods_baseprice)" as NSString;
        priceLabel.attributedText = price.switchContentWithFonts([UIFont.systemFontOfSize(14)], withRanges: [NSStringFromRange(NSMakeRange(0, 3))], withColors: [UIColor.blackColor()])
        addressLabel.text = listModel.address;
        distanceLabel.text = listModel.meters;
        let time = NSHelper.timeStrFromeStamp(infoModel.end_time)
        timeLabel.text = "截止时间:\(time)"
        let order_num = "\(infoModel.order_num)人预定" as NSString;
        reserveLabel.attributedText = order_num.switchContentWithFonts([UIFont.systemFontOfSize(15)], withRanges: [NSStringFromRange(NSMakeRange(order_num.length-2, 2))], withColors: [UIColor.blackColor()])
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
