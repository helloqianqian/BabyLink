//
//  UIActivityInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIActivityInfoViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource,UICommentDelegate,YFInputBarDelegate,UMSocialUIDelegate,UIAlertViewDelegate{

    @IBOutlet weak var listTableView: UITableView!
    
    var sourceFrom = 0;
    
    var activityID:String!;
    var listModel:NSActListObject! = NSActListObject();
    var infoModel:NSActInfoObject! = NSActInfoObject();
    var spread=false;
    
    var inputBar:YFInputBar!;
    var commentObject:NSCommentObject?;
    var footerView = NSBundle.mainBundle().loadNibNamed("UIActivityInfoFooterView", owner: nil, options: nil).first as! UIActivityInfoFooterView;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "活动详情"
        activityInfoLoad = false;
        self.setUI();
        self.setInputBar();
        self.getInfoData();
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.inputBar.shouldShow = true;
        if activityInfoLoad {
            activityInfoLoad = false
            self.getInfoData();
        }
        if signInActivity {
            signInActivity = false;
            self.infoModel.isSign = true;
            self.listTableView.reloadData();
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
        
        footerView.enrollBtn.addTarget(self, action: "enrollInTheActivity:", forControlEvents: UIControlEvents.TouchUpInside);
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
                
                if self.infoModel.member_id == NSUserInfo.shareInstance().member_id {
                    self.sourceFrom = 1;
                }
                
                self.listTableView.reloadData();
                
                mainTabBar.getNums()
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5;
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.sourceFrom == 0 || self.sourceFrom == 2{
            return 57;
        }
        return 0.5;
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.sourceFrom == 0 || self.sourceFrom == 2{
            if infoModel.isOut == "1" {
                footerView.enrollBtn.makeBackGroundColor_DarkGray()
                footerView.enrollBtn.setTitle("活动已结束", forState: UIControlState.Normal);
            } else {
                if infoModel.isSign {
                    footerView.enrollBtn.makeBackGroundColor_DarkGray()
                    footerView.enrollBtn.setTitle("取消报名", forState: UIControlState.Normal);
                } else {
                    if infoModel.isFull {
                        footerView.enrollBtn.makeBackGroundColor_DarkGray()
                        footerView.enrollBtn.setTitle("报名已满", forState: UIControlState.Normal);
                    } else if infoModel.is_end {
                        footerView.enrollBtn.makeBackGroundColor_DarkGray()
                        footerView.enrollBtn.setTitle("报名已截止", forState: UIControlState.Normal);
                    } else {
                        footerView.enrollBtn.makeBackGroundColor_Purple()
                        footerView.enrollBtn.setTitle("我要报名", forState: UIControlState.Normal);
                    }
                }
            }
            return footerView
        }
        return nil;
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
            cell.setContentData(self.infoModel,withType: self.sourceFrom)
            if self.sourceFrom == 1 {
                cell.arrowImg.addTarget(self, action: "checkParticipatorList", forControlEvents: UIControlEvents.TouchUpInside);
            }
            return cell;
        }
        else if indexRow == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoForthTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityInfoForthTableViewCell;
            cell.delegate = self;
            cell.setContentData(self.infoModel)
            return cell;
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("UIActivityInfoFifthTableViewCellIndentifier", forIndexPath: indexPath) as! UIActivityInfoFifthTableViewCell;
            
            cell.qqFriendBtn.tag = 1;
            cell.friendBtn.tag = 2;
            cell.sinaBtn.tag = 3;
            cell.friendCircle.tag = 4;
            
            cell.qqFriendBtn.addTarget(self, action: "shareActivityData:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.friendBtn.addTarget(self, action: "shareActivityData:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.sinaBtn.addTarget(self, action: "shareActivityData:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.friendCircle.addTarget(self, action: "shareActivityData:", forControlEvents: UIControlEvents.TouchUpInside)
            
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
            return 436;
        }
        else if indexRow == 1 {
            let  font:UIFont = UIFont.systemFontOfSize(12);
            let size:CGSize = (self.infoModel.info as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-30), fromFont:font, lineSpace: 2.5);
            return size.height+80;
        }
        else if indexRow == 2 {
            let  font:UIFont = UIFont.systemFontOfSize(12);
            let size:CGSize = (self.infoModel.help as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-30), fromFont:font, lineSpace: 2.5);
            return size.height+80;
        }
        else if indexRow == 3 {
            let count = self.infoModel.logs.count;
            var per = 5
            if iphone6Plus {
                per = 7;
            } else if iphone6 {
                per = 6
            }
            var hang = count/per;
            let left = count%per;
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
        
        if infoModel.isOut  == "1"{
            return;
        } else {
            if infoModel.isSign {
            } else {
                if infoModel.isFull {
                    return;
                } else if infoModel.is_end {
                    return;
                } else {
                
                }
            }
        }
        
        
        if self.infoModel.isSign {
            let alertView = UIAlertView(title: "提示", message: "确定取消报名吗？", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
            alertView.show();
        } else {
            let joinVC:UIJoinViewController = UIJoinViewController(nibName:"UIJoinViewController",bundle:NSBundle.mainBundle())
            joinVC.activityID = self.infoModel.activity_id;
            joinVC.actModel = self.infoModel;
            joinVC.from = self.sourceFrom;
            self.navigationController?.pushViewController(joinVC, animated: true);
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
            let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.activityID] , forKeys: [MEMBER_ID,"activity_id"]);
            NSHttpHelp.httpHelpWithUrlTpye(cancelActType, withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let code = result["code"] as! NSInteger;
            if code == 0 {
            SVProgressHUD.showSuccessWithStatus("取消报名成功");
            self.infoModel.isSign = false;
            self.listTableView.reloadData()
            activityListLoad = true;
            self.getInfoData();
            } else {
            let datas = result["datas"] as! String;
            SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
            
            }
        }
    }
    
    func didSelectedComment() {
        self.commentObject = nil;
        self.inputBar.textField.placeholder = "输入评论";
        self.inputBar.textField.becomeFirstResponder();
    }
    func didSelectedAtIndexPath(infoModel: NSCommentObject) {
        self.commentObject = infoModel;
        self.inputBar.textField.placeholder = "回复\(infoModel.from_userName):";
        self.inputBar.textField.becomeFirstResponder();
    }
    func didSpreadComments(spread: Bool) {
        self.spread = spread;
        self.listTableView.reloadData();
    }
    func checkParticipatorList(){
        let participatorList = UIParticipateViewController(nibName:"UIParticipateViewController" ,bundle: NSBundle.mainBundle())
        participatorList.logs = self.infoModel.logs;
        self.navigationController?.pushViewController(participatorList, animated: true);
    }
    
    func inputBar(inputBar: YFInputBar!, sendBtnPress sendBtn: UIButton!, withInputString str: String!) {
        var to_userId = ""//NSUserInfo.shareInstance().member_id;
        var to_userName = NSUserInfo.shareInstance().member_name;
        if commentObject != nil {
            to_userId = (commentObject?.from_userId)!;
            to_userName = (commentObject?.from_userName)!;
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
    func keyboardWillShow(notification:NSNotification){
        self.addGesture();
    }
    func keyboardWillHide(notification:NSNotification){
        self.removeGesture();
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func shareActivityData(sender:UIButton){
        var fenxiang = "http://www.baidu.com";
        if self.infoModel.fenxiang_url != "" {
            fenxiang = self.infoModel.fenxiang_url;
        }
        
        if sender.tag == 1 {
            UMSocialData.defaultData().extConfig.qqData.url = fenxiang;
            UMSocialData.defaultData().extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
            UMSocialData.defaultData().extConfig.qqData.title = "活动分享"
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToQQ], content: "分享活动。", image: UIImage(named: "120"), location: nil, urlResource: nil, presentedController: self, completion: { (response) -> Void in
                if (response.responseCode == UMSResponseCodeSuccess) {
                    SVProgressHUD.showSuccessWithStatus("分享成功");
                } else {
                    SVProgressHUD.showErrorWithStatus("分享失败")
                }
            })
        } else if sender.tag == 2 {
            UMSocialData.defaultData().extConfig.wechatSessionData.url = fenxiang;
            UMSocialData.defaultData().extConfig.wechatSessionData.title = "活动分享"
            UMSocialData.defaultData().extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession], content: "分享活动。", image: UIImage(named: "120"), location: nil, urlResource: nil, presentedController: self, completion: { (response) -> Void in
                if (response.responseCode == UMSResponseCodeSuccess) {
                    SVProgressHUD.showSuccessWithStatus("分享成功");
                } else {
                    SVProgressHUD.showErrorWithStatus("分享失败")
                }
            })
        } else if sender.tag == 3 {
            UMSocialData.defaultData().urlResource.setResourceType(UMSocialUrlResourceTypeImage, url: fenxiang);
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToSina], content: "分享活动。", image: UIImage(named: "120"), location: nil, urlResource: nil, presentedController: self, completion: { (response) -> Void in
                if (response.responseCode == UMSResponseCodeSuccess) {
                    SVProgressHUD.showSuccessWithStatus("分享成功");
                } else {
                    SVProgressHUD.showErrorWithStatus("分享失败")
                }
            })
        } else {
            UMSocialData.defaultData().extConfig.wechatTimelineData.url = fenxiang;
            UMSocialData.defaultData().extConfig.wechatTimelineData.title = "活动分享"
            UMSocialData.defaultData().extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatTimeline], content: "分享活动。", image: UIImage(named: "120"), location: nil, urlResource: nil, presentedController: self, completion: { (response) -> Void in
                if (response.responseCode == UMSResponseCodeSuccess) {
                    SVProgressHUD.showSuccessWithStatus("分享成功");
                } else {
                    SVProgressHUD.showErrorWithStatus("分享失败")
                }
            })
        }
    }
    
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        if response.responseCode == UMSResponseCodeSuccess {
            SVProgressHUD.showSuccessWithStatus("分享成功");
        } else {
            SVProgressHUD.showErrorWithStatus("分享失败")
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
