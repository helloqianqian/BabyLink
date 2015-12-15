//
//  MyExchangeViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyExchangeViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var myListBtn: UIButton!
    @IBOutlet weak var otherListBtn: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    var role = "1";
    var dataArray:NSMutableArray! = NSMutableArray();
    var otherArray:NSMutableArray! = NSMutableArray();
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的置换"
        
        myListBtn.makeBackGroundColor_PurpleSelected();
        otherListBtn.makeBackGroundColor_PurpleSelected();
        
        listTableView.dataSource = self;
        listTableView.delegate = self;
        listTableView.registerNib(UINib(nibName: "UIMyActTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIMyActTableViewCellIdentifier")
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        
        self.loadContentData(false);
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        if reloadMyListOfExchange {
            reloadMyListOfExchange = false;
            self.listTableView.header.beginRefreshing()
        }
    }
    
    
    
    func refreshListData(){
        self.reloadTableData()
    }
    
    func loadContentData(force:Bool) {
        if self.role == "1" {
            if dataArray.count == 0 || force {
                self.listTableView.header.beginRefreshing()
            } else {
                self.listTableView.reloadData();
            }
        } else {
            if otherArray.count == 0 || force {
                self.listTableView.header.beginRefreshing()
            } else {
                self.listTableView.reloadData();
            }
        }
    }
    func reloadTableData() {
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.role] , forKeys: [MEMBER_ID,"role"]);
        NSHttpHelp.httpHelpWithUrlTpye(exhangeMyListType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                if self.role == "1" {
                    self.dataArray.removeAllObjects();
                    let datas = dic["datas"] as! NSArray;
                    for data in datas {
                        let change = NSExchange();
                        change.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                        self.dataArray.addObject(change);
                    }
                } else {
                    self.otherArray.removeAllObjects();
                    let datas = dic["datas"] as! NSArray;
                    for data in datas {
                        let change = NSExchange();
                        change.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                        self.otherArray.addObject(change);
                    }
                }
                self.listTableView.reloadData()
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            self.listTableView.header.endRefreshing();
            }) { (error:AnyObject!) -> Void in
                self.listTableView.header.endRefreshing();
        };
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.role == "1" {
            return self.dataArray.count;
        } else {
            return self.otherArray.count;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIMyActTableViewCellIdentifier", forIndexPath: indexPath) as! UIMyActTableViewCell;
        var exchange:NSExchange!
        if self.role == "1" {
            exchange = self.dataArray[indexPath.row] as! NSExchange;
        } else {
            exchange = self.otherArray[indexPath.row] as! NSExchange;
        }
        cell.setExchangeData(exchange);
        cell.cancelBtn.tag = indexPath.row;
        cell.cancelBtn.addTarget(self, action: "cancelExchangeTrade:", forControlEvents: UIControlEvents.TouchUpInside);
        cell.checkBtn.tag = indexPath.row;
        cell.checkBtn.addTarget(self, action: "finishExchangeTrade:", forControlEvents: UIControlEvents.TouchUpInside);
        return cell
    }
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoVC:UIExchangeInfoViewController = UIExchangeInfoViewController(nibName:"UIExchangeInfoViewController", bundle:NSBundle.mainBundle());
        infoVC.myList = 1;
        var exchange:NSExchange!
        if self.role == "1" {
            exchange = self.dataArray[indexPath.row] as! NSExchange;
        } else {
            exchange = self.otherArray[indexPath.row] as! NSExchange;
        }
        infoVC.exchangeList = exchange;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }    
    
    
    @IBAction func mylist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            otherListBtn.selected = false;
            self.role = "1";
            self.loadContentData(false);
        }
    }

    @IBAction func otherlist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            myListBtn.selected = false;
            self.role = "2";
            self.loadContentData(false);
        }
    }
    
    
    
    func cancelExchangeTrade(sender:UIButton){
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        var exchange:NSExchange!
        if self.role == "1" {
            exchange = self.dataArray[sender.tag] as! NSExchange;
        } else {
            exchange = self.otherArray[sender.tag] as! NSExchange;
        }
        let paramDic = ["member_id":NSUserInfo.shareInstance().member_id,"me_exchange_id":exchange.exchange_id,"to_exchange_id":exchange.link_exchange_id]
        NSHttpHelp.httpHelpWithUrlTpye(cancelExchangeType, withParam: paramDic, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.showImage(nil, status: "取消成功")
                self.listTableView.header.beginRefreshing();
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        }
    }
    
    func finishExchangeTrade(sender:UIButton){
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        var exchange:NSExchange!
        if self.role == "1" {
            exchange = self.dataArray[sender.tag] as! NSExchange;
        } else {
            exchange = self.otherArray[sender.tag] as! NSExchange;
        }
        let paramDic = ["member_id":NSUserInfo.shareInstance().member_id,"me_exchange_id":exchange.exchange_id,"to_exchange_id":exchange.link_exchange_id]
        NSHttpHelp.httpHelpWithUrlTpye(finishExchangeType, withParam: paramDic, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.showImage(nil, status: "置换成功")
                self.listTableView.header.beginRefreshing();
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        }
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
