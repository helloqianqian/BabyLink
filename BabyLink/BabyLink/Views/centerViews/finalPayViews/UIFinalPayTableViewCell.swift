//
//  UIFinalPayTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFinalPayTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var centerIcon: UIImageView!
    @IBOutlet weak var centerName: UILabel!
    
    @IBOutlet weak var finalPriceLabel: UILabel!
    
    @IBOutlet weak var weifukuanLabel: UILabel!
    @IBOutlet weak var payPriceLabel: UILabel!
    @IBOutlet weak var leftPriceLabel: UILabel!
    @IBOutlet weak var payBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.borderWidth = 0.5;
        backView.layer.borderColor = SGrayBorderColor.CGColor;
        
        payBtn.makeBackGroundColor_Purple();
        
    }

    func setContentData(order:NSOrder) {
        centerIcon.sd_setImageWithURL(NSURL(string: order.good.image_url), placeholderImage: nil)
        centerName.text = order.good.goods_name;
        finalPriceLabel.text = "定价：￥\(order.good.goods_price)";
        payPriceLabel.text = "已付：￥\(order.good.goods_dingjin)"
        leftPriceLabel.text = "￥\(order.good.goods_weikuan)";
        if order.good.end_status == 0 {
            payBtn.enabled = false;
        } else {
            payBtn.enabled = true;
        }
    }
    
    func setListContentData(order:NSOrder){
        centerIcon.sd_setImageWithURL(NSURL(string: order.good.image_url), placeholderImage: nil)
        centerName.text = order.good.goods_name;
        finalPriceLabel.text = "定价:￥\(order.good.goods_price)";
        
        payBtn.makeBackGroundColor_Gray();
        payBtn.enabled = false;
        if order.order_status == 3 {
            payBtn.setTitle("已退款", forState: UIControlState.Normal)
        } else {
            payBtn.setTitle("退款中", forState: UIControlState.Normal)
        }
        if order.refund_status == 0 {
            //定金
            payPriceLabel.text = "订金:￥\(order.good.goods_dingjin)"
            weifukuanLabel.text = "已退订金"
            leftPriceLabel.text = "￥\(order.good.goods_dingjin)";
        } else {
            payPriceLabel.text = "订金:￥\(order.good.goods_dingjin) 尾款:￥\(order.good.goods_weikuan)"
            weifukuanLabel.text = "已退尾款"
            leftPriceLabel.text = "￥\(order.good.goods_weikuan)";
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
