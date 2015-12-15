//
//  MyShowViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyShowViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    var dataArray:NSMutableArray! = NSMutableArray();
    var page = 1;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的秀逗"
        
        listTableView.dataSource = self;
        listTableView.delegate = self;
        listTableView.registerNib(UINib(nibName: "UIMyActTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIMyShowCellIdentifier")
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

    func reloadTableData() {
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"\(self.page)"] , forKeys: [MEMBER_ID,"page"]);
        NSHttpHelp.httpHelpWithUrlTpye(myXiuType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                if self.page == 1 {
                    self.dataArray.removeAllObjects();
                }
                let datas = dic["datas"] as! NSArray;
                for data in datas {
                    let talk = NSXiu();
                    talk.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                    let info = data["info"] as! NSString;
                    let font:UIFont = UIFont.systemFontOfSize(14);
                    let size = info.sizeWithConstrainedToWidth(Float(MainScreenWidth-56), fromFont:font, lineSpace: 3);
                    talk.infoHeight = size.height+5;
                    let commends = data["commend_list"] as! NSArray;
                    for comment in commends {
                        let aCommend = NSXiuComment()
                        aCommend.setValuesForKeysWithDictionary(comment as! [String : AnyObject]);
                        talk.commends.addObject(aCommend);
                    }
                    let zans = data["zan_list"] as! NSArray;
                    for zan in zans {
                        let aZan = NSXiuZan()
                        aZan.setValuesForKeysWithDictionary(zan as! [String : AnyObject]);
                        talk.zans.addObject(aZan);
                    }
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
        };
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIMyShowCellIdentifier", forIndexPath: indexPath) as! UIMyActTableViewCell;
        let show = self.dataArray[indexPath.row] as! NSXiu;
        cell.setShowData(show);
        return cell
    }
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoVC:MyShowInfoViewController = MyShowInfoViewController(nibName:"MyShowInfoViewController", bundle:NSBundle.mainBundle());
        let show = self.dataArray[indexPath.row] as! NSXiu;
        infoVC.xiu = show;
        self.navigationController?.pushViewController(infoVC, animated: true);
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
