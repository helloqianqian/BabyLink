//
//  UIConvertViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIConvertViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var unCostBtn: UIButton!
    @IBOutlet weak var costBtn: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    var type = 0;
    
    var page = 1;
    var otherPage = 1;
    
    var dataArray:NSMutableArray = NSMutableArray();
    var otherArray:NSMutableArray = NSMutableArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "兑换码"
        
        unCostBtn.makeBackGroundColor_PurpleSelected();
        costBtn.makeBackGroundColor_PurpleSelected();
        
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UIConverCodeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIConverCodeTableViewCellIdentifier")
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
        self.listTableView.header.beginRefreshing();
    }

    func refreshListData(){
        if type == 0 {
            self.page = 1;
            self.reloadTableData()
        } else {
            self.otherPage = 1;
            self.reloadTableDataType()
        }
    }
    func getMoreListData(){
        if type == 0 {
            self.page++;
            self.reloadTableData()
        } else {
            self.otherPage++;
            self.reloadTableDataType()
        }
    }
    func reloadTableData(){
        var dicParam:NSDictionary!;
            dicParam = NSDictionary(objects: ["2,4","\(self.page)",NSUserInfo.shareInstance().member_id] , forKeys: ["order_status","page","member_id"]);
        
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                    if self.page == 1 {
                        self.dataArray.removeAllObjects();
                    }
               
                let datas = dic["datas"] as! NSArray
                    for data in datas {
                        let order = NSOrder();
                        order.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                        
                        let goods = data["goods"];
                        order.good.setValuesForKeysWithDictionary(goods as! [String : AnyObject]);
                        
                        self.dataArray.addObject(order);
                    }
                
                self.listTableView.reloadData()
            } else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            self.listTableView.header.endRefreshing();
            self.listTableView.footer.endRefreshing();
            }) { (error:AnyObject!) -> Void in
                self.listTableView.header.endRefreshing();
                self.listTableView.footer.endRefreshing();
        }
    }
    func reloadTableDataType(){
        var dicParam:NSDictionary!;
        
        dicParam = NSDictionary(objects: ["7,8","\(self.otherPage)",NSUserInfo.shareInstance().member_id] , forKeys: ["order_status","page","member_id"]);
        
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                
                if self.otherPage == 1 {
                    self.otherArray.removeAllObjects();
                }
                let datas = dic["datas"] as! NSArray
                for data in datas {
                    let order = NSOrder();
                    order.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                    
                    let goods = data["goods"];
                    order.good.setValuesForKeysWithDictionary(goods as! [String : AnyObject]);
                    
                    self.otherArray.addObject(order);
                }
                
                self.listTableView.reloadData()
            } else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            self.listTableView.header.endRefreshing();
            self.listTableView.footer.endRefreshing();
            }) { (error:AnyObject!) -> Void in
                self.listTableView.header.endRefreshing();
                self.listTableView.footer.endRefreshing();
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.type == 0 {
            return self.dataArray.count;
        } else {
            return self.otherArray.count;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIConverCodeTableViewCellIdentifier", forIndexPath: indexPath) as! UIConverCodeTableViewCell;
        if self.type == 0 {
            let order = self.dataArray[indexPath.row] as! NSOrder;
            cell.setcontentData(order);
        } else {
            let order = self.otherArray[indexPath.row] as! NSOrder;
            cell.setcontentData(order);
        }
        return cell;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 97;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoVC = UIConverInfoViewController(nibName:"UIConverInfoViewController",bundle: NSBundle.mainBundle());
        if self.type == 0 {
            let order = self.dataArray[indexPath.row] as! NSOrder;
            infoVC.order = order;
        } else {
            let order = self.otherArray[indexPath.row] as! NSOrder;
            infoVC.order = order;
            infoVC.type = 1;
        }
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    
    
    @IBAction func getUncostListFunction(sender: UIButton) {
        sender.selected = true;
        costBtn.selected = false;
        self.type = 0;
        self.loadContentData(false)
        
    }
    @IBAction func getCostListFunction(sender: UIButton) {
        sender.selected = true;
        unCostBtn.selected = false;
        self.type = 1;
        self.loadContentData(false)
    }
    
    func loadContentData(force:Bool) {
        self.listTableView.reloadData();
        if self.type == 0 {
            if dataArray.count == 0 || force {
                self.listTableView.header.beginRefreshing()
//            } else {
//                self.listTableView.reloadData();
            }
        } else {
            if otherArray.count == 0 || force {
                self.listTableView.header.beginRefreshing()
//            } else {
//                self.listTableView.reloadData();
            }
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
