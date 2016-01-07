//
//  UIFinalPayViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFinalPayViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    var page = 1;
    var dataArray:NSMutableArray! = NSMutableArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "支付尾款"
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIFinalPayTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFinalPayTableViewCellIdentifier");
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.refreshListData()
    }
    
    func refreshListData(){
        self.page = 1;
        self.reloadTableData()
    }
    func getMoreListData(){
        self.page++;
        self.reloadTableData()
    }
    func reloadTableData(){
        let dicParam:NSDictionary = NSDictionary(objects: ["1","\(self.page)",NSUserInfo.shareInstance().member_id] , forKeys: ["order_status","page","member_id"]);
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
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIFinalPayTableViewCellIdentifier", forIndexPath: indexPath) as! UIFinalPayTableViewCell;
        let order = self.dataArray[indexPath.row] as! NSOrder;
        cell.setContentData(order)
        cell.payBtn.tag = indexPath.row;
        cell.payBtn.addTarget(self, action: "payTheLeftMoney:", forControlEvents: UIControlEvents.TouchUpInside);
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderVC = UIOrderInfoViewController(nibName:"UIOrderInfoViewController" ,bundle: NSBundle.mainBundle())
        let order = self.dataArray[indexPath.row] as! NSOrder;
        orderVC.order = order;
        orderVC.type = 1 ;
        self.navigationController?.pushViewController(orderVC, animated: true);
    }
    
    func payTheLeftMoney(sender:UIButton) {
        let order = self.dataArray[sender.tag] as! NSOrder;
        let paymentVC = UIPaymentViewController(nibName:"UIPaymentViewController" ,bundle: NSBundle.mainBundle());
        paymentVC.payType = 1;
        paymentVC.goods_id = order.goods_id;
        paymentVC.goodsPrice = order.good.goods_weikuan;
        paymentVC.order_id = order.order_id;
        self.navigationController?.pushViewController(paymentVC, animated: true);
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
