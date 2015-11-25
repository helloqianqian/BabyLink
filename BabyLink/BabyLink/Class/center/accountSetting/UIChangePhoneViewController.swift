//
//  UIChangePhoneViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/12.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIChangePhoneViewController: UIBaseViewController {

    @IBOutlet weak var newPhoneNumField: UITextField!
    @IBOutlet weak var vertifyCodeField: UITextField!
    @IBOutlet weak var sendVertifyBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!

    var seconds = 60;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "更换手机号"
        
        confirmBtn.makeBackGroundColor_Red();
        sendVertifyBtn.makeBackGroundColor_Green();
    }

    @IBAction func sendVertify(sender: UIButton) {
        if !NSHelper.checkUserPhoneValidateWith(self.newPhoneNumField.text) {
            NSHelper.showAlertViewWithTip("请输入正确的手机号");
            return;
        }
        if self.vertifyCodeField.text == ""{
            NSHelper.showAlertViewWithTip("请输入验证码");
            return;
        }
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.newPhoneNumField.text!,self.vertifyCodeField.text!] , forKeys: [MEMBER_ID,MOBILE,"code"]);
        NSHttpHelp.httpHelpWithUrlTpye(updateMobileType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("修改成功")
                NSUserInfo.shareInstance().mobile = self.newPhoneNumField.text;
                appDelegate.recordLastUserMobile()
                self.navigationController?.popViewControllerAnimated(true);
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
        
    }
    @IBAction func sendNewPhoneNum(sender: UIButton) {
        if !NSHelper.checkUserPhoneValidateWith(self.newPhoneNumField.text) {
            NSHelper.showAlertViewWithTip("请输入正确的手机号");
            return;
        }
        sendVertifyBtn.enabled = false;
        self.startTimer()
        SVProgressHUD.showWithStatus("正在发送验证码")
        let dicParam:NSDictionary = NSDictionary(objects: [self.newPhoneNumField.text!] , forKeys: ["mobile"]);
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
            sendVertifyBtn.setTitle("\(seconds)s", forState: UIControlState.Normal);
            seconds--;
        } else {
            timer.invalidate();
            seconds = 60;
            sendVertifyBtn.enabled = true;
            sendVertifyBtn.setTitle("发送验证码", forState: UIControlState.Normal);
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
