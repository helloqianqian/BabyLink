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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.exchangeRootViewController(true)
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
