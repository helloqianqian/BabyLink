//
//  UIAccountSetViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/11.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIAccountSetViewController: UIBaseViewController {

    @IBOutlet weak var headIconBtn: UIButton!
    @IBOutlet weak var bigHeadIconBtn: UIButton!
    @IBOutlet weak var nickNameBtn: UIButton!
    @IBOutlet weak var nikeName: UILabel!
    @IBOutlet weak var phoneNumBtn: UIButton!
    @IBOutlet weak var passwordBtn: UIButton!
    @IBOutlet weak var quiteBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bigHeadIconBtn.layer.cornerRadius = 30;
        bigHeadIconBtn.backgroundColor = UIColor.redColor();
        bigHeadIconBtn.layer.masksToBounds = true;
        
        headIconBtn.makeBackGroundColor_White();
        nickNameBtn.makeBackGroundColor_White();
        phoneNumBtn.makeBackGroundColor_White();
        passwordBtn.makeBackGroundColor_White();
        quiteBtn.makeBackGroundColor_Red();
    }
    @IBAction func exchangeHeadIcon(sender: UIButton) {
    }
    @IBAction func changeNikeName(sender: UIButton) {
        let nicknameVC = UINikenameViewController(nibName:"UINikenameViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(nicknameVC, animated: true);
    }
    @IBAction func changePhoneNum(sender: UIButton) {
        let nicknameVC = UIChangePhoneViewController(nibName:"UIChangePhoneViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(nicknameVC, animated: true);
    }
    @IBAction func changePassword(sender: UIButton) {
        let nicknameVC = UIChangePSWViewController(nibName:"UIChangePSWViewController" ,bundle: NSBundle.mainBundle());
        self.navigationController?.pushViewController(nicknameVC, animated: true);
    }
    @IBAction func quite(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.exchangeRootViewController(false)
    }
    
    @IBAction func checkBigHeadImage(sender: UIButton) {
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
