//
//  UIJoinViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIJoinViewController: UIBaseViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var numField: UITextField!
    @IBOutlet weak var commitBtn: UIButton!
    
    var activityID:String!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我要报名"
        self.setUI();
    }

    func setUI(){
        backView.layer.cornerRadius = 5;
        backView.layer.borderColor = SGrayBorderColor.CGColor;
        backView.layer.borderWidth = 0.5;
        commitBtn.makeBackGroundColor_Red()
        
        nameField.delegate = self;
        phoneField.delegate = self;
        numField.delegate = self;
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
        NSHttpHelp.httpHelpWithUrlTpye(actJoinedType, withParam: dicParam, withResult: { (result:AnyObject!) -> Void in
            let dic = result as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                activityListLoad = true;
                activityInfoLoad = true;
                
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
