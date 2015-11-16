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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 4;
        backView.layer.masksToBounds = true;
//        checkBtn.makeBackGroundColor_Purple();
    }

    func setActivityData(indexPath:NSIndexPath){
        checkBtn.enabled = false;
        if indexPath.row > 4 {
            checkBtn.makeBackGroundColor_DarkGray();
            checkBtn.setTitle("已结束", forState: UIControlState.Normal)
            subLabel.hidden = true;
        } else {
            checkBtn.makeBackGroundColor_Purple();
            checkBtn.setTitle("进行中", forState: UIControlState.Normal)
            subLabel.hidden = false;
        }
    }
    
    func setShowData(indexPath:NSIndexPath){
        titleLabel.text = "大家看看这种照片"
        timeLabel.hidden = true;
        subLabel.hidden = true;
        checkBtn.makeBackGroundColor_Purple();
        checkBtn.setTitle("查看详情", forState: UIControlState.Normal)
    }
    func setExchangeData(indexPath:NSIndexPath){
        checkBtn.enabled = false;
        titleLabel.text = "玩具一个";
        subLabel.hidden = true;
        if indexPath.row > 4 {
            checkBtn.makeBackGroundColor_DarkGray();
            checkBtn.setTitle("置换完成", forState: UIControlState.Normal)
        } else {
            checkBtn.makeBackGroundColor_Purple();
            checkBtn.setTitle("待确认", forState: UIControlState.Normal)
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
