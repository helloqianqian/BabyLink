//
//  UIFirstInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFirstInfoViewController: UIBaseViewController {

    @IBOutlet weak var backView1: UIView!
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var backView3: UIView!
    @IBOutlet weak var backView4: UIView!
    
    @IBOutlet weak var verticalBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var verticalField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var LocationBtn: UIButton!
    
    @IBOutlet weak var neighboorBtn: UIButton!
    @IBOutlet weak var neighboorField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "完善资料"
    }
    func setUI() {
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
        
        verticalBtn.makeBackGroundColor_Green();
        nextBtn.makeBackGroundColor_Red();
        
        self.phoneNum.delegate = self;
        self.verticalField.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getVerticalNum(sender: AnyObject) {
    }

    @IBAction func nextStep(sender: AnyObject) {
    }
    
    @IBAction func chooseNeighbor(sender: UIButton) {
    }
    
    @IBAction func locationFailed(sender: UIButton) {
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
