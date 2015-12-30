//
//  UIFindViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFindViewController: UIBaseViewController ,UITableViewDataSource,UITableViewDelegate,UIFindTypeViewDelegate{

    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var rangeBtn: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    @IBOutlet weak var numLabel: UILabel!
    var dataArray:NSMutableArray!=NSMutableArray();
    var page = 1;
    var orderType = 0;
    var store_class = "";
    var inviteNum = 0
    
    var classArray:NSMutableArray! = NSMutableArray();
    
    var tipView:UIFindTypeView! = NSBundle.mainBundle().loadNibNamed("UIFindTypeView", owner: nil, options: nil).first as! UIFindTypeView;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryBtn.makeBackGroundColor_White();
        rangeBtn.makeBackGroundColor_White();
        
        numLabel.layer.cornerRadius = 9;
        numLabel.layer.masksToBounds = true;
        
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UIFindTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFindTableViewCellIdentifier")
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
        
        self.getLocation()
        
        tipView.delegate = self;
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        if self.classArray.count == 0 {
            self.getClass()
        }
        mainTabBar.getNums();
    }
    
    
    func getClass(){
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getFindClass(), withParam: nil, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let datas = dic["datas"] as! NSArray;
                self.classArray.removeAllObjects();
                for data in datas {
                    let class_name = data["class_name"] as! String;
                    self.classArray.addObject(class_name);
                }
                let class_name = "被邀请" as NSString;
                self.classArray.addObject(class_name);
                
                self.tipView.addClassType(self.classArray);
            }
            }) { (error:AnyObject!) -> Void in
        }
    }
    
    func getLocation(){
        self.listTableView.header.beginRefreshing()
        if locationParam.longitude == 0 || locationParam.latitude == 0 {
            CCLocationManager.shareLocation().getLocationCoordinate { (lo:CLLocationCoordinate2D) -> Void in
                locationParam = lo;
                self.refreshListData();
            }
        }
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
    func getListData(){//[
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"\(self.page)",self.store_class,self.orderType.description,locationParam.latitude.description,locationParam.longitude.description] , forKeys: [MEMBER_ID,"page","store_class","order_type","latitude","longitude"]);
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getGoodsUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                if self.page == 1 {
                    self.dataArray.removeAllObjects();
                }
                let datas = dic["datas"] as! NSDictionary;
                let list = datas["list"] as! NSArray;
                self.inviteNum = datas["yaoqing_num"] as! NSInteger
                self.setYaoqing();
                
                for data in list {
                    let talk = NSFind();
                    talk.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
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
        }
    }

    func setYaoqing(){
        if self.inviteNum > 0 {
            numLabel.hidden = false;
            numLabel.text = "\(self.inviteNum)"
        } else {
            numLabel.hidden = true;
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIFindTableViewCellIdentifier", forIndexPath: indexPath) as! UIFindTableViewCell;
        let findModel = self.dataArray[indexPath.row] as! NSFind;
        cell.setContentData(findModel)
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if iphone6Plus {
            return 325;
        } else if iphone6 {
            return 300;
        } else {
            return 265;
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoVC:UIFindInfoViewController = UIFindInfoViewController(nibName:"UIFindInfoViewController", bundle: NSBundle.mainBundle())
        infoVC.hidesBottomBarWhenPushed = true;
        let findModel = self.dataArray[indexPath.row] as! NSFind;
        infoVC.listModel = findModel;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeRange(sender: UIButton) {
        sender.selected = !sender.selected;
        if sender.selected {
            self.categoryBtn.selected = false;
            tipView.num = self.inviteNum;
//            tipView.frame = CGRectMake(MainScreenWidth/2+2, 33, MainScreenWidth/2-7, 90);
            tipView.frame = CGRectMake(0, 33, MainScreenWidth, MainScreenHeight);
            tipView.reloadData(1)
            if tipView.superview != self.view {
                self.view.addSubview(tipView);
            }
        } else {
            tipView.removeFromSuperview()
        }
    }

    @IBAction func changeCategory(sender: UIButton) {
        sender.selected = !sender.selected;
        if sender.selected {
            self.rangeBtn.selected = false;
            tipView.num = self.inviteNum;
            tipView.frame = CGRectMake(0, 33, MainScreenWidth, MainScreenHeight);
            tipView.reloadData(0)
            if tipView.superview != self.view {
                self.view.addSubview(tipView);
            }
        } else {
            tipView.removeFromSuperview()
        }
    }
    
    func didSelectedRow(row: Int, withContent title: String, withType type: Int) {
        if type == 0 {
            categoryBtn.selected = false;
            if self.classArray.count == row+1{
                self.numLabel.hidden = true;
                self.inviteNum = 0;
                let infoVC:UIInviteViewController = UIInviteViewController(nibName:"UIInviteViewController", bundle: NSBundle.mainBundle())
                infoVC.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(infoVC, animated: true);
                return;
            }
            self.store_class = title;
        } else {
            rangeBtn.selected = false;
            self.orderType = row+1;
        }
        self.listTableView.header.beginRefreshing()
    }
    
    func didRemove() {
        categoryBtn.selected = false;
        rangeBtn.selected = false;
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        if tipView.superview == self.view {
            self.didRemove();
            tipView.removeFromSuperview()
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
