//
//  UIFindTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var earnestLabel: UILabel!
    
    @IBOutlet weak var institutionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 4;
        backView.layer.masksToBounds = true;
    }
        
    func setContentData(findModel:NSFind){
        contentImage.sd_setImageWithURL(NSURL(string: findModel.image_url), placeholderImage: nil);
        let str = findModel.goods_dingjin as NSString
        if str.floatValue == 0 {
            earnestLabel.text = "免费"
        } else {
            earnestLabel.text = "定金\n￥\(findModel.goods_dingjin)"
        }
        
        institutionLabel.text = findModel.store_name;
        let price = "价格:￥\(findModel.goods_oprice)-￥\(findModel.goods_baseprice)" as NSString;
        priceLabel.attributedText = price.switchContentWithFonts([UIFont.systemFontOfSize(14)], withRanges: [NSStringFromRange(NSMakeRange(0, 3))], withColors: [UIColor.blackColor()])
        addressLabel.text = findModel.address;
        distanceLabel.text = findModel.meters;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
