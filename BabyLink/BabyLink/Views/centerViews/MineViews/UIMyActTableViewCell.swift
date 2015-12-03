//
//  UIMyActTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIMyActTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var activityImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 4;
        backView.layer.masksToBounds = true;
    }

    func setActivityData(actModel:NSActListObject){
        cancelBtn.hidden = true;
        checkBtn.userInteractionEnabled = false;
        if actModel.status == 1 {
            checkBtn.makeBackGroundColor_Purple();
        } else {
            checkBtn.makeBackGroundColor_DarkGray();
        }
        checkBtn.setTitle(actModel.status_desc, forState: UIControlState.Normal)
        activityImg.sd_setImageWithURL(NSURL(string: actModel.image_url), placeholderImage: nil);
        titleLabel.text = actModel.title;
        timeLabel.text = actModel.jihe_time;
        subLabel.hidden = true;
    }
    
    func setShowData(xiu:NSXiu){
        activityImg.sd_setImageWithURL(NSURL(string: xiu.image_url), placeholderImage: nil);
        titleLabel.text = xiu.info;
        timeLabel.hidden = true;
        subLabel.hidden = true;
        cancelBtn.hidden = true;
        checkBtn.makeBackGroundColor_Purple();
        checkBtn.userInteractionEnabled = false;
        checkBtn.setTitle("查看详情", forState: UIControlState.Normal)
    }
    func setExchangeData(exchange:NSExchange){
        subLabel.hidden = true;
        activityImg.sd_setImageWithURL(NSURL(string: exchange.image_url), placeholderImage: nil)
        titleLabel.text = exchange.from_gname;
        timeLabel.text = exchange.add_time;
        if exchange.status == "0" {
            checkBtn.hidden = true;
            cancelBtn.hidden = true;
        } else if exchange.status == "1" {
            checkBtn.hidden = false;
            checkBtn.enabled = true;
            cancelBtn.hidden = false;
            checkBtn.makeBackGroundColor_Purple();
            checkBtn.setTitle("置换完成", forState: UIControlState.Normal);
            cancelBtn.makeBackGroundColor_Purple();
            cancelBtn.setTitle("取消置换", forState: UIControlState.Normal)
        } else {
            cancelBtn.hidden = true;
            
            checkBtn.enabled = false;
            checkBtn.hidden = false;
            checkBtn.makeBackGroundColor_DarkGray()
            checkBtn.setTitle("置换完成", forState: UIControlState.Normal);
        }
    }
    func setTopicData(indexPath:NSIndexPath){
        checkBtn.makeBackGroundColor_Purple();
        checkBtn.setTitle("查看详情", forState: UIControlState.Normal)
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
