//
//  UIChangePSWViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/12.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIChangePSWViewController: UIBaseViewController {

    @IBOutlet weak var oldPSWField: UITextField!
    @IBOutlet weak var newPSWField: UITextField!
    @IBOutlet weak var reNewPSWField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        confirmBtn.makeBackGroundColor_Red();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changePSW(sender: UIButton) {
        
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
