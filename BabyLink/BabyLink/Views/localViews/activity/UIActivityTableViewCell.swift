//
//  UIActivityTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityTableViewCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource{

//    @IBOutlet weak var heightImage: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headCollection: UICollectionView!
    @IBOutlet weak var signInBtn: UIButton!
    
    var dataModel:NSActListObject!;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        headIcon.layer.cornerRadius = 3;
        headIcon.layer.masksToBounds = true;
        
        headCollection.registerNib(UINib(nibName: "UIActivityCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "UIActivityCollectionViewCellIndentifier")
        headCollection.backgroundColor = UIColor.clearColor()
        
    }

    func resetCellContent(dataModel:NSActListObject, withIndex indexPath:NSIndexPath ,withHoldView fromView:UIView){
        self.dataModel = dataModel;
        contentImage.sd_setImageWithURL(NSURL(string: dataModel.image_url), placeholderImage: nil);
//        contentImage.sd_setImageWithURL(NSURL(string: dataModel.image_url), placeholderImage: nil) { (image, error, type, url) -> Void in
//            if image != nil {
//                self.contentImage.image = image;
//                self.heightImage.constant = self.contentImage.frame.size.width / image.size.width * image.size.height;
//            }
//        }
        titleLabel.text = dataModel.title;
        
        let attribute1 = [NSForegroundColorAttributeName : SRedBtnColor ,NSFontAttributeName:UIFont.systemFontOfSize(13.0)];
        let infoStr = NSMutableAttributedString(string: "\(dataModel.activity_address)  已有\(dataModel.count)人报名")
        infoStr.setAttributes(attribute1, range: NSMakeRange((dataModel.activity_address as NSString).length+2, ("已有\(dataModel.count)人报名" as NSString).length))
        addressLabel.attributedText = infoStr;
        
        timeLabel.text = "集合时间:\(dataModel.jihe_time)";
        nameLabel.text = dataModel.member_name;
        headIcon.sd_setImageWithURL(NSURL(string: dataModel.member_avar), placeholderImage: UIImage(named: "morentoux"));
        
        signInBtn.tag = indexPath.row;
        signInBtn.addTarget(fromView, action: "joinTheActivity:", forControlEvents: UIControlEvents.TouchUpInside);
        if dataModel.isOut {
            signInBtn.makeBackGroundColor_DarkGray()
            signInBtn.setTitle("活动已结束", forState: UIControlState.Normal);
        } else {
            if dataModel.isSign {
                signInBtn.makeBackGroundColor_DarkGray()
                signInBtn.setTitle("取消报名", forState: UIControlState.Normal);
            } else {
                if dataModel.isFull {
                    signInBtn.makeBackGroundColor_DarkGray()
                    signInBtn.setTitle("报名已满", forState: UIControlState.Normal);
                } else {
                    signInBtn.makeBackGroundColor_Purple()
                    signInBtn.setTitle("我要报名", forState: UIControlState.Normal);
                }
            }
        }
        headCollection.reloadData();
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if iphone6 || iphone6Plus {
            return self.dataModel.logs_list.count>6 ? 6 : self.dataModel.logs_list.count;
        }
        return self.dataModel.logs_list.count>5 ? 5 : self.dataModel.logs_list.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UIActivityCollectionViewCellIndentifier", forIndexPath:indexPath) as! UIActivityCollectionViewCell
        let log = self.dataModel.logs_list.objectAtIndex(indexPath.row);
        cell.headIcon.sd_setImageWithURL(NSURL(string: log.member_avar), placeholderImage: UIImage(named: "morentoux"))
        return cell;
        
    }    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
