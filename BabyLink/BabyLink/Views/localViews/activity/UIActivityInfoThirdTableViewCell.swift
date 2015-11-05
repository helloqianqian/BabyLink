//
//  UIActivityInfoThirdTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/5.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityInfoThirdTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var joinNumLabel: UILabel!
    
    @IBOutlet weak var joinCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
