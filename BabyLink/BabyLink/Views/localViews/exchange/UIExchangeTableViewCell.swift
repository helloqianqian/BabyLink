//
//  UIExchangeTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIExchangeTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var villageLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var haveIcon: UILabel!
    @IBOutlet weak var changeIcon: UILabel!
    @IBOutlet weak var haveLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var heightImage: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        headIcon.layer.cornerRadius = 3;
        headIcon.layer.masksToBounds = true;
        
        haveIcon.layer.masksToBounds = true;
        haveIcon.layer.cornerRadius = 8;
        changeIcon.layer.masksToBounds = true;
        changeIcon.layer.cornerRadius = 8;
        
        checkBtn.makeBackGroundColor_Purple();
        
    }

    
    func setContentData(exchange:NSExchange){
        headIcon.sd_setImageWithURL(NSURL(string: exchange.member_avar), placeholderImage: UIImage(named: "morentoux"))
        nameLabel.text = exchange.member_name;
        villageLabel.text = exchange.home;
        
        contentImage.sd_setImageWithURL(NSURL(string: exchange.image_url), placeholderImage: nil) { (image, error, type, url) -> Void in
            if image != nil {
                self.contentImage.image = image;
                self.heightImage.constant = self.contentImage.frame.size.width / image.size.width * image.size.height;
            }
        }
        
        haveLabel.text = exchange.from_gname;
        changeLabel.text = exchange.to_gname;
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
