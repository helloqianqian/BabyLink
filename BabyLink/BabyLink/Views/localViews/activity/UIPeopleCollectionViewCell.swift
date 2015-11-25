//
//  UIPeopleCollectionViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/25.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIPeopleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
    func setContentData(log:NSLogListObject){
        nameLabel.text = log.member_name;
        headIcon.sd_setImageWithURL(NSURL(string: log.member_avar), placeholderImage: UIImage(named: "morentoux"))
    }

}
