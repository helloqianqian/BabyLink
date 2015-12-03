//
//  MyTopicInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyTopicInfoViewController: UIBaseViewController ,UITableViewDelegate,UITableViewDataSource,UITalkCommentDelegate,YFInputBarDelegate{

    @IBOutlet weak var listTableView: UITableView!
    var talk:NSTalk! = NSTalk();
    var inputBar:YFInputBar!;
    var commentObject:NSTalkCommentObject!=NSTalkCommentObject();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的话题"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
        
        self.setInputBar();
        self.reCalculateHeight();
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.registerNib(UINib(nibName: "UITopicTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UIMyTopicTableViewCellIdentifier")
    }

    
    func setInputBar(){
        inputBar = YFInputBar(frame: CGRectMake(0 ,MainScreenHeight,MainScreenWidth,45))
        inputBar.delegate = self;
        inputBar.clearInputWhenSend = true;
        inputBar.resignFirstResponderWhenSend = true;
        self.view.addSubview(self.inputBar);
    }
    
    func reCalculateHeight(){
        self.talk.tableViewHeight = 0;
        for comment in talk.commends {
            let aComment = comment as! NSTalkCommentObject;
            talk.tableViewHeight+=aComment.cellHeight;
        }
        if self.talk.commends.count>0{
            talk.tableViewHeight+=20;
        }
    }
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 90;
        if self.talk.images_url.count > 2 {
            height+=222;
        } else if self.talk.images_url.count > 0 {
            height+=108;
        }
        if self.talk.commends.count>0{
            height+=(14+self.talk.tableViewHeight);
        }
        let infoSize = (self.talk.info as NSString).sizeWithConstrainedToWidth(Float(MainScreenWidth-71), fromFont: UIFont.systemFontOfSize(13), lineSpace: 2.5)
        return height + infoSize.height+55;
    }
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UIMyTopicTableViewCellIdentifier", forIndexPath: indexPath) as! UITopicTableViewCell;
        cell.setContentData(self.talk,withIndexRow: indexPath.row);
        cell.delegate = self;
        cell.superVC = self;
        cell.deleteBtn.hidden = false;
        cell.deleteBtn.addTarget(self, action: "deleteMyTalk", forControlEvents: UIControlEvents.TouchUpInside);
        return cell;
    }
    
    func deleteMyTalk(){
        
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.talk.talk_id] , forKeys: [MEMBER_ID,"talk_id"]);
        NSHttpHelp.httpHelpWithUrlTpye(deleteTalkType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showImage(nil, status: "删除成功");
                reloadMyTalkList = true;
                talkListLoad = true;
                self.navigationController?.popViewControllerAnimated(true);
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        };
    }
    
    
    func didSelectAtIndexPath(infoModel:NSTalkCommentObject){
        self.commentObject = infoModel;
        self.inputBar.textField.placeholder = "回复\(infoModel.from_name):"
        self.inputBar.textField.becomeFirstResponder();
        self.listTableView.userInteractionEnabled = false;
    }
    func didSelectComment(infoModel:NSTalkCommentObject){
        self.commentObject = infoModel;
        self.inputBar.textField.placeholder = "输入评论:"
        self.inputBar.textField.becomeFirstResponder();
        self.listTableView.userInteractionEnabled = false;
    }
    func keyboardWillHide(notification:NSNotification){
        
        self.listTableView.userInteractionEnabled = true;
        self.removeGesture();
    }
    func keyboardWillShow(notification:NSNotification){
        
        self.listTableView.userInteractionEnabled = false;
        self.addGesture();
        
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
                
                var size:CGSize!;
                let  font:UIFont = UIFont.systemFontOfSize(12);
                if aComment.to_id == self.talk.member_id {
                    let content = "\(aComment.from_name)：\(aComment.info)" as NSString;
                    size = content.sizeWithConstrainedToWidth(Float(MainScreenWidth-78), fromFont:font, lineSpace: 2.5);
                } else {
                    let content = "\(aComment.from_name)回复\(aComment.to_name)：\(aComment.info)" as NSString;
                    size = content.sizeWithConstrainedToWidth(Float(MainScreenWidth-78), fromFont:font, lineSpace: 2.5);
                }
                aComment.cellHeight = size.height+5;
                if self.talk.commends.count>0 {
                    self.talk.tableViewHeight+=(size.height+5);
                } else {
                    self.talk.tableViewHeight+=(size.height+25);
                }
                self.talk.commends.insertObject(aComment, atIndex: 0);
                self.listTableView.reloadData();
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
