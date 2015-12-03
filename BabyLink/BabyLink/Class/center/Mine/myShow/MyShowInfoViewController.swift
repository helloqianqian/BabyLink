//
//  MyShowInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyShowInfoViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{
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
            self.listTableView.reloadData();
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIMyShowTableViewCellIdentifier", forIndexPath: indexPath) as! UIShowTableViewCell;
        cell.zanBtn.tag = indexPath.row;
        cell.zanBtn.addTarget(self, action: "zanXiu", forControlEvents: UIControlEvents.TouchUpInside);
        cell.setContentDataFormLink(xiu)
        cell.douBtn.addTarget(self, action: "douYidou", forControlEvents: UIControlEvents.TouchUpInside);
        cell.shareBtn.addTarget(self, action: "shareDou", forControlEvents: UIControlEvents.TouchUpInside)
        return cell;
    }
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
        NSLog("willDisplayCell：\(indexPath.row)   total:\(self.xiu.commends.count)")
        for var i=0 ;i<self.xiu.commends.count; i++ {
            //13........13
            let aComment = self.xiu.commends[i] as! NSXiuComment;
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
        NSLog("didEndDisplayingCell：\(indexPath.row)")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        let cell = self.listTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        if cell != nil {
            for var i=0 ;i<self.xiu.commends.count; i++ {
                var subview = cell?.viewWithTag(1000+i);
                if subview != nil {
                    (subview as! UIShowItemView).stopAnimation();
                    subview?.removeFromSuperview();
                    subview = nil;
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
