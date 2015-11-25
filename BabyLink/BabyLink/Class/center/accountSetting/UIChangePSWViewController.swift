//
//  UIChangePSWViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/12.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIChangePSWViewController: UIBaseViewController {

    @IBOutlet weak var oldPSWField: UITextField!
    @IBOutlet weak var newPSWField: UITextField!
    @IBOutlet weak var reNewPSWField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "修改密码"
        self.setUI()
    }

    func setUI(){
        oldPSWField.delegate = self;
        newPSWField.delegate = self;
        reNewPSWField.delegate = self;
        confirmBtn.makeBackGroundColor_Red();
    }
    
    override func nextFieldEditing(textField: UITextField) {
        super.nextFieldEditing(textField);
        if textField == oldPSWField {
            newPSWField.becomeFirstResponder();
        } else {
            reNewPSWField.becomeFirstResponder();
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changePSW(sender: UIButton) {
        if self.oldPSWField.text == ""{
            NSHelper.showAlertViewWithTip("请输入旧密码");
            return;
        }
        if self.newPSWField.text == ""{
            NSHelper.showAlertViewWithTip("请输入新密码");
            return;
        }
        if self.reNewPSWField.text == ""{
            NSHelper.showAlertViewWithTip("请输入确认密码");
            return;
        }
        if self.newPSWField.text != self.reNewPSWField.text {
            NSHelper.showAlertViewWithTip("两次密码输入不一致");
            return;
        }
        
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.newPSWField.text!,self.oldPSWField.text!] , forKeys: [MEMBER_ID,"new_password","old_password"]);
        NSHttpHelp.httpHelpWithUrlTpye(updatePswType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("修改成功")
                NSUserInfo.shareInstance().passwordLocal = self.newPSWField.text;
                appDelegate.recordLastUserPSW()
                self.navigationController?.popViewControllerAnimated(true);
            }else {
                let datas = dic["datas"] as! String;
                SVProgressHUD.showErrorWithStatus(datas);
            }
            }) { (error:AnyObject!) -> Void in
                
        };
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
