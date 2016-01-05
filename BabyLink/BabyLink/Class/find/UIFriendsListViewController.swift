//
//  UIFriendsListViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/9.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFriendsListViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    
    var dataArray:NSMutableArray!=NSMutableArray();
    var listModel:NSInfoFind! = NSInfoFind();
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "小区好友"
        
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.registerNib(UINib(nibName: "UIFriendsTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIFriendsTableViewCellIdentifier");
        
        self.getlistData()
    }
    
    func getlistData(){
        let dicParam:NSDictionary = NSDictionary(objects: [listModel.goods_id,NSUserInfo.shareInstance().member_id] , forKeys: ["goods_id",MEMBER_ID]);
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getGoodsFListUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                let datas = dic["datas"] as! NSArray;
                for data in datas {
                    let friend = NSFriendObject();
                    friend.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                    self.dataArray.addObject(friend);
                }
                self.listTableView.reloadData()
            } else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIFriendsTableViewCellIdentifier", forIndexPath: indexPath) as! UIFriendsTableViewCell
        let friend = self.dataArray[indexPath.row] as! NSFriendObject;
        cell.setContentData(friend);
        cell.inviteBtn.tag = indexPath.row;
        cell.inviteBtn.addTarget(self, action: "inviteFriends:", forControlEvents: UIControlEvents.TouchUpInside);
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5;
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5;
    }
    
    func inviteFriends(sender:UIButton){
        let friend = self.dataArray[sender.tag] as! NSFriendObject;
        let dicParam:NSDictionary = NSDictionary(objects: [listModel.goods_id,NSUserInfo.shareInstance().member_id,friend.friend_id] , forKeys: ["goods_id",MEMBER_ID,"friend_id"]);
        NSHttpHelp.httpHelpWithUrl(NSHttpModel.getGoodsIssueUrl(), withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                friend.status = 2;
                self.listTableView.reloadData()
            } else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
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
