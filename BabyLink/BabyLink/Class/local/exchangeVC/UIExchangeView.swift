//
//  UIExchangeView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UIExchangeViewDelegate:NSObjectProtocol {
    func checkTheInfoOfExchange(exchange:NSExchange);
}


class UIExchangeView: UIView ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    weak var delegate:UIExchangeViewDelegate!;
    var page = 1;
    var dataArray:NSMutableArray! = NSMutableArray();
    override func awakeFromNib() {
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIExchangeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIExchangeTableViewCellIdentifier")
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
    }
    
    func refreshListData(){
        mainTabBar.getNums();
        self.page = 1;
        self.getListData();
    }
    func getMoreListData(){
        self.page++;
        self.getListData();
    }
    func loadContentData(force:Bool, withAnimate animate:Bool) {
        if dataArray.count == 0 || force {
            if animate {
                self.listTableView.header.beginRefreshing()
            } else {
                self.refreshListData();
            }
        }
    }
    func getListData(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"\(self.page)"] , forKeys: [MEMBER_ID,"page"]);
        NSHttpHelp.httpHelpWithUrlTpye(exchangeListType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                if self.page == 1 {
                    self.dataArray.removeAllObjects();
                }
                let datas = dic["datas"] as! NSArray;
                for data in datas {
                    let exchange = NSExchange();
                    exchange.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                    self.dataArray.addObject(exchange);
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
        let cell = tableView.dequeueReusableCellWithIdentifier("UIExchangeTableViewCellIdentifier", forIndexPath: indexPath) as! UIExchangeTableViewCell;
        let model = self.dataArray[indexPath.row] as! NSExchange;
        cell.setContentData(model);
        return cell;
    }
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if iphone6Plus {
            return 270;
        } else if iphone6 {
            return 254;
        } else {
            return 230;
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let exchange = self.dataArray[indexPath.row] as! NSExchange;
        delegate.checkTheInfoOfExchange(exchange);
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
