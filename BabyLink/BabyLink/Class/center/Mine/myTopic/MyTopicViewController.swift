//
//  MyTopicViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyTopicViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var listTableView: UITableView!
    var dataArray:NSMutableArray! = NSMutableArray()
    var page = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的话题"
        
        listTableView.dataSource = self;
        listTableView.delegate = self;
        listTableView.registerNib(UINib(nibName: "UIMyTalkTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIMyTalkCellIdentifier")
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
        self.listTableView.header.beginRefreshing();
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if reloadMyTalkList {
            self.refreshListData();
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

    func getListData(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"1","\(self.page)"] , forKeys: [MEMBER_ID,"me","page"]);
        NSHttpHelp.httpHelpWithUrlTpye(talkListType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                if self.page == 1 {
                    self.dataArray.removeAllObjects();
                }
                let datas = dic["datas"] as! NSArray;
                for data in datas {
                    let talk = NSTalk();
                    talk.setValuesForKeysWithDictionary(data as! [String : AnyObject]);
                    talk.tableViewHeight = 0;
                    
                    
                    let commends = data["commend_list"] as! NSArray;
                    for comment in commends {
                        let aCommend = NSTalkCommentObject()
                        aCommend.setValuesForKeysWithDictionary(comment as! [String : AnyObject]);
                        talk.commends.addObject(aCommend);
                        
                        var size:CGSize!;
                        let  font:UIFont = UIFont.systemFontOfSize(12);
                        if aCommend.to_id == "" || aCommend.to_id == "0" || aCommend.to_id == aCommend.from_id{
                            let content = "\(aCommend.from_name)：\(aCommend.info)" as NSString;
                            size = content.sizeWithConstrainedToWidth(Float(MainScreenWidth-78), fromFont:font, lineSpace: 2.5);
                        } else {
                            let content = "\(aCommend.from_name)回复\(aCommend.to_name)：\(aCommend.info)" as NSString;
                            size = content.sizeWithConstrainedToWidth(Float(MainScreenWidth-78), fromFont:font, lineSpace: 2.5);
                        }
                        aCommend.cellHeight = size.height+5;
                    }
                    let  font:UIFont = UIFont.systemFontOfSize(13);
                    let size:CGSize! = talk.info.sizeWithConstrainedToWidth(Float(MainScreenWidth-80), fromFont:font, lineSpace: 3);
                    talk.tableViewHeight = size.height+5;
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
        let cell = tableView.dequeueReusableCellWithIdentifier("UIMyTalkCellIdentifier", forIndexPath: indexPath) as! UIMyTalkTableViewCell;
        let model = self.dataArray[indexPath.row] as! NSTalk;
        cell.setContentData(model);
        return cell
    }
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoVC:MyTopicInfoViewController = MyTopicInfoViewController(nibName:"MyTopicInfoViewController", bundle:NSBundle.mainBundle());
        let talk = self.dataArray[indexPath.row] as! NSTalk;
        infoVC.talk = talk;
        self.navigationController?.pushViewController(infoVC, animated: true);
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = self.dataArray[indexPath.row] as! NSTalk;
        return model.tableViewHeight+96;
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
