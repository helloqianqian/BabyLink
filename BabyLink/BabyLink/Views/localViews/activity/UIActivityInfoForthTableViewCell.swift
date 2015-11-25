//
//  UIActivityInfoForthTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/5.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

@objc protocol UICommentDelegate :NSObjectProtocol{
    optional func didSelectedAtIndexPath(infoModel:NSCommentObject);
    optional func didSelectedComment();
    optional func didSpreadComments(spread:Bool)
}

class UIActivityInfoForthTableViewCell: UITableViewCell ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var commentNumLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    weak var delegate:UICommentDelegate!;
    
    var spread = false;
    var infoModel:NSActInfoObject! = NSActInfoObject();
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 4;
        commentBtn.makeBackGroundColor_Purple();
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UICommentTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "commentCellIdentifier")
    }
    
    @IBAction func spreadAllContent(sender: UIButton) {
        self.spread = !self.spread;
        self.listTableView.reloadData()
        delegate.didSpreadComments!(self.spread);
    }
    func setContentData(infoModel:NSActInfoObject){
        self.infoModel = infoModel;
        let text = "评论（\(infoModel.commends.count)）" as NSString
        commentNumLabel.attributedText = text.switchContentWithFonts([UIFont.systemFontOfSize(13)], withRanges: [NSStringFromRange(NSMakeRange(3, text.length-4))], withColors: [SPurpleBtnColor])
        self.listTableView.reloadData();
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.spread {
            return self.infoModel.commends.count;
        } else {
            return self.infoModel.commends.count>2 ? 2: self.infoModel.commends.count;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCellIdentifier", forIndexPath: indexPath) as! UICommentTableViewCell;
        let comment = self.infoModel.commends[indexPath.row] as! NSCommentObject;
        cell.setContentData(comment)
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let  font:UIFont = UIFont.systemFontOfSize(13);
        let comment = self.infoModel.commends[indexPath.row] as! NSCommentObject;
        let size:CGSize = (comment.info as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-80), fromFont:font, lineSpace: 2.5);
        return size.height+45;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        if delegate != nil {
            let comment = self.infoModel.commends[indexPath.row] as! NSCommentObject;
            delegate.didSelectedAtIndexPath!(comment)
        }
    }
    
    @IBAction func commentFunction(sender: UIButton) {
        if delegate != nil {
            delegate.didSelectedComment!();
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
