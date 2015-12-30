//
//  UITopicView.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UITopicView: UIView ,UITableViewDelegate,UITableViewDataSource,UITalkCommentDelegate,YFInputBarDelegate{
    @IBOutlet weak var listTableView: UITableView!
    var dataArray:NSMutableArray! = NSMutableArray();
    var page = 1;
    var inputBar:YFInputBar!;
    var commentObject:NSTalkCommentObject!=NSTalkCommentObject();
    var superVC:UILocalViewController!;
    override func awakeFromNib() {
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UITopicTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UITopicTableViewCellIdentifier")
        self.listTableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshListData")
        self.listTableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "getMoreListData");
        
        self.setInputBar()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }
    func setInputBar(){
        inputBar = YFInputBar(frame: CGRectMake(0 ,MainScreenHeight,MainScreenWidth,45))
        inputBar.delegate = self;
        inputBar.clearInputWhenSend = true;
        inputBar.resignFirstResponderWhenSend = true;
        self.addSubview(self.inputBar);
    }
    
    
    func refreshListData(){
        mainTabBar.getNums();
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
    func getListData(){
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,"\(self.page)"] , forKeys: [MEMBER_ID,"page"]);
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
                    let commends = data["commend_list"] as! NSArray;
                    talk.tableViewHeight = 0;
                    for comment in commends {
                        let aCommend = NSTalkCommentObject()
                        aCommend.setValuesForKeysWithDictionary(comment as! [String : AnyObject]);
                        talk.commends.addObject(aCommend);
                        
                        var size:CGSize!;
                        let  font:UIFont = UIFont.systemFontOfSize(12);
                        if aCommend.to_id == "" || aCommend.to_id == "0" || aCommend.to_id == aCommend.from_id{
                            let content = "\(aCommend.from_name)：\(aCommend.info)" as NSString;
                            size = content.sizeWithConstrainedToWidth(Float(MainScreenWidth-78), fromFont:font, lineSpace: 3.0);
                        } else {
                            let content = "\(aCommend.from_name)回复\(aCommend.to_name)：\(aCommend.info)" as NSString;
                            size = content.sizeWithConstrainedToWidth(Float(MainScreenWidth-78), fromFont:font, lineSpace: 3.0);
                        }
                        aCommend.cellHeight = size.height+5;
                        talk.tableViewHeight+=(size.height+5);
                    }
                    if talk.commends.count>0{
                        talk.tableViewHeight+=20;
                    }
                    self.dataArray.addObject(talk);
                }
                self.listTableView.reloadData();
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
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 90;
        let model = self.dataArray[indexPath.row] as! NSTalk;
        if model.images_url.count > 2 {
            height+=222;
        } else if model.images_url.count > 0 {
            height+=108;
        }
        if model.commends.count>0{
            height+=(14+model.tableViewHeight);
        }
        let infoSize = (model.info as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-80), fromFont: UIFont.systemFontOfSize(13), lineSpace: 3)
        return height + infoSize.height+5;
    }
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITopicTableViewCellIdentifier", forIndexPath: indexPath) as! UITopicTableViewCell;
        let model = self.dataArray[indexPath.row] as! NSTalk;
        cell.setContentData(model,withIndexRow: indexPath.row);
        cell.delegate = self;
        cell.superVC = self.superVC;
        return cell;
    }
    func didSelectAtIndexPath(infoModel:NSTalkCommentObject){
        self.commentObject = infoModel;
        self.inputBar.textField.placeholder = "回复\(infoModel.from_name):"
        self.inputBar.textField.becomeFirstResponder();
        self.listTableView.userInteractionEnabled = false;
    }
    func didSelectComment(infoModel:NSTalkCommentObject){
        self.commentObject = infoModel;
        self.commentObject.from_id = "";
        self.inputBar.textField.placeholder = "输入评论:"
        self.inputBar.textField.becomeFirstResponder();
        self.listTableView.userInteractionEnabled = false;
    }
    func keyboardWillHide(notification:NSNotification){
        self.listTableView.userInteractionEnabled = true;
    }
    func keyboardWillShow(notification:NSNotification){
        self.listTableView.userInteractionEnabled = false;
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    
    func inputBar(inputBar: YFInputBar!, sendBtnPress sendBtn: UIButton!, withInputString str: String!) {
        if str == "" {
            return;
        }
        let to_id = self.commentObject.from_id;
        let from_id = NSUserInfo.shareInstance().member_id;
        
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.commentObject.talk_id,from_id,to_id,str] , forKeys: [MEMBER_ID,"talk_id","from_id","to_id","info"]);
        NSHttpHelp.httpHelpWithUrlTpye(commentTalkType, withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let code = result["code"] as! NSInteger;
            if code == 0 {
                let aComment:NSTalkCommentObject = NSTalkCommentObject();
                aComment.talk_id = self.commentObject.talk_id;
                aComment.info = str;
                aComment.from_id = NSUserInfo.shareInstance().member_id;
                aComment.from_name = NSUserInfo.shareInstance().member_name;
                aComment.to_id = to_id;
                aComment.to_name = self.commentObject.from_name;
                
                let talkObject = self.dataArray[self.commentObject.indexRow] as! NSTalk;
                var size:CGSize!;
                let  font:UIFont = UIFont.systemFontOfSize(12);
                if aComment.to_id == "" || aComment.to_id == "0" || aComment.to_id == aComment.from_id {
                    let content = "\(aComment.from_name)：\(aComment.info)" as NSString;
                    size = content.sizeWithConstrainedToWidth(Float(MainScreenWidth-78), fromFont:font, lineSpace: 2.5);
                } else {
                    let content = "\(aComment.from_name)回复\(aComment.to_name)：\(aComment.info)" as NSString;
                    size = content.sizeWithConstrainedToWidth(Float(MainScreenWidth-78), fromFont:font, lineSpace: 2.5);
                }
                aComment.cellHeight = size.height+5;
                if talkObject.commends.count>0 {
                    talkObject.tableViewHeight+=(size.height+5);
                } else {
                    talkObject.tableViewHeight+=(size.height+25);
                }
                talkObject.commends.insertObject(aComment, atIndex: 0);
                self.listTableView.reloadData();
            } else {
                let datas = result["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
