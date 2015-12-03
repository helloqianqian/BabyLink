//
//  MyFriendsViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyFriendsViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var neighborBtn: UIButton!
    @IBOutlet weak var friendsBtn: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    var contentType=0;
    
    var dataArray:NSMutableArray! = NSMutableArray();
    var otherArray:NSMutableArray! = NSMutableArray();
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的好友"
        neighborBtn.makeBackGroundColor_PurpleSelected();
        friendsBtn.makeBackGroundColor_PurpleSelected();
        
        listTableView.dataSource = self;
        listTableView.delegate = self;
        self.listTableView.registerNib(UINib(nibName: "UIPersonTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFriendsTableViewCellIdentifier");
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        
        self.loadContentData(false);
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
        if contentType == 0 {
            let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id] , forKeys: [MEMBER_ID]);
            NSHttpHelp.httpHelpWithUrlTpye(xiuNeighborType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
                let dic = returnObject as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    //发送成功
                    self.dataArray.removeAllObjects();
                    let datas = dic["datas"] as! NSArray;
                    for data in datas {
                        let change = NSNeighborObject();
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
            let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id] , forKeys: [MEMBER_ID]);
            NSHttpHelp.httpHelpWithUrlTpye(xiuFriendType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
                let dic = returnObject as! NSDictionary;
                let code = dic["code"] as! NSInteger;
                if code == 0 {
                    //发送成功
                    self.otherArray.removeAllObjects();
                    let datas = dic["datas"] as! NSArray;
                    for data in datas {
                        let change = NSFriendObject();
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
        let cell = tableView.dequeueReusableCellWithIdentifier("UIFriendsTableViewCellIdentifier", forIndexPath: indexPath) as! UIPersonTableViewCell;
        if contentType == 0 {
            let neighbor = self.dataArray[indexPath.row] as! NSNeighborObject;
            cell.setContentOfNeighbors(neighbor);
        } else {
            let friend = self.otherArray[indexPath.row] as! NSFriendObject;
            cell.setContentOfFriends(friend);
            cell.addBtn.tag = indexPath.row;
            cell.addBtn.addTarget(self, action: "removeFriend:", forControlEvents: UIControlEvents.TouchUpInside);
        }
        return cell
    }
    //MARK: - UITableViewDelegate
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5;
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5;
    }
    
    @IBAction func neighborlist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            friendsBtn.selected = false;
            self.contentType = 0;
            self.loadContentData(false)
        }
    }
    @IBAction func friendslist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            neighborBtn.selected = false;
            self.contentType = 1;
            self.loadContentData(false)
        }
    }

    func removeFriend(sender:UIButton){
        let friend = self.otherArray[sender.tag] as! NSFriendObject;
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,friend.member_friend_id] , forKeys: [MEMBER_ID,"member_friend_id"]);
        NSHttpHelp.httpHelpWithUrlTpye(xiuDeleteType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                self.listTableView.header.beginRefreshing();
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        };
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
