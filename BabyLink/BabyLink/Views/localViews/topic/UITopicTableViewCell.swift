//
//  UITopicTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UITopicTableViewCell: UITableViewCell ,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        listTableView.delegate=self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UILikeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UILikeTableViewCellIdentifier");
        listTableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CommentTableViewCellIdentifier")
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        
        
    }

    //MARK: - UITableViewDelegate
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UILikeTableViewCellIdentifier", forIndexPath: indexPath)
            return cell;
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCellIdentifier", forIndexPath: indexPath)
            return cell;
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
