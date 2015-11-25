//
//  UIActivityInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityInfoViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource,UICommentDelegate,YFInputBarDelegate{

    @IBOutlet weak var listTableView: UITableView!
    var activityID:String!;
    var infoModel:NSActInfoObject! = NSActInfoObject();
    var spread=false;
    
    var inputBar:YFInputBar!;
    var commentObject:NSCommentObject?;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "活动详情"
        activityInfoLoad = false;
        self.setUI();
        self.setInputBar();
        self.getInfoData();
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.inputBar.shouldShow = true;
        if activityInfoLoad {
            activityInfoLoad = false
            self.getInfoData();
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.inputBar.shouldShow = false;
    }
    
    func setUI() {
        listTableView.registerNib(UINib(nibName: "UIActivityInfoFirstTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoFirstTableViewCellIndentifier");
        listTableView.registerNib(UINib(nibName: "UIActivityInfoSecondTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoSecondTableViewCellIndentifier");
        listTableView.registerNib(UINib(nibName: "UIActivityInfoThirdTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoThirdTableViewCellIndentifier");
        listTableView.registerNib(UINib(nibName: "UIActivityInfoForthTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoForthTableViewCellIndentifier");
        listTableView.registerNib(UINib(nibName: "UIActivityInfoFifthTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIActivityInfoFifthTableViewCellIndentifier");
        
        let footerView = NSBundle.mainBundle().loadNibNamed("UIActivityInfoFooterView", owner: nil, options: nil).first as! UIActivityInfoFooterView;
        footerView.frame = CGRectMake(0, 0, MainScreenWidth, 57);
        footerView.enrollBtn.addTarget(self, action: "enrollInTheActivity:", forControlEvents: UIControlEvents.TouchUpInside);
        listTableView.tableFooterView = footerView;
    }
    func setInputBar(){
        inputBar = YFInputBar(frame: CGRectMake(0 ,MainScreenHeight,MainScreenWidth,45))
        inputBar.delegate = self;
        inputBar.clearInputWhenSend = true;
        inputBar.resignFirstResponderWhenSend = true;
        self.view.addSubview(self.inputBar);
    }
    func getInfoData(){
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.activityID] , forKeys: [MEMBER_ID,"activity_id"]);
        NSHttpHelp.httpHelpWithUrlTpye(actInfoType, withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let code = result["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.dismiss();
                let datas = result["datas"] as! NSDictionary;
                self.infoModel.setValuesForKeysWithDictionary(datas as! [String : AnyObject] )
                let comments = datas["commend_list"] as! NSArray;
                self.infoModel.commends.removeAllObjects();
                for comment in comments {
                    let commentObject = NSCommentObject()
                    commentObject.setValuesForKeysWithDictionary(comment as! [String : AnyObject]);
                    self.infoModel.commends.addObject(commentObject);
                }
                let logs = datas["log_list"] as! NSArray
                self.infoModel.logs.removeAllObjects();
                for log in logs {
                    let logObject = NSLogListObject()
                    logObject.setValuesForKeysWithDictionary(log as! [String : AnyObject]);
                    self.infoModel.logs.addObject(logObject);
                }
                self.listTableView.reloadData();
            } else {
                let datas = result["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
        }) { (error:AnyObject!) -> Void in
                
        }
    }
    
    //MARK - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.infoModel.is_help == "0" {
            return 5;
        } else {
            return 6;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var indexRow = indexPath.row;
        if self.infoModel.is_help == "0" && indexPath.row > 1{
            indexRow++;
        }
        if indexRow == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoFirstTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityInfoFirstTableViewCell;
            cell.setContentData(self.infoModel);
            return cell;
        }
        else if indexRow == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoSecondTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityInfoSecondTableViewCell;
            cell.resetContent(self.infoModel,AtIndexPath: indexRow);
            return cell;
        }
        else if indexRow == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoSecondTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityInfoSecondTableViewCell;
            cell.resetContent(self.infoModel,AtIndexPath: indexRow);
            return cell;
        }
        else if indexRow == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoThirdTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityInfoThirdTableViewCell;
            cell.setContentData(self.infoModel)
            return cell;
        }
        else if indexRow == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoForthTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityInfoForthTableViewCell;
            cell.delegate = self;
            cell.setContentData(self.infoModel)
            return cell;
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoFifthTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityInfoFifthTableViewCell;
            return cell;
        }
    }
    
    
    //MARK - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var indexRow = indexPath.row;
        if self.infoModel.is_help == "0" && indexPath.row > 1{
            indexRow++;
        }
        
        if indexRow == 0 {
            return 416;
        }
        else if indexRow == 1 {
            let  font:UIFont = UIFont.systemFontOfSize(12);
            let size:CGSize = (self.infoModel.info as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-30), fromFont:font, lineSpace: 2.5);
            return size.height+60;
        }
        else if indexRow == 2 {
            let  font:UIFont = UIFont.systemFontOfSize(12);
            let size:CGSize = (self.infoModel.help as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-30), fromFont:font, lineSpace: 2.5);
            return size.height+60;
        }
        else if indexRow == 3 {
            let count = self.infoModel.logs.count;
            var hang = count/5;
            let left = count%5;
            if left>0{
                hang+=1;
            }
            if hang == 0 {
                return 120;
            } else {
                return CGFloat(hang * 75 + 55);
            }
        }
        else if indexRow == 4 {
            if self.infoModel.commends.count == 0 {
                return 126;
            }
            if spread {
                var height:CGFloat = 83;
                for comment in self.infoModel.commends {
                    let  font:UIFont = UIFont.systemFontOfSize(13);
                    let size:CGSize = (comment.info as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-80), fromFont:font, lineSpace: 2.5);
                    height+=(size.height+45);
                }
                return height-2;
            } else {
                var height:CGFloat = 83;
                for var i = 0; i<(self.infoModel.commends.count>2 ? 2 : self.infoModel.commends.count);i++ {
                    let  font:UIFont = UIFont.systemFontOfSize(13);
                    let comment = self.infoModel.commends[i] as! NSCommentObject;
                    let size:CGSize = (comment.info as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-80), fromFont:font, lineSpace: 2.5);
                    height+=(size.height+45);
                }
                return height-2;
            }
        }
        else {
            return 128;
        }
    }
    
    
    //MARK: - tableview function
    func enrollInTheActivity(sender:UIButton){
        let joinVC:UIJoinViewController = UIJoinViewController.init(nibName:"UIJoinViewController",bundle:NSBundle.mainBundle())
        joinVC.activityID = self.infoModel.activity_id;
        self.navigationController?.pushViewController(joinVC, animated: true);
    }
    func didSelectedComment() {
        self.commentObject = nil;
        self.inputBar.textField.becomeFirstResponder();
    }
    func didSelectedAtIndexPath(infoModel: NSCommentObject) {
        self.commentObject = infoModel;
        self.inputBar.textField.becomeFirstResponder();
    }
    func didSpreadComments(spread: Bool) {
        self.spread = spread;
        self.listTableView.reloadData();
    }
    func inputBar(inputBar: YFInputBar!, sendBtnPress sendBtn: UIButton!, withInputString str: String!) {
        var to_userId = NSUserInfo.shareInstance().member_id;
        var to_userName = NSUserInfo.shareInstance().member_name;
        if commentObject != nil {
            to_userId = commentObject?.from_userId;
            to_userName = commentObject?.from_userName;
        }
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.activityID,to_userId,to_userName,str] , forKeys: [MEMBER_ID,"activity_id","to_userId","to_userName","info"]);
        NSHttpHelp.httpHelpWithUrlTpye(commentActType, withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let code = result["code"] as! NSInteger;
            if code == 0 {
                self.getInfoData();
            } else {
                let datas = result["datas"] as! String;
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
