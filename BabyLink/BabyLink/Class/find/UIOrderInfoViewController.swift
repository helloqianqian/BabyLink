//
//  UIOrderInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/9.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIOrderInfoViewController: UIBaseViewController {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var centerNameLabel: UILabel!
    @IBOutlet weak var preMoneyLabel: UILabel!
    
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var payNumber: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var continuePayBtn: UIButton!
    @IBOutlet weak var payBackBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        topView.layer.borderWidth = 0.5;
        
        nextView.layer.borderColor = hexRGB(0xACACB4).CGColor;
        nextView.layer.borderWidth = 0.5;
        
        continuePayBtn.makeBackGroundColor_Purple()
        payBackBtn.makeBackGroundColor_Gray();
        
        
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
