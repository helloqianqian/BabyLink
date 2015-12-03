//
//  UIDouViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/2.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIDouViewController: UIBaseViewController ,YFInputBarDelegate{


    @IBOutlet var unloadGestrue: UITapGestureRecognizer!
    var showModel:NSXiu! = NSXiu()
    var inputBar:YFInputBar!;
    var titleView:UIShowTableViewCell!;
    var itemView:UIShowItemView!;
    var beginPoint:CGPoint!;
    var moveIn = false;
    
    var from = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(unloadGestrue);
        

        titleView = NSBundle.mainBundle().loadNibNamed("UIShowTableViewCell", owner: nil, options: nil).first as! UIShowTableViewCell;
        titleView.userInteractionEnabled = false;
        titleView.setContentDataFormLink(self.showModel)
        var height:CGFloat = 120;
        let count = showModel.zans.count;
        var per = 0
        if iphone6Plus {
            height+=388;
            per = 13;
        } else if iphone6 {
            height+=349
            per = 12;
        } else {
            height+=294;
            per=10;
        }
        var hang = count/per;
        let left = count%per;
        if left>0 || hang == 0{
            hang+=1;
        }
        titleView.frame = CGRectMake(0, 20, MainScreenWidth, height + CGFloat(hang*26) + showModel.infoHeight)
        self.view.addSubview(titleView);
        self.setInputBar();
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.inputBar.textField.becomeFirstResponder();
        itemView = NSBundle.mainBundle().loadNibNamed("UIShowItemView", owner: nil, options: nil).first as! UIShowItemView;
        self.view.addSubview(itemView);
        itemView.frame = CGRectMake(MainScreenWidth/2, 62+MainScreenWidth/2, 48, 30);
        itemView.headIcon.sd_setImageWithURL(NSURL(string: NSUserInfo.shareInstance().member_avar), placeholderImage: UIImage(named: "morentoux"));
        
        for var i=0 ;i<showModel.commends.count; i++ {
            //13........13
            let aComment = showModel.commends[i] as! NSXiuComment;
            let tipView = NSBundle.mainBundle().loadNibNamed("UIShowItemView", owner: nil, options: nil).first as! UIShowItemView;
            tipView.tag = 1000+i;
            titleView.addSubview(tipView);
            tipView.contentLabel.text = aComment.info;
            let size = tipView.contentLabel.sizeThatFits(CGSizeMake(100, 100));
            tipView.frame = CGRectMake(13 + (MainScreenWidth-13)*aComment.position_x, 55+(MainScreenWidth-13)*aComment.position_y, size.width+48, size.height+16);
            tipView.headIcon.sd_setImageWithURL(NSURL(string: aComment.member_avar), placeholderImage: UIImage(named: "morentoux"))
            tipView.start();
        }
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        for var i=0 ;i<showModel.commends.count; i++ {
            var subview = titleView.viewWithTag(1000+i);
            if subview != nil {
                (subview as! UIShowItemView).stopAnimation();
                subview?.removeFromSuperview();
                subview = nil;
            }
        }
    }
    
    func setInputBar(){
        inputBar = YFInputBar(frame: CGRectMake(0 ,MainScreenHeight,MainScreenWidth,45))
        inputBar.delegate = self;
        inputBar.showNavigationBar = true;
        inputBar.clearInputWhenSend = true;
        inputBar.resignFirstResponderWhenSend = false;
        inputBar.textField.placeholder = "逗一逗";
        inputBar.sendBtn.setTitle("逗一逗", forState: UIControlState.Normal);
        self.view.addSubview(self.inputBar);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChanged:", name: UITextFieldTextDidChangeNotification, object: inputBar.textField);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.inputBar.textField.resignFirstResponder();
            let touchLocation = touch.locationInView(self.view)
            let frame = self.itemView.frame;
            if touchLocation.x > frame.origin.x && touchLocation.x < frame.origin.x+frame.size.width && touchLocation.y > frame.origin.y && touchLocation.y < frame.origin.y + frame.size.height {
                self.beginPoint = touchLocation;
                moveIn = true;
            }
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.inputBar.textField.becomeFirstResponder();
        moveIn = false;
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.locationInView(self.view)
            
            if moveIn {
                var frame = self.itemView.frame;
                
                if touchLocation.x>13 && touchLocation.x<MainScreenWidth-13 {
                    frame.origin.x += (touchLocation.x-self.beginPoint.x);
                    if frame.origin.x<13{
                        frame.origin.x = 13;
                    } else if frame.origin.x > MainScreenWidth-13-frame.size.width {
                        frame.origin.x = MainScreenWidth-13-frame.size.width;
                    }
                }
                if touchLocation.y>78 && touchLocation.y<MainScreenWidth+52 {
                    frame.origin.y = frame.origin.y + touchLocation.y - self.beginPoint.y;
                    if frame.origin.y < 78{
                        frame.origin.y = 78;
                    } else if frame.origin.y > MainScreenWidth+52-frame.size.height{
                        frame.origin.y = MainScreenWidth+52-frame.size.height;
                    }
                }
                self.itemView.frame = frame;
                self.beginPoint = touchLocation;
            }
        }
    }
    
    
    func inputBar(inputBar: YFInputBar!, sendBtnPress sendBtn: UIButton!, withInputString str: String!) {
        if str == "" {
            SVProgressHUD.showImage(nil, status: "内容不能为空")
            return;
        }
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        let frame = self.itemView.frame;
        let position_x = (frame.origin.x-13)/(MainScreenWidth-26);
        let position_y = (frame.origin.y-78)/(MainScreenWidth-26);
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.showModel.xiu_id,str,"\(position_x)","\(position_y)"] , forKeys: [MEMBER_ID,"xiu_id","info","position_x","position_y"]);
        NSHttpHelp.httpHelpWithUrlTpye(addCommentType, withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let code = result["code"] as! NSInteger;
            if code == 0 {
                SVProgressHUD.dismiss();
                let comment = NSXiuComment()
                comment.position_x = position_x;
                comment.position_y = position_y;
                comment.info = str;
                comment.member_avar = NSUserInfo.shareInstance().member_avar;
                self.showModel.commends.addObject(comment);
                if self.from == 0 {
                    mainTabBar.showView.reloadTableViewData();
                } else {
                    reloadDataForAddNewDou = true;
                }
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            } else {
                let datas = result["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
        }
    }
    func textFieldDidChanged(notification:NSNotification){
        itemView.contentLabel.text = inputBar.textField.text;
        let size = itemView.contentLabel.sizeThatFits(CGSizeMake(100, 100));
        var frame = itemView.frame;
        frame.size.width = size.width+48;
        frame.size.height = size.height+16<30 ? 30 : size.height+16;
        itemView.frame = frame;
        itemView.setNeedsLayout()
    }
    
    @IBAction func unloadViewController(sender: UITapGestureRecognizer) {
        self.inputBar.textField.resignFirstResponder();
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
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
