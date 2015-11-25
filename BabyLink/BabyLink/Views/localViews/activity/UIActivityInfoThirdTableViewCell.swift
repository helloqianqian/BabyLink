//
//  UIActivityInfoThirdTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/5.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityInfoThirdTableViewCell: UITableViewCell ,UICollectionViewDataSource{

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var joinNumLabel: UILabel!
    
    @IBOutlet weak var joinCollectionView: UICollectionView!
    
    @IBOutlet weak var widthofcell: NSLayoutConstraint!
    var model:NSActInfoObject! = NSActInfoObject();
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        joinCollectionView.dataSource = self;
        joinCollectionView.registerNib(UINib(nibName: "UIPeopleCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "peopleCellIdentifier")
        if iphone6Plus || iphone6{
            widthofcell.constant = 324;
        }
        
    }

    func setContentData(infoModel:NSActInfoObject){
        self.model = infoModel;
        let text = "参与人数（\(infoModel.count)人）" as NSString
        joinNumLabel.attributedText = text.switchContentWithFonts([UIFont.systemFontOfSize(13)], withRanges: [NSStringFromRange(NSMakeRange(5, text.length-6))], withColors: [SPurpleBtnColor])
        self.joinCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.logs.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("peopleCellIdentifier", forIndexPath: indexPath) as! UIPeopleCollectionViewCell;
        let log = self.model.logs[indexPath.row] as! NSLogListObject;
        cell.setContentData(log);
        return cell;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
