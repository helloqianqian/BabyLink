//
//  UIForgetPWViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIForgetPWViewController: UIBaseViewController {
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "重置密码";
        self.setUI();
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
        
    }
    @IBAction func resetPWConfirm(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
