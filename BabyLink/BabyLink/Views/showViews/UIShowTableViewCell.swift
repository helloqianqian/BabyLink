//
//  UIShowTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIShowTableViewCell: UITableViewCell ,UICollectionViewDataSource{

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var focusBtn: UIButton!
    
    @IBOutlet weak var numOfDouLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var douBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var tipLabel1: UILabel!
    @IBOutlet weak var tipLabel2: UILabel!
    @IBOutlet weak var tipLabel3: UILabel!
    @IBOutlet weak var heightOfInfo: NSLayoutConstraint!
    
    @IBOutlet weak var zanBtn: UIButton!
    @IBOutlet weak var zanListCollection: UICollectionView!
    var xiu:NSXiu!;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        headIcon.layer.masksToBounds = true;
        headIcon.layer.cornerRadius = 3;
        
        focusBtn.makeBackGroundColor_Purple();
        douBtn.makeBackGroundColor_Purple();
        
        zanListCollection.dataSource = self;
        zanListCollection.registerNib(UINib(nibName: "UIActivityCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "showZanlistCellID");
        
        //UIActivityCollectionViewCell
    }

    func setContentDataFormLink(link:NSXiu){
        self.xiu = link;
        self.focusBtn.hidden = true;
        headIcon.sd_setImageWithURL(NSURL(string: link.member_avar), placeholderImage: UIImage(named: "morentoux"))
        nameLabel.text = link.member_name;
        timeLabel.text = link.time;
        contentImage.sd_setImageWithURL(NSURL(string: link.image_url), placeholderImage: nil);
        numOfDouLabel.text = "\(link.commends.count)逗"
        contentLabel.text = link.info;
        heightOfInfo.constant = link.infoHeight;
        zanBtn.selected = link.isZan;
        
        zanListCollection.reloadData()
    }
    
    func setContentDataFromSqu(square:NSXiu){
        self.xiu = square;
        headIcon.sd_setImageWithURL(NSURL(string: square.member_avar), placeholderImage: UIImage(named: "morentoux"))
        nameLabel.text = square.member_name;
        timeLabel.text = square.time;
        contentImage.sd_setImageWithURL(NSURL(string: square.image_url), placeholderImage: nil);
        numOfDouLabel.text = "\(square.commends.count)逗"
        contentLabel.text = square.info;
        heightOfInfo.constant = square.infoHeight;
        zanBtn.selected = square.isZan;
        
        zanListCollection.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.xiu.zans.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("showZanlistCellID", forIndexPath: indexPath) as! UIActivityCollectionViewCell;
        let zan = self.xiu.zans[indexPath.row] as! NSXiuZan;
        cell.headIcon.sd_setImageWithURL(NSURL(string: zan.member_avar), placeholderImage: UIImage(named: "morentoux"))
        return cell;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
