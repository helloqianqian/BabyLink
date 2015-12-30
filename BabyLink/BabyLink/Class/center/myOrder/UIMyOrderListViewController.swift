//
//  UIMyOrderListViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIMyOrderListViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var itemBtn2: UIButton!
    @IBOutlet weak var itemBtn3: UIButton!
    @IBOutlet weak var itemBtn4: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    var tabType = 1;
    var page = 1;
    var otherPage = 1;
    var anotherPage = 1;
    
    var dataArray:NSMutableArray = NSMutableArray();
    var otherArray:NSMutableArray = NSMutableArray();
    var anotherArray:NSMutableArray = NSMutableArray();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的订单"
        itemBtn2.makeBackGroundColor_PurpleSelected();
        itemBtn3.makeBackGroundColor_PurpleSelected();
        itemBtn4.makeBackGroundColor_PurpleSelected();
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIMyOrderTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIMyOrderTableViewCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIMyOrderTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIMyOrderCellIdentifier")
        self.listTableView.registerNib(UINib(nibName: "UIFinalPayTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFinalPayCellIdentifier")
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.refreshListData();
    }
    
    func refreshListData(){
        if tabType == 1 {
            self.page = 1;
            self.reloadTableDataType1()
        } else if tabType == 2{
            self.otherPage = 1;
            self.reloadTableDataType2()
        } else {
            self.anotherPage = 1;
            self.reloadTableDataType3()
        }
    }
    
    func getMoreListData(){
        if tabType == 1 {
            self.page++;
            self.reloadTableDataType1()
        } else if tabType == 2{
            self.otherPage++;
            self.reloadTableDataType2()
        } else {
            self.anotherPage++;
            self.reloadTableDataType3()
        }
    }
    
    func loadContentData(force:Bool) {
        self.listTableView.reloadData();
        if tabType == 1 {
            if dataArray.count == 0 || force {
                self.listTableView.header.beginRefreshing()
//            } else {
//                self.listTableView.reloadData();
            }
        } else if tabType == 2 {
            if otherArray.count == 0 || force {
                self.listTableView.header.beginRefreshing()
//            } else {
//                self.listTableView.reloadData();
            }
        } else {
            if anotherArray.count == 0 || force {
                self.listTableView.header.beginRefreshing()
//            } else {
//                self.listTableView.reloadData();
            }
        }
    }
    
    func reloadTableDataType3(){
        var dicParam:NSDictionary!;
        
        dicParam = NSDictionary(objects: ["3,6","\(self.anotherPage)",NSUserInfo.shareInstance().member_id] , forKeys: ["order_status","page","member_id"]);
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let datas = dic["datas"] as! NSArray
                    if self.anotherPage == 1 {
                        self.anotherArray.removeAllObjects();
                    }
                    for data in datas {
                        let order = NSOrder();
                        order.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                        
                        let goods = data["goods"];
                        order.good.setValuesForKeysWithDictionary(goods as! [String : AnyObject]);
                        
                        self.anotherArray.addObject(order);
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
    
    func reloadTableDataType1(){
        var dicParam:NSDictionary!;
        dicParam = NSDictionary(objects: ["1","\(self.page)",NSUserInfo.shareInstance().member_id] , forKeys: ["order_status","page","member_id"]);
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let datas = dic["datas"] as! NSArray
                if self.page == 1 {
                    self.dataArray.removeAllObjects();
                }
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
    
    
    
    func reloadTableDataType2(){
        var dicParam:NSDictionary!;
        dicParam = NSDictionary(objects: ["2,4,7,8","\(self.otherPage)",NSUserInfo.shareInstance().member_id] , forKeys: ["order_status","page","member_id"]);
        
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let datas = dic["datas"] as! NSArray
                if self.otherPage == 1 {
                    self.otherArray.removeAllObjects();
                }
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
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tabType == 1 {
            return self.dataArray.count;
        } else if tabType == 2 {
            return self.otherArray.count;
        } else {
            return self.anotherArray.count;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch tabType {
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIMyOrderTableViewCellIdentifier", forIndexPath: indexPath) as! UIMyOrderTableViewCell
            let order = self.dataArray[indexPath.row] as! NSOrder;
            cell.setContentData(order)
            cell.cancelBtn.tag = indexPath.row;
            cell.cancelBtn.addTarget(self, action: "tuiKuan:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.payBtn.tag = indexPath.row;
            cell.payBtn.addTarget(self, action: "payLeftMoney:", forControlEvents: UIControlEvents.TouchUpInside)
            return cell;
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIMyOrderCellIdentifier", forIndexPath: indexPath) as! UIMyOrderTableViewCell
            let order = self.otherArray[indexPath.row] as! NSOrder;
            cell.setPayedContentData(order)
            cell.payBtn.tag = indexPath.row;
            cell.payBtn.addTarget(self, action: "tuiKuan:", forControlEvents: UIControlEvents.TouchUpInside)
            return cell;
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIFinalPayCellIdentifier", forIndexPath: indexPath) as! UIFinalPayTableViewCell;
            let order = self.anotherArray[indexPath.row] as! NSOrder;
            cell.setListContentData(order);
            return cell;
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("UIMyOrderTableViewCellIdentifier", forIndexPath: indexPath)
            return cell;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tabType == 2{
            return 170;
        } else {
            return 150;
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderVC = UIOrderInfoViewController(nibName:"UIOrderInfoViewController" ,bundle: NSBundle.mainBundle())
        if tabType == 1 {
            let order = self.dataArray[indexPath.row] as! NSOrder;
            orderVC.order = order;
        } else if tabType == 2 {
            let order = self.otherArray[indexPath.row] as! NSOrder;
            orderVC.order = order;
        } else {
            let order = self.anotherArray[indexPath.row] as! NSOrder;
            orderVC.order = order;
        }
        self.navigationController?.pushViewController(orderVC, animated: true);
    }
    
    func payLeftMoney(sender:UIButton) {
        let order = self.dataArray[sender.tag] as! NSOrder;
        if order.good.end_status == 1 {
            let payVC = UIPaymentViewController(nibName:"UIPaymentViewController", bundle: NSBundle.mainBundle());
            payVC.goodsPrice = order.good.goods_weikuan;
            payVC.goods_id = order.goods_id;
            payVC.payType = 1;
            payVC.order_id = order.order_id;
            self.navigationController?.pushViewController(payVC, animated: true);
        }
    }
    func tuiKuan(sender:UIButton) {
        
        if tabType == 1 {
            let refundType = "1";
            let order = self.dataArray[sender.tag] as! NSOrder;
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear)
            let dicParam = NSDictionary(objects: [refundType,order.order_id,NSUserInfo.shareInstance().member_id] , forKeys: ["type","order_id","member_id"]);
            NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderRefundUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
                let dic = result as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    SVProgressHUD.showSuccessWithStatus("退款申请成功");
                    self.loadContentData(true);
                } else {
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                }) { (error:AnyObject!) -> Void in
            }
        }
        
        
        if tabType == 2 {
            let refundType = "2";
            let order = self.otherArray[sender.tag] as! NSOrder;
            
            let weikuan = order.good.goods_weikuan as NSString;
            if weikuan.floatValue == 0 {
                SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear)
                let dicParam = NSDictionary(objects: [order.order_id,NSUserInfo.shareInstance().member_id] , forKeys: ["order_id","member_id"]);
                NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderCancelUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
                    let dic = result as! NSDictionary;
                    let code = dic["code"] as! NSInteger;
                    if code == 0 {
                        SVProgressHUD.showSuccessWithStatus("订单取消成功");
                        self.loadContentData(true);
                    } else {
                        let datas = dic["datas"] as! String;
                        SVProgressHUD.showErrorWithStatus(datas);
                    }
                    }) { (error:AnyObject!) -> Void in
                }
                return;
            }
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear)
            let dicParam = NSDictionary(objects: [refundType,order.order_id,NSUserInfo.shareInstance().member_id] , forKeys: ["type","order_id","member_id"]);
            NSHttpHelp.httpHelpWithUrl(NSHttpModel.getOrderRefundUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
                let dic = result as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    SVProgressHUD.showSuccessWithStatus("退款申请成功");
                    self.loadContentData(true);
                } else {
                    let datas = dic["datas"] as! String;
                    SVProgressHUD.showErrorWithStatus(datas);
                }
                }) { (error:AnyObject!) -> Void in
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func itemTabFunction2(sender: UIButton) {
        sender.selected = true;
        itemBtn3.selected = false;
        itemBtn4.selected = false;
        
        tabType = 1;
        self.loadContentData(false)
    }
    @IBAction func itemTabFunction3(sender: UIButton) {
        sender.selected = true;
        itemBtn2.selected = false;
        itemBtn4.selected = false;
        
        tabType = 3;
        self.loadContentData(false)
    }
    @IBAction func itemTabFunction4(sender: UIButton) {
        sender.selected = true;
        itemBtn2.selected = false;
        itemBtn3.selected = false;
        
        tabType = 2;
        self.loadContentData(false)
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
