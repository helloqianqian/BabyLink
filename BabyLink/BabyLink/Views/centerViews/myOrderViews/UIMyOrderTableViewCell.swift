//
//  UIMyOrderTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIMyOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var payTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var payBtn: UIButton!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.borderColor = SGrayBorderColor.CGColor;
        backView.layer.borderWidth = 0.5;
        
        payBtn.makeBackGroundColor_Purple();
        cancelBtn.makeBackGroundColor_Gray()
    }

    func setContentData(order:NSOrder) {
        statusLabel.hidden = true;
        
        payBtn.setTitle("支付尾款", forState: UIControlState.Normal)
        payBtn.hidden = false;
        
        contentImage.sd_setImageWithURL(NSURL(string: order.good.image_url), placeholderImage: nil);
        titleLabel.text = order.good.goods_name;
        payTitleLabel.text = "已付订金:"
        priceLabel.text = "￥\(order.good.goods_dingjin)";
        if order.good.end_status == 0 {
            cancelBtn.hidden = false;
            payBtn.makeBackGroundColor_PurpleDisabel();
        } else {
            cancelBtn.hidden = true;
            payBtn.makeBackGroundColor_Purple();
        }
    }
    
    func setPayedContentData(order:NSOrder) {
        cancelBtn.hidden = true;
        if order.order_status == 2 || order.order_status == 4 {
            statusLabel.hidden = false;
            statusLabel.text = order.order_status_desc;
            payBtn.makeBackGroundColor_Gray();
            let weikuan = order.good.goods_weikuan as NSString;
            if weikuan.floatValue == 0 {
                payBtn.setTitle("取消订单", forState: UIControlState.Normal);
            } else {
                payBtn.setTitle("退尾款", forState: UIControlState.Normal);
            }
            payBtn.hidden = false;
        } else {
            statusLabel.hidden = true;
            payBtn.hidden = true;
        }
        
        contentImage.sd_setImageWithURL(NSURL(string: order.good.image_url), placeholderImage: nil);
        titleLabel.text = order.good.goods_name;
        payTitleLabel.text = "实付款:"
        priceLabel.text = "￥\(order.good.goods_price)";
        
        tipLabel.text = "订金：￥\(order.good.goods_dingjin) 尾款：￥\(order.good.goods_weikuan) 共计：￥\(order.good.goods_price)"        
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
