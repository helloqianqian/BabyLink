//
//  UIAgreementViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIAgreementViewController: UIBaseViewController {

    @IBOutlet weak var textview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "服务协议"
        
        
    }
//[UIDevice currentDevice].systemVersion.floatValue
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 9.0 {
            self.textview.setContentOffset(CGPointMake(0, 64), animated: false);
        }
//        NSLog("textview:\(self.textview.contentOffset.y)   \(self.textview.contentInset.top)")
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
