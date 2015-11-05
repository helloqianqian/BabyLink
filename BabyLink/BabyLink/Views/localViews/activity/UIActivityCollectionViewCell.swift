//
//  UIActivityCollectionViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headIcon.layer.masksToBounds = true;
        headIcon.layer.cornerRadius = 3;
        headIcon.backgroundColor = UIColor.redColor();
    }

}
