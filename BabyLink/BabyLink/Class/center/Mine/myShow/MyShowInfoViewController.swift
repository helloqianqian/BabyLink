//
//  MyShowInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyShowInfoViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate{
    @IBOutlet weak var listTableView: UITableView!
    var xiu:NSXiu! = NSXiu()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的秀逗"
        listTableView.dataSource = self;
        listTableView.delegate = self;
        listTableView.registerNib(UINib(nibName: "UIShowTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIMyShowTableViewCellIdentifier");
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        if reloadDataForAddNewDou {
            reloadDataForAddNewDou = false;
        }
        self.listTableView.reloadData();
        self.updateNum()
    }
    
    
    func updateNum(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.xiu.xiu_id,"1"] , forKeys: [MEMBER_ID,"item_id","type"]);
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getUpdateCan(), withParam: dicParam, withResult: { (result) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                mainTabBar.getNums()
                self.xiu.xiu_num = "0";
            }
            }) { (error) -> Void in
                
        }
        
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIMyShowTableViewCellIdentifier", forIndexPath: indexPath) as! UIShowTableViewCell;
        for itemView in cell.subviews {
            if itemView.isKindOfClass(UIShowItemView){
                (itemView as! UIShowItemView).stopAnimation();
                itemView.removeFromSuperview();
            }
        }

        cell.zanBtn.tag = indexPath.row;
        cell.zanBtn.addTarget(self, action: "zanXiu", forControlEvents: UIControlEvents.TouchUpInside);
        cell.setContentDataFormLink(xiu)
        cell.douBtn.addTarget(self, action: "douYidou", forControlEvents: UIControlEvents.TouchUpInside);
        cell.shareBtn.addTarget(self, action: "shareDou", forControlEvents: UIControlEvents.TouchUpInside)
        return cell;
    }
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return xiu.cellHeight + xiu.zanHeight + xiu.infoHeight;
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
//        NSLog("willDisplayCell：\(indexPath.row)   total:\(self.xiu.commends.count)")
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
//        NSLog("didEndDisplayingCell：\(indexPath.row)")
        for itemView in cell.subviews {
            if itemView.isKindOfClass(UIShowItemView){
                (itemView as! UIShowItemView).stopAnimation();
                itemView.removeFromSuperview();
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        let cell = self.listTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        if cell != nil {
            for itemView in cell!.subviews {
                if itemView.isKindOfClass(UIShowItemView){
                    (itemView as! UIShowItemView).stopAnimation();
                    itemView.removeFromSuperview();
                }
            }
        }
    }
    
    func zanXiu(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,xiu.xiu_id] , forKeys: [MEMBER_ID,"xiu_id"]);
        NSHttpHelp.httpHelpWithUrlTpye(xiuZanType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let zan:NSXiuZan = NSXiuZan();
                zan.xiu_id = self.xiu.xiu_id;
                zan.member_id = NSUserInfo.shareInstance().member_id;
                zan.member_name = NSUserInfo.shareInstance().member_name;
                zan.member_avar = NSUserInfo.shareInstance().member_avar;
                self.xiu.zans.insertObject(zan, atIndex: 0);
                self.xiu.isZan = true;
                self.listTableView.reloadData();
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
    }
    
    func douYidou(){
        let douVC = UIDouViewController(nibName:"UIDouViewController" ,bundle: NSBundle.mainBundle())
        douVC.showModel = self.xiu;
        douVC.from = 1;
        self.presentViewController(douVC, animated: true) { () -> Void in
            
        }
    }
    func shareDou(){
        UMSocialData.defaultData().urlResource.setResourceType(UMSocialUrlResourceTypeImage, url: "http://baidu.com");
        UMSocialSnsService.presentSnsIconSheetView(mainTabBar.showView, appKey: "562d96b0e0f55ae8010013b6", shareText: "babylink分享活动 http://www.baidu.com", shareImage:UIImage(named: "AppIcon"), shareToSnsNames: [UMShareToQQ,UMShareToWechatSession,UMShareToSina,UMShareToWechatTimeline], delegate: self)
    }
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        if response.responseCode == UMSResponseCodeSuccess {
            SVProgressHUD.showSuccessWithStatus("分享成功");
        } else {
            SVProgressHUD.showErrorWithStatus("分享失败")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
