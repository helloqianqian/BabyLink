//
//  UIJoinViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIJoinViewController: UIBaseViewController ,UITextFieldDelegate{

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var numField: UITextField!
    @IBOutlet weak var commitBtn: UIButton!
    
    var activityID:String!;
    var actModel:NSActInfoObject!
    var from = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我要报名"
        self.setUI();
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }

    func setUI(){
        backView.layer.cornerRadius = 5;
        backView.layer.borderColor = SGrayBorderColor.CGColor;
        backView.layer.borderWidth = 0.5;
        commitBtn.makeBackGroundColor_Red()
        
        nameField.delegate = self;
        phoneField.delegate = self;
        numField.delegate = self;
        
        nameField.text = NSUserInfo.shareInstance().member_name;
        phoneField.text = NSUserInfo.shareInstance().mobile;
        let left = (self.actModel.max_man as NSString).intValue - (self.actModel.count as NSString).intValue
        numField.placeholder = "请输入报名人数(已剩名额:\(left)人)"
    }
    @IBAction func submitJoinInfo(sender: UIButton) {
        if nameField.text == "" {
            NSHelper.showAlertViewWithTip("请输入姓名")
            return;
        }
        if phoneField.text == "" {
            NSHelper.showAlertViewWithTip("请输入联系方式")
            return;
        }
        if numField.text == "" {
            NSHelper.showAlertViewWithTip("请输入报名人数")
            return;
        }
        SVProgressHUD.showWithStatus("正在提交数据")
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.nameField.text!,self.phoneField.text!,self.numField.text!,self.activityID] , forKeys: [MEMBER_ID,MEMBER_NAME,"member_mobile","num","activity_id"]);
        NSHttpHelp.httpHelpWithUrlTpye(signInActType, withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                activityListLoad = true;
                activityInfoLoad = true;
                signInActivity = true;
                if self.from == 2 {
                    reloadMyJoinActList = true;
                }
                SVProgressHUD.showSuccessWithStatus("报名成功")
                self.navigationController?.popViewControllerAnimated(true);
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        }
    }
    
    override func nextFieldEditing(textField: UITextField) {
        if textField == nameField {
            phoneField.becomeFirstResponder();
        } else {
            numField.becomeFirstResponder();
        }
    }
    func keyboardWillShow(notification:NSNotification){
        self.addGesture();
    }
    func keyboardWillHide(notification:NSNotification){
        self.removeGesture();
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        self.didBeginEditing(textField);
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.didEndEditing(textField);
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == UIReturnKeyType.Next {
            self.nextFieldEditing(textField);
        } else if textField.returnKeyType == UIReturnKeyType.Done {
            textField.resignFirstResponder()
        }
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
