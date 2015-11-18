//
//  UIFullInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFullInfoViewController: UIBaseViewController {

    @IBOutlet weak var backView3: UIView!
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var backView1: UIView!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var neighboorField: UITextField!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var neighborBtn: UIButton!
    
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var relationField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var relationBtn: UIButton!
    @IBOutlet weak var birthdayBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "完善资料"
        self.navigationItem.hidesBackButton = true;
        
        self.setUI();
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
        
        confirmBtn.makeBackGroundColor_Red();
        nicknameField.delegate = self;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseTheSex(sender: AnyObject) {
    }

    @IBAction func commitTheInfo(sender: AnyObject) {
    }
    
    @IBAction func chooseCityTap(sender: UITapGestureRecognizer) {
        NSLog("11111")
    }
    @IBAction func chooseAddressTap(sender: UITapGestureRecognizer) {
        NSLog("2222")
    }
    
    @IBAction func chooseBabyBirthday(sender: UITapGestureRecognizer) {
        NSLog("33333")
    }
    @IBAction func chooseTheRelationShip(sender: UITapGestureRecognizer) {
        NSLog("44444")
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
