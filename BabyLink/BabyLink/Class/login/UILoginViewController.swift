//
//  UILoginViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UILoginViewController: UIBaseViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var pswField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "登录"
        let rightBarItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "registEnter:")
        self.navigationItem.rightBarButtonItem = rightBarItem
    
        
        self.setUI();
    }
    
    func setUI(){
        backView.layer.cornerRadius = 5;
        backView.layer.borderColor = SGrayBorderColor.CGColor;
        backView.layer.borderWidth = 0.5;
        loginBtn.makeBackGroundColor_Red()
        
        phoneField.delegate = self;
        pswField.delegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func registEnter(sender:AnyObject){
        let registVC = UIRegistViewController.init(nibName:"UIRegistViewController", bundle:NSBundle.mainBundle());
        self.navigationController?.pushViewController(registVC, animated: true);
    }
    @IBAction func loginConfirm(sender: UIButton) {
        if !NSHelper.checkUserPhoneValidateWith(self.phoneField.text) {
            NSHelper.showAlertViewWithTip("请输入正确的手机号");
            return;
        }
        if self.pswField.text == ""{
            NSHelper.showAlertViewWithTip("请输入密码");
            return;
        }
        
        let dicParam:NSDictionary = NSDictionary(objects: [self.phoneField.text!,self.pswField.text!] , forKeys: ["mobile","password"]);
        SVProgressHUD.showWithStatus("正在登录")
        NSHttpHelp.httpHelpWithUrlTpye(loginType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("登录成功")
                /*"add_time" = 1447896476;
                "baby_date" = "";
                "baby_link" = "";
                "baby_nam" = "";
                "baby_sex" = 0;
                city = "";
                home = "";
                "login_time" = 1447984979;
                "member_avar" = "";
                "member_id" = 4;
                "member_name" = 18032090731;
                mobile = 18032090731;
                openid = "";
                password = 343b1c4a3ea721b2d640fc8700db0f36;
                position = "";
                };*/
                let datas = dic["datas"] as! NSDictionary;
                let home = datas["home"] as! String;
                
                let userDefault = NSUserDefaults.standardUserDefaults()
                NSUserInfo.shareInstance().member_id = datas["member_id"] as! NSInteger;
                NSUserInfo.shareInstance().member_name = datas["member_name"] as! String;
                NSUserInfo.shareInstance().password = datas["password"] as! String;
                NSUserInfo.shareInstance().passwordLocal = self.pswField.text;
                NSUserInfo.shareInstance().mobile = self.phoneField.text;
                NSUserInfo.shareInstance().home = home;
                NSUserInfo.shareInstance().islogin = false;
                if home == "" {
                    userDefault.setBool(false, forKey: ISLOGIN)
                    
                    let infoVC = UIFullInfoViewController.init(nibName:"UIFullInfoViewController",bundle:NSBundle.mainBundle());
                    self.navigationController?.pushViewController(infoVC, animated: true);
                } else {
                    NSUserInfo.shareInstance().add_time = datas["add_time"] as! String;
                    NSUserInfo.shareInstance().login_time = datas["login_time"] as! String;
                    NSUserInfo.shareInstance().baby_sex = datas["baby_sex"] as! NSInteger;
                    
                    userDefault.setBool(true, forKey: ISLOGIN)
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.exchangeRootViewController(true)
                }

                userDefault.setObject(self.phoneField.text, forKey: MOBILE);
                userDefault.setObject(self.pswField.text, forKey: PASSWORDLocal);
                userDefault.setInteger(datas["member_id"] as! NSInteger, forKey: MEMBER_ID)
                userDefault.synchronize();

            } else {
                //发送失败
                let datas = dic["datas"] as! NSDictionary;
                SVProgressHUD.showErrorWithStatus(datas["error"] as! String);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
    }
    
    @IBAction func forgetPWEnter(sender: AnyObject) {
        
        let forgetPWVC = UIForgetPWViewController.init(nibName:"UIForgetPWViewController", bundle:NSBundle.mainBundle());
        self.navigationController?.pushViewController(forgetPWVC, animated: true);
    }
    
    @IBAction func loginFromSinaEnter(sender: AnyObject) {
    }
    @IBAction func loginFromQQEnter(sender: AnyObject) {
    }
    @IBAction func loginFromWeiXinEnter(sender: AnyObject) {
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
