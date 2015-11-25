//
//  UINikenameViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/12.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UINikenameViewController: UIBaseViewController {

    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    var lastVC : UIAccountSetViewController!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "修改昵称"
        confirmBtn.makeBackGroundColor_Red();
        nicknameField.delegate = self;
    }

    @IBAction func changeNickname(sender: UIButton) {
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear);
        let dicParam:NSDictionary = NSDictionary(objects: [NSUserInfo.shareInstance().member_id,self.nicknameField.text!] , forKeys: [MEMBER_ID,MEMBER_NAME]);
        NSHttpHelp.httpHelpWithUrlTpye(updateNicknameType, withParam: dicParam, withResult: { (returnObject:AnyObject!) -> Void in
            let dic = returnObject as! NSDictionary;
            let code = dic["code"] as! NSInteger;
            if code == 0 {
                //发送成功
                SVProgressHUD.showSuccessWithStatus("修改成功")
                NSUserInfo.shareInstance().member_name = self.nicknameField.text;
                appDelegate.recordLastUserNickname()
                self.lastVC.nikeName.text = "昵称:\(NSUserInfo.shareInstance().member_name)"
                self.navigationController?.popViewControllerAnimated(true);
            }else {
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
