//
//  UIRegistViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIRegistViewController: UIBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registConfirm(sender: UIButton) {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.exchangeRootViewController(true)
        let infoVC = UIFullInfoViewController.init(nibName:"UIFullInfoViewController",bundle:NSBundle.mainBundle());
        self.navigationController?.pushViewController(infoVC, animated: true);
    }

    @IBAction func agreementEnter(sender: AnyObject) {
        let agreementVC = UIAgreementViewController.init(nibName:"UIAgreementViewController", bundle:NSBundle.mainBundle());
        self.navigationController?.pushViewController(agreementVC, animated: true);
    }
    @IBAction func getVerticalNum(sender: AnyObject) {
    
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
