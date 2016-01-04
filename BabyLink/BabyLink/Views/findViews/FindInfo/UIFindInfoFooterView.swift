//
//  UIFindInfoFooterView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/9.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindInfoFooterView: UIView {

    @IBOutlet weak var originPriceBtn: UIButton!
    @IBOutlet weak var prePayBtn: UIButton!
    
    @IBOutlet weak var originPriceLabel: UILabel!
    @IBOutlet weak var prePayLabel: UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    func setContent(infoModel:NSInfoFind){
        originPriceLabel.text = "现价\n￥\(infoModel.goods_price)"
        if infoModel.flag == "1" {
            prePayLabel.text = "我要预定\n￥\(infoModel.goods_dingjin)"
            prePayBtn.enabled = true;
        } else {
            prePayLabel.text = "团购结束\n￥\(infoModel.goods_dingjin)"
            prePayBtn.enabled = false;
            prePayBtn.backgroundColor = hexRGB(0x8F9091);
        }
    }

}
