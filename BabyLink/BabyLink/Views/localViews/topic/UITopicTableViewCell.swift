//
//  UITopicTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit
@objc protocol UITalkCommentDelegate :NSObjectProtocol{
    optional func didSelectAtIndexPath(infoModel:NSTalkCommentObject);
    optional func didSelectComment(infoModel:NSTalkCommentObject);
}

class UITopicTableViewCell: UITableViewCell ,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,ZLPhotoPickerBrowserViewControllerDataSource,ZLPhotoPickerBrowserViewControllerDelegate{

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var heightOfLabel: NSLayoutConstraint!
    @IBOutlet weak var heightOfCollection: NSLayoutConstraint!
    @IBOutlet weak var heightOfTable: NSLayoutConstraint!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    weak var delegate:UITalkCommentDelegate!;
    var superVC:UIBaseViewController!;
    var talkModel:NSTalk! = NSTalk();
    var indexRow = -1;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        
        headIcon.layer.cornerRadius = 3;
        headIcon.layer.masksToBounds = true;
        
        listTableView.delegate=self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CommentTableViewCellIdentifier")
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.registerNib(UINib(nibName: "TopicImageCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "TopicImageCollectionViewCellIdentifier")
        
    }

    func setContentData(model:NSTalk, withIndexRow row:NSInteger){
        self.talkModel = model;
        self.indexRow = row;
        if self.talkModel.images_url.count == 0{
            heightOfCollection.constant = 0;
        } else if self.talkModel.images_url.count < 3 {
            heightOfCollection.constant = 108;
        }
        headIcon.sd_setImageWithURL(NSURL(string: model.member_avar), placeholderImage: UIImage(named: "morentoux"))
        nameLabel.text = model.member_name;
        contentLabel.text = model.info;
        let infoSize = (model.info as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-80), fromFont: UIFont.systemFontOfSize(13), lineSpace: 3)
        heightOfLabel.constant = infoSize.height+5;
        timeLabel.text = model.add_time;
        heightOfTable.constant = self.talkModel.tableViewHeight;
        self.talkModel.images_url.count
        self.collectionView.reloadData()
        self.listTableView.reloadData();
    }
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10;
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let comment = self.talkModel.commends[indexPath.row] as! NSTalkCommentObject;
        return comment.cellHeight;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        let infoModel = self.talkModel.commends[indexPath.row] as! NSTalkCommentObject;
        infoModel.indexRow = self.indexRow;
        delegate.didSelectAtIndexPath!(infoModel);
    }
    
    @IBAction func commentToHolder(sender: UIButton) {
        let comment = NSTalkCommentObject()
        comment.talk_id = self.talkModel.talk_id;
        comment.from_id = self.talkModel.member_id;
        comment.from_name = self.talkModel.member_name;
        comment.to_id = NSUserInfo.shareInstance().member_id;
        comment.indexRow = self.indexRow;
        delegate.didSelectComment!(comment);
    }
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.talkModel.commends.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCellIdentifier", forIndexPath: indexPath) as! CommentTableViewCell;
        let comment = self.talkModel.commends[indexPath.row] as! NSTalkCommentObject;
        cell.setContentData(comment,withHolder: self.talkModel.member_id);
        return cell;
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.talkModel.images_url.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TopicImageCollectionViewCellIdentifier", forIndexPath: indexPath) as! TopicImageCollectionViewCell;
        cell.contentImage.sd_setImageWithURL(NSURL(string: self.talkModel.images_url[indexPath.row] as! String), placeholderImage: nil)
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pickerBrowser = ZLPhotoPickerBrowserViewController()
        pickerBrowser.delegate = self;
        pickerBrowser.dataSource = self;
        pickerBrowser.editing = false;
        pickerBrowser.currentIndexPath = indexPath;
        pickerBrowser.showPickerVc(self.superVC);
    }
    func numberOfSectionInPhotosInPickerBrowser(pickerBrowser: ZLPhotoPickerBrowserViewController!) -> Int {
        return 1;
    }
    func photoBrowser(photoBrowser: ZLPhotoPickerBrowserViewController!, numberOfItemsInSection section: UInt) -> Int {
        return self.talkModel.images_url.count;
    }
    func photoBrowser(pickerBrowser: ZLPhotoPickerBrowserViewController!, photoAtIndexPath indexPath: NSIndexPath!) -> ZLPhotoPickerBrowserPhoto! {
        let imageUrl = self.talkModel.images_url[indexPath.row] as! String
        let photo = ZLPhotoPickerBrowserPhoto(anyImageObjWith: imageUrl);
        let cell = self.collectionView.cellForItemAtIndexPath(indexPath) as! TopicImageCollectionViewCell;
        photo.toView = cell.contentImage;
        photo.thumbImage = cell.contentImage.image;
        return photo;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
