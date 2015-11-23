//
//  UIFirstInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFirstInfoViewController: UIBaseViewController {

    @IBOutlet weak var backView1: UIView!
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var backView3: UIView!
    @IBOutlet weak var backView4: UIView!
    
    @IBOutlet weak var verticalBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var verticalField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var LocationBtn: UIButton!
    
    @IBOutlet weak var neighboorBtn: UIButton!
    @IBOutlet weak var neighboorField: UITextField!
    
    var location2D:CLLocationCoordinate2D!;
    var seconds = 60;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "完善资料"
        self.navigationItem.hidesBackButton = true;
        
        self.setUI();
        self.updateLocation();
    }
    func setUI() {
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
        
        verticalBtn.makeBackGroundColor_Green();
        nextBtn.makeBackGroundColor_Red();
        
        self.phoneNum.delegate = self;
        self.verticalField.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateLocation(){
        SVProgressHUD.showWithStatus("正在定位")
        CCLocationManager.shareLocation().getCity({ (city:String!) -> Void in
            SVProgressHUD.dismiss();
            self.locationField.text = city;
            self.LocationBtn.enabled = false;
            SVProgressHUD.dismiss();
            }) { (location:CLLocationCoordinate2D) -> Void in
                self.location2D = location;
        }
    }
    
    @IBAction func getVerticalNum(sender: AnyObject) {
        if !NSHelper.checkUserPhoneValidateWith(self.phoneNum.text) {
            NSHelper.showAlertViewWithTip("请输入正确的手机号");
            return;
        }
        verticalBtn.enabled = false;
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
            verticalBtn.setTitle("\(seconds)s", forState: UIControlState.Normal);
            seconds--;
        } else {
            timer.invalidate();
            seconds = 60;
            verticalBtn.enabled = true;
            verticalBtn.setTitle("发送验证码", forState: UIControlState.Normal);
        }
    }
    @IBAction func nextStep(sender: AnyObject) {
        if !NSHelper.checkUserPhoneValidateWith(self.phoneNum.text) {
            NSHelper.showAlertViewWithTip("请输入正确的手机号");
            return;
        }
        if self.verticalField.text == ""{
            NSHelper.showAlertViewWithTip("请输入验证码");
            return;
        }
        if self.locationField.text == "" {
            NSHelper.showAlertViewWithTip("城市定位失败，点击重新定位");
            return;
        }
        if self.neighboorField.text == "" {
            NSHelper.showAlertViewWithTip("请选择您所在的小区");
            return;
        }
        self.endEditing()
        let dicParam:NSDictionary = NSDictionary(objects: [self.phoneNum.text!,self.verticalField.text!,NSUserInfo.shareInstance().member_avar,NSUserInfo.shareInstance().member_name,NSUserInfo.shareInstance().openid] , forKeys: ["mobile","code","member_avar","member_name","openid"]);
        SVProgressHUD.showWithStatus("正在提交信息")
        NSHttpHelp.httpHelpWithUrlTpye(registerType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("提交成功")
                let datas = dic["datas"] as! String;
                NSUserInfo.shareInstance().member_id = datas;
                NSUserInfo.shareInstance().mobile = self.phoneNum.text;
                NSUserInfo.shareInstance().city = self.locationField.text;
                NSUserInfo.shareInstance().home = self.neighboorField.text;
        
                let secondVC = UISecondInfoViewController(nibName:"UISecondInfoViewController" ,bundle: NSBundle.mainBundle());
                self.navigationController?.pushViewController(secondVC, animated: true);
            } else {
                //发送失败
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
    }
    
    @IBAction func chooseNeighbor(sender: UIButton) {
        if self.locationField.text == "" {
            NSHelper.showAlertViewWithTip("城市定位失败，点击重新定位");
            return;
        }
        let neighbourVC = UIChooseAddressViewController(nibName:"UIChooseAddressViewController" ,bundle: NSBundle.mainBundle());
        neighbourVC.lastVC = self;
        neighbourVC.location2D = self.location2D;
        neighbourVC.city = self.locationField.text;
        self.navigationController?.pushViewController(neighbourVC, animated: true);
    }
    
    @IBAction func locationFailed(sender: UIButton) {
        self.updateLocation()
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
