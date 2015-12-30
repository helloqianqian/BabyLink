//
//  UIActivityView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UIActivityViewDelegate:NSObjectProtocol {
    func joinInTheActivity(actObject:NSActListObject);
    func checkTheInfoOfActivity(actObject:NSActListObject);
    func didClickAdImage(adModle:ADModel);
}


class UIActivityView: UIView ,UITableViewDataSource, UITableViewDelegate,didClickImgDelegate{

    @IBOutlet weak var listTableView: UITableView!
    var headView:FindListHeadView!;
    
    weak var delegate:UIActivityViewDelegate!;
    
    var dataArray:NSMutableArray! = NSMutableArray();
    var adArray:NSMutableArray! = NSMutableArray();
    
    var page = 1;
    override func awakeFromNib() {
        headView = NSBundle.mainBundle().loadNibNamed("FindListHeadView", owner: nil, options: nil).first as! FindListHeadView;
        headView.scrollWidth = MainScreenWidth;
        headView.delegate = self;
        if iphone6Plus {
            headView.scrollHeight = 184;
        } else if iphone6 {
            headView.scrollHeight = 170;
        } else {
            headView.scrollHeight = 140;
        }
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIActivityTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityTableViewCellIndentifier")
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
    }
    func didClickImgAction(adModel: ADModel) {
        delegate.didClickAdImage(adModel);
    }
    
    func refreshListData(){
        mainTabBar.getNums();
        self.page = 1;
        self.reloadTableData()
    }
    func getMoreListData(){
        self.page++ ;
        self.reloadTableData()
    }
    func loadContentData(force:Bool, withAnimate animate:Bool) {
        if dataArray.count == 0 || force {
            if animate {
                self.listTableView.header.beginRefreshing()
            } else {
                self.refreshListData()
            }
        }
    }
    func reloadTableData(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"\(self.page)"] , forKeys: [MEMBER_ID,"page"]);
        NSHttpHelp.httpHelpWithUrlTpye(actListType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                if self.page == 1 {
                    self.dataArray.removeAllObjects();
                }
                let datas = dic["datas"] as! NSDictionary;
                let advs = datas["advs"] as! NSArray;
                let activity_list = datas["activity_list"] as! NSArray;
                if self.adArray.count == 0 {
                    for ad in advs {
                        let ads = ADModel()
                        ads.setValuesForKeysWithDictionary(ad as! [String : AnyObject]);
                        self.adArray.addObject(ads);
                    }
                    if self.adArray.count>0 {
                        self.headView.setupSubviews(self.adArray,tag: true);
                    }
                }
                for activity in activity_list {
                    let act = NSActListObject();
                    act.setValuesForKeysWithDictionary(activity as! [String : AnyObject]);
                    let log_list = activity["log_list"] as! NSArray;
                    for log in log_list {
                        let logs = NSLogListObject()
                        logs.setValuesForKeysWithDictionary(log as! [String : AnyObject]);
                        act.logs_list.addObject(logs);
                    }
                    self.dataArray.addObject(act);
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
        let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityTableViewCell;
        let model = self.dataArray.objectAtIndex(indexPath.row) as! NSActListObject;
        cell.resetCellContent(model, withIndex: indexPath, withHoldView: self);
        return cell;
    }
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if iphone6Plus {
            return 360;
        } else if iphone6 {
            return 338;
        } else {
            return 310;
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if iphone6Plus {
            return 184;
        }
        if iphone6 {
            return 170;
        }
        return 140;
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5;
    }
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let listModel = dataArray.objectAtIndex(indexPath.row) as! NSActListObject;
//        delegate.checkTheInfoOfActivity(listModel);
//    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headView;
    }
    
    
    //MARK - cell Function
    func joinTheActivity(sender:UIButton){
//        let listModel = dataArray.objectAtIndex(sender.tag) as! NSActListObject;
//        delegate.joinInTheActivity(listModel);
        let listModel = dataArray.objectAtIndex(sender.tag) as! NSActListObject;
        delegate.checkTheInfoOfActivity(listModel);
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    
    

}
