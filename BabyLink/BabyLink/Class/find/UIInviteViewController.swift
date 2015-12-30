//
//  UIInviteViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/29.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIInviteViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var listTableView: UITableView!
    var dataArray:NSMutableArray! = NSMutableArray()
    var page = 1;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "被邀请列表"
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
        self.listTableView.registerNib(UINib(nibName: "UIFindInviteTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "inviteCellID");
        self.getListData();
        
    }
    func refreshListData(){
        self.page = 1;
        self.getListData();
    }
    func getMoreListData(){
        self.page++;
        self.getListData();
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inviteCellID", forIndexPath: indexPath) as! UIFindInviteTableViewCell;
        let findModel = self.dataArray[indexPath.row] as! NSFind;
        cell.setContentData(findModel)
        cell.checkBtn.tag = indexPath.row;
        cell.checkBtn.addTarget(self, action: "checkInfo:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95;
    }
    func checkInfo(sender:UIButton){
        let infoVC:UIFindInfoViewController = UIFindInfoViewController(nibName:"UIFindInfoViewController", bundle: NSBundle.mainBundle())
        let findModel = self.dataArray[sender.tag] as! NSFind;
        infoVC.listModel = findModel;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    
    func getListData(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"\(self.page)","被邀请","1",locationParam.latitude.description,locationParam.longitude.description] , forKeys: [MEMBER_ID,"page","store_class","order_type","latitude","longitude"]);
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
