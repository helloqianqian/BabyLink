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
    
    var snsAccount:UMSocialAccountEntity! = UMSocialAccountEntity();
    
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
        self.endEditing()
        let dicParam:NSDictionary = NSDictionary(objects: [self.phoneField.text!,self.pswField.text!] , forKeys: ["mobile","password"]);
        SVProgressHUD.showWithStatus("正在登录")
        NSHttpHelp.httpHelpWithUrlTpye(loginType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                
                let datas = dic["datas"] as! NSDictionary;
                let home = datas["home"] as! String;
                
                
                NSUserInfo.shareInstance().member_id = datas["member_id"] as! String;
                NSUserInfo.shareInstance().member_name = datas["member_name"] as! String;
                NSUserInfo.shareInstance().member_avar = datas["member_avar"] as! String;
                NSUserInfo.shareInstance().password = datas["password"] as! String;
                NSUserInfo.shareInstance().passwordLocal = self.pswField.text;
                NSUserInfo.shareInstance().mobile = self.phoneField.text;
                NSUserInfo.shareInstance().home = home;
                NSUserInfo.shareInstance().add_time = datas["add_time"] as! String;
                NSUserInfo.shareInstance().login_time = datas["login_time"] as! String;
                NSUserInfo.shareInstance().baby_sex = datas["baby_sex"] as! String;
                NSUserInfo.shareInstance().city = datas["city"] as! String;
                NSUserInfo.shareInstance().baby_nam = datas["baby_nam"] as! String;
                NSUserInfo.shareInstance().baby_link = datas["baby_link"] as! String;
                NSUserInfo.shareInstance().baby_date = datas["baby_date"] as! String;
                NSUserInfo.shareInstance().position = datas["position"] as! String;
                NSUserInfo.shareInstance().openid = datas["openid"] as! String;
                
                if home == "" {
                    SVProgressHUD.dismiss();
                    NSUserInfo.shareInstance().islogin = false;
                    let infoVC = UIFullInfoViewController.init(nibName:"UIFullInfoViewController",bundle:NSBundle.mainBundle());
                    self.navigationController?.pushViewController(infoVC, animated: true);
                } else {
                    SVProgressHUD.showSuccessWithStatus("登录成功")
                    NSUserInfo.shareInstance().islogin = true;
                    
                    appDelegate.recordLastLoginUser();
                    appDelegate.exchangeRootViewController(true)
                }
            } else {
                //发送失败
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
    }
    
    @IBAction func forgetPWEnter(sender: AnyObject) {
        
        let forgetPWVC = UIForgetPWViewController.init(nibName:"UIForgetPWViewController", bundle:NSBundle.mainBundle());
        self.navigationController?.pushViewController(forgetPWVC, animated: true);
    }
    
    @IBAction func loginFromSinaEnter(sender: AnyObject) {
        let snsPlatform : UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina);
        snsPlatform.loginClickHandler(self, UMSocialControllerService.defaultControllerService(), true, {response in
            
            if response.responseCode == UMSResponseCodeSuccess {
                
                let snsAccount:UMSocialAccountEntity = UMSocialAccountManager.socialAccountDictionary()[UMShareToSina] as! UMSocialAccountEntity
                
                print("username is \(snsAccount.userName), uid is \(snsAccount.usid), token is \(snsAccount.accessToken) url is \(snsAccount.iconURL)")
                self.otherLogin()
            } else {
                
            }
        })
    }
    @IBAction func loginFromQQEnter(sender: AnyObject) {
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToQQ);
        snsPlatform.loginClickHandler(self,UMSocialControllerService.defaultControllerService(),true,{response in
            if response.responseCode == UMSResponseCodeSuccess {
                let snsAccount:UMSocialAccountEntity = UMSocialAccountManager.socialAccountDictionary()[UMShareToQQ] as! UMSocialAccountEntity
                self.snsAccount = snsAccount;
                print("username is \(snsAccount.userName), uid is \(snsAccount.usid), token is \(snsAccount.accessToken) ,url is \(snsAccount.iconURL)")
                self.otherLogin()
            } else {
                
            }
            
        })
        
        
    }
    
    @IBAction func loginFromWeiXinEnter(sender: AnyObject) {
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession);
        snsPlatform.loginClickHandler(self,UMSocialControllerService.defaultControllerService(),true,{response in
            if response.responseCode == UMSResponseCodeSuccess {
                let snsAccount:UMSocialAccountEntity = UMSocialAccountManager.socialAccountDictionary()[UMShareToWechatSession] as! UMSocialAccountEntity;
                self.snsAccount = snsAccount;
                NSLog("username is %@, uid is %@, token is %@ url is %@  openid:%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL,snsAccount.openId);
                self.otherLogin();
            } else {
                
            }
        })
        
    }
    
    
    func otherLogin(){
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        NSUserInfo.shareInstance().openid = self.snsAccount.openId;
        NSUserInfo.shareInstance().member_name = self.snsAccount.userName;
        NSUserInfo.shareInstance().member_avar = self.snsAccount.iconURL;
        let dicParam:NSDictionary = NSDictionary(objects: [self.snsAccount.openId] , forKeys: ["openid"]);
        NSHttpHelp.httpHelpWithUrlTpye(otherLoginType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("登录成功")
                
                let datas = dic["datas"] as! NSDictionary;
                
                NSUserInfo.shareInstance().member_id = datas["member_id"] as! String;
                NSUserInfo.shareInstance().member_name = datas["member_name"] as! String;
                NSUserInfo.shareInstance().member_avar = datas["member_avar"] as! String;
                NSUserInfo.shareInstance().password = datas["password"] as! String;
                NSUserInfo.shareInstance().passwordLocal = self.pswField.text;
                NSUserInfo.shareInstance().mobile = self.phoneField.text;
                NSUserInfo.shareInstance().home = datas["home"] as! String;
                NSUserInfo.shareInstance().add_time = datas["add_time"] as! String;
                NSUserInfo.shareInstance().login_time = datas["login_time"] as! String;
                NSUserInfo.shareInstance().baby_sex = datas["baby_sex"] as! String;
                NSUserInfo.shareInstance().city = datas["city"] as! String;
                NSUserInfo.shareInstance().baby_nam = datas["baby_nam"] as! String;
                NSUserInfo.shareInstance().baby_link = datas["baby_link"] as! String;
                NSUserInfo.shareInstance().baby_date = datas["baby_date"] as! String;
                NSUserInfo.shareInstance().position = datas["position"] as! String;
                NSUserInfo.shareInstance().openid = datas["openid"] as! String;
                NSUserInfo.shareInstance().islogin = true;
                
                appDelegate.recordLastLoginUser();
                appDelegate.exchangeRootViewController(true)
                
            } else if code == 1 {
                //需要完善资料
                SVProgressHUD.dismiss();
                let firstVC = UIFirstInfoViewController(nibName:"UIFirstInfoViewController" ,bundle: NSBundle.mainBundle())
                self.navigationController?.pushViewController(firstVC, animated: true);
            } else {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
