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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "修改昵称"
        
        confirmBtn.makeBackGroundColor_Red();
    }

    @IBAction func changeNickname(sender: UIButton) {
        
        
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
