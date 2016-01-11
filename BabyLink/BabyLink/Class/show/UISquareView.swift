//
//  UISquareView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UISquareView: UIView ,UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate{

    @IBOutlet weak var listTableView: UITableView!
    var page = 1;
    var dataArray:NSMutableArray!=NSMutableArray();
    override func awakeFromNib() {
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UIShowTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIShowTableViewCellIdentifier");
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
    }
    
    func refreshListData(){
        self.page = 1;
        self.getListData();
    }
    func getMoreListData(){
        self.page++;
        self.getListData();
    }
    func loadContentData(force:Bool) {
        if dataArray.count == 0 || force {
            self.listTableView.header.beginRefreshing()
        }
    }
    func reloadTabelView(){
        self.listTableView.reloadData();
    }
    
    func getListData(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"\(self.page)"] , forKeys: [MEMBER_ID,"page"]);
        NSHttpHelp.httpHelpWithUrlTpye(xiuType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                if self.page == 1 {
                    self.dataArray.removeAllObjects();
                }
                let datas = dic["datas"] as! NSArray;
                for data in datas {
                    let talk = NSXiu();
                    talk.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                    let info = data["info"] as! NSString;
                    let font:UIFont = UIFont.systemFontOfSize(14);
                    let size = info.sizeWithConstrainedToWidth(Float(MainScreenWidth-36), fromFont:font, lineSpace: 3);
                    talk.infoHeight = size.height+15;
                    
                    let commends = data["commend_list"] as! NSArray;
                    for comment in commends {
                        let aCommend = NSXiuComment()
                        aCommend.setValuesForKeysWithDictionary(comment as! [String : AnyObject]);
                        talk.commends.addObject(aCommend);
                    }
                    let zans = data["zan_list"] as! NSArray;
                    for zan in zans {
                        let aZan = NSXiuZan()
                        aZan.setValuesForKeysWithDictionary(zan as! [String : AnyObject]);
                        talk.zans.addObject(aZan);
                    }
                    
                    let count = talk.zans.count;
                    var per = 0
                    if iphone6Plus {
                        per = 13;
                    } else if iphone6 {
                        per = 12;
                    } else {
                        per=10;
                    }
                    var hang = count/per;
                    let left = count%per;
                    if left>0 || hang == 0{
                        hang+=1;
                    }
                    talk.zanHeight = CGFloat(hang*26);
                    
                    self.dataArray.addObject(talk);
                }
                self.listTableView.reloadData()
                mainTabBar.getNums();
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            self.listTableView.header.endRefreshing();
            self.listTableView.footer.endRefreshing();
            }) { (error:AnyObject!) -> Void in
                self.listTableView.header.endRefreshing();
                self.listTableView.footer.endRefreshing();
        };
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIShowTableViewCellIdentifier", forIndexPath: indexPath) as! UIShowTableViewCell;
        
        for itemView in cell.subviews {
            if itemView.isKindOfClass(UIShowItemView){
                (itemView as! UIShowItemView).stopAnimation();
                itemView.removeFromSuperview();
            }
        }
        
        
        let xiu = self.dataArray[indexPath.row] as! NSXiu;
        cell.setContentDataFromSqu(xiu);
        cell.zanBtn.tag = indexPath.row;
        cell.zanBtn.addTarget(self, action: "zanXiu:", forControlEvents: UIControlEvents.TouchUpInside);
        cell.focusBtn.tag = indexPath.row;
        cell.focusBtn.addTarget(self, action: "addFocus:", forControlEvents: UIControlEvents.TouchUpInside);
        cell.shareBtn.tag = indexPath.row;
        cell.shareBtn.addTarget(self, action: "shareDou:", forControlEvents: UIControlEvents.TouchUpInside);
        cell.douBtn.tag = indexPath.row;
        cell.douBtn.addTarget(self, action: "douYidou:", forControlEvents: UIControlEvents.TouchUpInside);
        return cell;
    }
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let xiu = self.dataArray[indexPath.row] as! NSXiu;
        return xiu.cellHeight + xiu.zanHeight + xiu.infoHeight + 20;
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
//        NSLog("willDisplayCell:\(indexPath.row)")
        let xiu = self.dataArray[indexPath.row] as! NSXiu;
        for var i=0 ;i<xiu.commends.count; i++ {
            //13........13
            let aComment = xiu.commends[i] as! NSXiuComment;
            let tipView = NSBundle.mainBundle().loadNibNamed("UIShowItemView", owner: nil, options: nil).first as! UIShowItemView;
            cell.addSubview(tipView);
            tipView.contentLabel.text = aComment.info;
            let size = tipView.contentLabel.sizeThatFits(CGSizeMake(100, 100));
            
            let x = (MainScreenWidth-26)*aComment.position_x;
            let y = (MainScreenWidth-26)*aComment.position_y;
            
            var frame = CGRectMake(13+x, 58+y, size.width+48, size.height+16);
            if x + size.width + 48 > MainScreenWidth-26 {
                frame.origin.x = 13 + MainScreenWidth - size.width - 74;
            }
            if y + size.height + 16 > MainScreenWidth-26 {
                frame.origin.y = 58 + MainScreenWidth - size.height - 42
            }
            tipView.frame = frame;
            tipView.headIcon.sd_setImageWithURL(NSURL(string: aComment.member_avar), placeholderImage: UIImage(named: "morentoux"))
            tipView.start();
        }
    }
    
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        NSLog("didEndDisplayingCell:\(indexPath.row)")
        for itemView in cell.subviews {
            if itemView.isKindOfClass(UIShowItemView){
                (itemView as! UIShowItemView).stopAnimation();
                itemView.removeFromSuperview();
            }
        }
    }
    
    //MARK - cell Function
    func zanXiu(sender:UIButton){
        let xiu = self.dataArray[sender.tag] as! NSXiu;
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,xiu.xiu_id] , forKeys: [MEMBER_ID,"xiu_id"]);
        NSHttpHelp.httpHelpWithUrlTpye(xiuZanType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.showImage(nil, status: "已点赞")
                let zan:NSXiuZan = NSXiuZan();
                zan.xiu_id = xiu.xiu_id;
                zan.member_id = NSUserInfo.shareInstance().member_id;
                zan.member_name = NSUserInfo.shareInstance().member_name;
                zan.member_avar = NSUserInfo.shareInstance().member_avar;
                xiu.zans.addObject(zan);
                xiu.isZan = true;
                let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
                self.listTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None);
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
    }
    func addFocus(sender:UIButton){
        let xiu = self.dataArray[sender.tag] as! NSXiu;
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,xiu.member_id] , forKeys: [MEMBER_ID,"friend_id"]);
        NSHttpHelp.httpHelpWithUrlTpye(addFriendType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.showImage(nil, status: "已添加关注")
                showLinkLoad = true;
                self.loadContentData(true);
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
    }
    func douYidou(sender:UIButton){
        let douVC = UIDouViewController(nibName:"UIDouViewController" ,bundle: NSBundle.mainBundle())
        let showModel = self.dataArray[sender.tag] as! NSXiu;
        douVC.showModel = showModel;
        mainTabBar.showView.presentViewController(douVC, animated: true) { () -> Void in
            
        }
    }
    func shareDou(sender:UIButton){
        let showModel = self.dataArray[sender.tag] as! NSXiu;
        var fenxiang = "http://www.baidu.com";
        if showModel.fenxiang_url != "" {
            fenxiang = showModel.fenxiang_url;
        }
        let imageData = NSHelper.getImageData(showModel.image_url);
        
        UMSocialData.defaultData().extConfig.qqData.url = fenxiang;
        UMSocialData.defaultData().extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        UMSocialData.defaultData().extConfig.qqData.title = "秀逗分享"
        UMSocialData.defaultData().extConfig.qqData.shareImage = imageData;
        
        UMSocialData.defaultData().extConfig.wechatSessionData.url = fenxiang;
        UMSocialData.defaultData().extConfig.wechatSessionData.title = "秀逗分享"
        UMSocialData.defaultData().extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
        
        UMSocialData.defaultData().extConfig.wechatTimelineData.url = fenxiang;
        UMSocialData.defaultData().extConfig.wechatTimelineData.title = "秀逗分享:\(showModel.info)"
        UMSocialData.defaultData().extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
        
        UMSocialData.defaultData().urlResource.url = fenxiang;
        
        UMSocialData.defaultData().extConfig.sinaData.shareImage = imageData;
        UMSocialData.defaultData().extConfig.sinaData.shareText = "秀逗分享:\n\(showModel.info)\(fenxiang)";
        
        UMSocialSnsService.presentSnsIconSheetView(mainTabBar.showView, appKey: "562d96b0e0f55ae8010013b6", shareText: showModel.info, shareImage:imageData, shareToSnsNames: [UMShareToQQ,UMShareToWechatSession,UMShareToSina,UMShareToWechatTimeline], delegate: self)
    }
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        if response.responseCode == UMSResponseCodeSuccess {
            SVProgressHUD.showSuccessWithStatus("分享成功");
        } else {
            SVProgressHUD.showErrorWithStatus("分享失败")
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
