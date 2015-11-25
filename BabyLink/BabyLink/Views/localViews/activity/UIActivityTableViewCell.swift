//
//  UIActivityTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityTableViewCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource{

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
        
        signInBtn.makeBackGroundColor_Purple()
        
        headCollection.registerNib(UINib.init(nibName: "UIActivityCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "UIActivityCollectionViewCellIndentifier")
        headCollection.backgroundColor = UIColor.clearColor()
        
    }

    func resetCellContent(dataModel:NSActListObject){
        self.dataModel = dataModel;
        contentImage.sd_setImageWithURL(NSURL(string: dataModel.image_url), placeholderImage: nil);
        titleLabel.text = dataModel.title;
        
        
        let attribute1 = [NSForegroundColorAttributeName : SRedBtnColor ,NSFontAttributeName:UIFont.systemFontOfSize(13.0)];
        let infoStr = NSMutableAttributedString(string: "\(dataModel.activity_address)  已有\(dataModel.count)人报名")
        infoStr.setAttributes(attribute1, range: NSMakeRange((dataModel.activity_address as NSString).length+2, ("已有\(dataModel.count)人报名" as NSString).length))
        addressLabel.attributedText = infoStr;
        
        timeLabel.text = "时间:\(dataModel.jihe_time)";
        nameLabel.text = dataModel.member_name;
        headIcon.sd_setImageWithURL(NSURL(string: dataModel.member_avar), placeholderImage: UIImage(named: "morentoux"));
        
        headCollection.reloadData();
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataModel.logs_list.count;
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
