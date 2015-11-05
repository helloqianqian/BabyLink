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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        contentImage.backgroundColor = UIColor.redColor()
        headIcon.backgroundColor = UIColor.redColor()
        
        signInBtn.makeBackGroundColor_Purple()
        
        headCollection.registerNib(UINib.init(nibName: "UIActivityCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "UIActivityCollectionViewCellIndentifier")
        headCollection.backgroundColor = UIColor.clearColor()
        
    }

    func resetCellContent(dataModel:AnyObject){
        headCollection.reloadData();
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UIActivityCollectionViewCellIndentifier", forIndexPath:indexPath) as! UIActivityCollectionViewCell
        return cell;
        
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
