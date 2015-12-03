//
//  UIFullInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFullInfoViewController: UIBaseViewController ,UIOptionViewDelegate ,UITextFieldDelegate{

    @IBOutlet weak var backView3: UIView!
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var backView1: UIView!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var neighboorField: UITextField!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var neighborBtn: UIButton!
    
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var relationField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var relationBtn: UIButton!
    @IBOutlet weak var birthdayBtn: UIButton!
    
    var location2D:CLLocationCoordinate2D!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "完善资料"
        self.navigationItem.hidesBackButton = true;
        
        self.setUI();
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
        
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
        
        confirmBtn.makeBackGroundColor_Red();
        nicknameField.delegate = self;
    }
    
    func updateLocation(){
        
        CCLocationManager.shareLocation().getCity({ (city:String!) -> Void in
//            self.cityField.text = city;
            }) { (location:CLLocationCoordinate2D) -> Void in
                self.location2D = location;
                self.getCityData()
                //http://127.0.0.1/babyLink/mobile.php/Mobile/Index/getCity
        }
    }
    
    func getCityData(){
        let dicParam:NSDictionary = NSDictionary(objects: [self.location2D.latitude,self.location2D.longitude] , forKeys: ["la","lo"]);
        SVProgressHUD.showWithStatus("正在提交信息")
        NSHttpHelp.httpHelpWithUrlTpye(getCityType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                self.cityField.text = dic["datas"] as? String;
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
    
    @IBAction func chooseTheSex(sender: UIButton) {
        sender.selected = true;
        if sender == femaleBtn {
            maleBtn.selected = false;
        } else {
            femaleBtn.selected = false;
        }
    }

    @IBAction func commitTheInfo(sender: UIButton) {
        
        if self.cityField.text == "" {
            NSHelper.showAlertViewWithTip("城市定位失败，点击重新定位");
            return;
        }
        if self.neighboorField.text == "" {
            NSHelper.showAlertViewWithTip("请选择您所在的小区");
            return;
        }
        if self.nicknameField.text == "" {
            NSHelper.showAlertViewWithTip("请输入您宝贝的昵称或者名字");
            return;
        }
        
        var sex = "0";
        if !femaleBtn.selected && !maleBtn.selected {
            NSHelper.showAlertViewWithTip("请选择您宝贝的性别");
            return;
        } else if (femaleBtn.selected){
            sex = "1";
        }
        
        if birthdayField.text == "" {
            NSHelper.showAlertViewWithTip("请设置您宝贝的生日");
            return;
        }
        if relationField.text == "" {
            NSHelper.showAlertViewWithTip("请选择您和宝贝的关系");
            return;
        }
        let dicParam:NSDictionary = NSDictionary(objects: [self.cityField.text!,self.neighboorField.text!,sex,self.nicknameField.text!,self.birthdayField.text!,self.relationField.text!,NSUserInfo.shareInstance().member_id] , forKeys: ["city","home","baby_sex","baby_nam","baby_date","baby_link","member_id"]);
        SVProgressHUD.showWithStatus("正在提交信息")
        NSHttpHelp.httpHelpWithUrlTpye(perfectType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("提交成功")
                NSUserInfo.shareInstance().islogin = true;
                NSUserInfo.shareInstance().home = self.neighboorField.text;
                NSUserInfo.shareInstance().baby_sex = sex;
                NSUserInfo.shareInstance().city = self.cityField.text;
                NSUserInfo.shareInstance().baby_nam = self.nicknameField.text;
                NSUserInfo.shareInstance().baby_link = self.relationField.text;
                NSUserInfo.shareInstance().baby_date = self.birthdayField.text;

                appDelegate.recordLastLoginUser();
                appDelegate.exchangeRootViewController(true)
            } else {
                //发送失败
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
        
        
    }
    
    @IBAction func setBabyBirthday(sender: UIButton) {
        self.nicknameField.resignFirstResponder();
        let optionView = NSBundle.mainBundle().loadNibNamed("UIOptionView", owner: nil, options: nil).first as! UIOptionView;
        optionView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight);
        optionView.delegate = self;
        optionView.changeDataSource(DataType.birthday);
        self.navigationController?.view.addSubview(optionView);
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            optionView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
            }) { (finish:Bool) -> Void in
        }
    }
    
    @IBAction func setRelationShip(sender: UIButton) {
        self.nicknameField.resignFirstResponder();
        let optionView = NSBundle.mainBundle().loadNibNamed("UIOptionView", owner: nil, options: nil).first as! UIOptionView;
        optionView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight);
        optionView.delegate = self;
        optionView.changeDataSource(DataType.range);
        self.navigationController?.view.addSubview(optionView);
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            optionView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
            }) { (finish:Bool) -> Void in
        }
    }
    @IBAction func reloadCity(sender: UIButton) {
        self.updateLocation();
    }
    
    @IBAction func setNeighboor(sender: UIButton) {
        if self.cityField.text == "" {
            NSHelper.showAlertViewWithTip("城市定位失败，点击重新定位");
            return;
        }
        let neighbourVC = UIChooseAddressViewController(nibName:"UIChooseAddressViewController" ,bundle: NSBundle.mainBundle());
        neighbourVC.lastVC = self;
        neighbourVC.location2D = self.location2D;
        neighbourVC.city = self.cityField.text;
        self.navigationController?.pushViewController(neighbourVC, animated: true);
    }
    
    func didSelectedRow(row: Int, forComponent component: Int) {
        
    }
    func didRemoveFromSuperView(object: AnyObject, dataType type: DataType) {
        if type == DataType.birthday {
            let array = object as! NSArray;
            birthdayField.text = "\(array[0])-\(array[1])-\(array[2])";
        } else {
            relationField.text = object as? String;
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
