//
//  UILinkView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UILinkViewDelegate:NSObjectProtocol {
    func douYiDouFunction(index:Int);
    func jiaGuanzhuFunction(index:Int);
    func qiuKuoSanFunction(index:Int);
}



class UILinkView: UIView ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    weak var delegate: UILinkViewDelegate!;
    
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
    func getListData(){//[NSUserInfo.shareInstance().member_id
        let dicParam:NSDictionary = NSDictionary(objects: ["9","\(self.page)"] , forKeys: [MEMBER_ID,"page"]);
        NSHttpHelp.httpHelpWithUrlTpye(xiuLinkType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
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
                    let size = info.sizeWithConstrainedToWidth(Float(MainScreenWidth-56), fromFont:font, lineSpace: 3);
                    talk.infoHeight = size.height+5;
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
                    self.dataArray.addObject(talk);
                }
                self.listTableView.reloadData()
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
        let xiu = self.dataArray[indexPath.row] as! NSXiu;
        cell.zanBtn.tag = indexPath.row;
        cell.zanBtn.addTarget(self, action: "zanXiu:", forControlEvents: UIControlEvents.TouchUpInside);
        
        cell.shareBtn.tag = indexPath.row;
        cell.shareBtn.addTarget(self, action: "shareDou:", forControlEvents: UIControlEvents.TouchUpInside);
        cell.douBtn.tag = indexPath.row;
        cell.douBtn.addTarget(self, action: "douYidou:", forControlEvents: UIControlEvents.TouchUpInside);
        
        cell.setContentDataFormLink(xiu)
        return cell;
    }
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let xiu = self.dataArray[indexPath.row] as! NSXiu;

        var height:CGFloat = 120;
        let count = xiu.zans.count;
        var per = 0
        if iphone6Plus {
            height+=388;
            per = 13;
        } else if iphone6 {
            height+=349
            per = 12;
        } else {
            height+=294;
            per=10;
        }
        var hang = count/per;
        let left = count%per;
        if left>0 || hang == 0{
            hang+=1;
        }
        return height + CGFloat(hang*26) + xiu.infoHeight;
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        NSLog("willDisplayCell:\(indexPath.row)")
        let xiu = self.dataArray[indexPath.row] as! NSXiu;
        for var i=0 ;i<xiu.commends.count; i++ {
            //13........13
            let aComment = xiu.commends[i] as! NSXiuComment;
            let tipView = NSBundle.mainBundle().loadNibNamed("UIShowItemView", owner: nil, options: nil).first as! UIShowItemView;
            tipView.tag = 1000+i;
            cell.addSubview(tipView);
            tipView.contentLabel.text = aComment.info;
            let size = tipView.contentLabel.sizeThatFits(CGSizeMake(100, 100));
            tipView.frame = CGRectMake(13 + (MainScreenWidth-13)*aComment.position_x, 55+(MainScreenWidth-13)*aComment.position_y, size.width+48, size.height+16);
            tipView.headIcon.sd_setImageWithURL(NSURL(string: aComment.member_avar), placeholderImage: UIImage(named: "morentoux"))
            tipView.start();
        }
    }
    
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("didEndDisplayingCell:\(indexPath.row)")
        let xiu = self.dataArray[indexPath.row] as! NSXiu;
        for var i=0 ;i<xiu.commends.count; i++ {
            var subview = cell.viewWithTag(1000+i);
            if subview != nil {
                (subview as! UIShowItemView).stopAnimation();
                subview?.removeFromSuperview();
                subview = nil;
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
                let zan:NSXiuZan = NSXiuZan();
                zan.xiu_id = xiu.xiu_id;
                zan.member_id = NSUserInfo.shareInstance().member_id;
                zan.member_name = NSUserInfo.shareInstance().member_name;
                zan.member_avar = NSUserInfo.shareInstance().member_avar;
                xiu.zans.insertObject(zan, atIndex: 0);
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
    func douYidou(sender:UIButton){
        let douVC = UIDouViewController(nibName:"UIDouViewController" ,bundle: NSBundle.mainBundle())
        let showModel = self.dataArray[sender.tag] as! NSXiu;
        douVC.showModel = showModel;
        mainTabBar.showView.presentViewController(douVC, animated: true) { () -> Void in
            
        }
    }
    func shareDou(sender:UIButton){
        
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
