//
//  MyActivityViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyActivityViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var myListBtn: UIButton!
    @IBOutlet weak var otherListBtn: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    var contentType=0;
    var dataArray:NSMutableArray! = NSMutableArray();
    var otherArray:NSMutableArray! = NSMutableArray();
    
//    var page = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的活动"
        myListBtn.makeBackGroundColor_PurpleSelected();
        otherListBtn.makeBackGroundColor_PurpleSelected();
        
        listTableView.dataSource = self;
        listTableView.delegate = self;
        listTableView.registerNib(UINib(nibName: "UIMyActTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIMyActTableViewCellIdentifier")
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.loadContentData(false);
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if reloadMyJoinActList {
            reloadMyJoinActList = false;
            self.loadContentData(true);
        }
    }
    
    
    func loadContentData(force:Bool) {
        if self.contentType == 0 {
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
    
    func refreshListData(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id] , forKeys: [MEMBER_ID]);
        if contentType == 0 {
            NSHttpHelp.httpHelpWithUrlTpye(actLaunchType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
                let dic = returnObject as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    //我发起的
                    self.dataArray.removeAllObjects();
                    let datas = dic["datas"] as! NSArray;
                    for data in datas {
                        let change = NSActListObject();
                        change.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                        self.dataArray.addObject(change);
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
        } else {
            NSHttpHelp.httpHelpWithUrlTpye(actJoinedType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
                let dic = returnObject as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    //我参加的
                    self.otherArray.removeAllObjects();
                    let datas = dic["datas"] as! NSArray;
                    for data in datas {
                        let change = NSActListObject();
                        change.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                        self.otherArray.addObject(change);
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contentType == 0 {
            return self.dataArray.count;
        } else {
            return self.otherArray.count;
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIMyActTableViewCellIdentifier", forIndexPath: indexPath) as! UIMyActTableViewCell;
        if contentType == 0 {
            let model = self.dataArray[indexPath.row] as! NSActListObject;
            cell.setActivityData(model);
        } else {
            let model = self.otherArray[indexPath.row] as! NSActListObject;
            cell.setActivityData(model);
        }
        return cell;
    }
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoVC:UIActivityInfoViewController = UIActivityInfoViewController(nibName:"UIActivityInfoViewController",bundle:NSBundle.mainBundle())
        
        if contentType == 0 {
            let model = self.dataArray[indexPath.row] as! NSActListObject;
            infoVC.activityID = model.activity_id;
            infoVC.sourceFrom = 1;
        } else {
            let model = self.otherArray[indexPath.row] as! NSActListObject;
            infoVC.activityID = model.activity_id;
            model.isSign = true;
            model.isOut = false;
            infoVC.listModel = model;
            infoVC.sourceFrom = 2;
        }
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    
    
    

    @IBAction func otherlist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            myListBtn.selected = false;
            self.contentType = 1;
            self.loadContentData(false);
        }
    }
    @IBAction func mylist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            otherListBtn.selected = false;
            self.contentType = 0;
            self.loadContentData(false);
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
