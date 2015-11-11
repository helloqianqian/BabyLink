//
//  UIPaymentViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/9.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIPaymentViewController: UIBaseViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var payTypeLabel: UILabel!
    @IBOutlet weak var payMoneyLabel: UILabel!
    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var weixinPay: UIButton!
    @IBOutlet weak var aliPay: UIButton!
    @IBOutlet weak var payBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        topView.layer.borderWidth = 0.5;
        
        nextView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        nextView.layer.borderWidth = 0.5;
        
        payBtn.makeBackGroundColor_Red();
    }

    @IBAction func weixinPaySelect(sender: UIButton) {
        
    }
    @IBAction func aliPaySelect(sender: UIButton) {
        
    }
    @IBAction func payNowFunction(sender: UIButton) {
        
        let orderVC = UIOrderInfoViewController(nibName:"UIOrderInfoViewController" ,bundle: NSBundle.mainBundle())
        self.navigationController?.pushViewController(orderVC, animated: true);
        
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
