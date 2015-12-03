//
//  UIForgetPWViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIForgetPWViewController: UIBaseViewController ,UITextFieldDelegate{
    @IBOutlet weak var backView1: UIView!
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var backView3: UIView!
    @IBOutlet weak var backView4: UIView!

    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var verticalNum: UITextField!
    @IBOutlet weak var getVerticalBtn: UIButton!
    @IBOutlet weak var newKey: UITextField!
    @IBOutlet weak var confirmNewKey: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var seconds = 60;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "重置密码";
        self.setUI();
        
        confirmNewKey.delegate = self;
        newKey.delegate = self;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }

    func setUI(){
        self.backView1.layer.borderColor = SGrayBorderColor.CGColor;
        self.backView1.layer.cornerRadius = 5;
        self.backView1.layer.borderWidth = 0.5;
        
        self.backView2.layer.borderColor = SGrayBorderColor.CGColor;
        self.backView2.layer.cornerRadius = 5;
        self.backView2.layer.borderWidth = 0.5;
        
        self.backView3.layer.borderColor = SGrayBorderColor.CGColor;
        self.backView3.layer.cornerRadius = 5;
        self.backView3.layer.borderWidth = 0.5;
        
        self.backView4.layer.borderColor = SGrayBorderColor.CGColor;
        self.backView4.layer.cornerRadius = 5;
        self.backView4.layer.borderWidth = 0.5;
        
        getVerticalBtn.makeBackGroundColor_Green();
        confirmBtn.makeBackGroundColor_Red();
    }
    
    @IBAction func getVerticalNum(sender: AnyObject) {
        if !NSHelper.checkUserPhoneValidateWith(self.phoneNum.text) {
            NSHelper.showAlertViewWithTip("请输入正确的手机号");
            return;
        }
        getVerticalBtn.enabled = false;
        self.startTimer()
        SVProgressHUD.showWithStatus("正在发送验证码")
        let dicParam:NSDictionary = NSDictionary(objects: [self.phoneNum.text!] , forKeys: ["mobile"]);
        NSHttpHelp.httpHelpWithUrlTpye(verticalCodeType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("验证码发送成功")
            } else {
                //发送失败
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                //发送失败
        };
    }
    func startTimer() {
        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerFunction:", userInfo: nil, repeats: true);
        timer.fire();
    }
    
    func timerFunction(timer:NSTimer){
        if seconds>=0{
            getVerticalBtn.setTitle("\(seconds)s", forState: UIControlState.Normal);
            seconds--;
        } else {
            timer.invalidate();
            seconds = 60;
            getVerticalBtn.enabled = true;
            getVerticalBtn.setTitle("发送验证码", forState: UIControlState.Normal);
        }
    }
    
    @IBAction func resetPWConfirm(sender: AnyObject) {
        if !NSHelper.checkUserPhoneValidateWith(self.phoneNum.text) {
            NSHelper.showAlertViewWithTip("请输入正确的手机号");
            return;
        }
        if self.verticalNum.text == ""{
            NSHelper.showAlertViewWithTip("请输入验证码");
            return;
        }
        if self.newKey.text == "" {
            NSHelper.showAlertViewWithTip("请输入密码");
            return;
        }
        if self.confirmNewKey.text == "" {
            NSHelper.showAlertViewWithTip("请输入确认密码");
            return;
        }
        if self.newKey.text != self.confirmNewKey.text {
            NSHelper.showAlertViewWithTip("两次密码输入不一致");
            return;
        }
        let dicParam:NSDictionary = NSDictionary(objects: [self.phoneNum.text!,self.verticalNum.text!,self.newKey.text!] , forKeys: ["mobile","code","password"]);
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear)
        NSHttpHelp.httpHelpWithUrlTpye(forgetPswType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("修改成功")
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                //发送失败
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func nextFieldEditing(textField: UITextField) {
        super.nextFieldEditing(textField)
        self.confirmNewKey.becomeFirstResponder();
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
