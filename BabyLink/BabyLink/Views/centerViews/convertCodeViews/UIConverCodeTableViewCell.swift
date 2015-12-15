//
//  UIConverCodeTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIConverCodeTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var centerNameLabel: UILabel!
    @IBOutlet weak var deadLineLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.borderWidth = 0.5;
        backView.layer.borderColor = SGrayBorderColor.CGColor;
    }

    func setcontentData(order:NSOrder){
        centerNameLabel.text = order.good.goods_name;
        deadLineLabel.text = "有效期至\(order.good.use_time)"
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
