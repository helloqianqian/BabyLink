//
//  MyFansViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyFansViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    var dataArray:NSMutableArray! = NSMutableArray();
    var page = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的粉丝"
        listTableView.dataSource = self;
        listTableView.delegate = self;
        self.listTableView.registerNib(UINib(nibName: "UIPersonTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFriendsCellID");
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
        self.listTableView.header.beginRefreshing();
    }
    func refreshListData(){
        self.page = 1;
        self.reloadTableData()
    }
    func getMoreListData(){
        self.page++ ;
        self.reloadTableData()
    }
    func reloadTableData(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"\(self.page)"] , forKeys: [MEMBER_ID,"page"]);
        NSHttpHelp.httpHelpWithUrlTpye(xiuFansType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                if self.page == 1 {
                    self.dataArray.removeAllObjects();
                }
                let datas = dic["datas"] as! NSArray;
                for data in datas {
                    let change = NSFanObject();
                    change.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                    self.dataArray.addObject(change);
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
        let cell = tableView.dequeueReusableCellWithIdentifier("UIFriendsCellID", forIndexPath: indexPath) as! UIPersonTableViewCell;
        let friend = self.dataArray[indexPath.row] as! NSFanObject;
        cell.setContentOfFans(friend);
        cell.addBtn.tag = indexPath.row;
        cell.addBtn.addTarget(self, action: "addFriend:", forControlEvents: UIControlEvents.TouchUpInside);
        return cell
    }
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5;
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5;
    }
    
    func addFriend(sender:UIButton){
        let xiu = self.dataArray[sender.tag] as! NSFanObject;
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,xiu.fans_id] , forKeys: [MEMBER_ID,"friend_id"]);
        NSHttpHelp.httpHelpWithUrlTpye(addFriendType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.showImage(nil, status: "已添加关注")
                showLinkLoad = true;
                self.listTableView.header.beginRefreshing();
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
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
