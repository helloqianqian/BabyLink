//
//  UIEnterViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIEnterViewController: UIBaseViewController {

    @IBOutlet weak var enterBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        enterBtn.layer.cornerRadius = 15.0;
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func enter(sender: AnyObject) {
//        let infoVC = UIFullInfoViewController(nibName:"UIFullInfoViewController",bundle:NSBundle.mainBundle());
//        self.navigationController?.pushViewController(infoVC, animated: true);
        let loginVC = UILoginViewController(nibName:"UILoginViewController", bundle:NSBundle.mainBundle())
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func agreement(sender: AnyObject) {
        let agreementVC = UIAgreementViewController(nibName:"UIAgreementViewController", bundle:NSBundle.mainBundle());
        self.navigationController?.pushViewController(agreementVC, animated: true);
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
