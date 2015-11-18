//
//  UISecondInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UISecondInfoViewController: UIBaseViewController {

    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var backView1: UIView!
    @IBOutlet weak var relationField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var relationBtn: UIButton!
    @IBOutlet weak var birthdayBtn: UIButton!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "完善资料"
        self.setUI();
    }

    func setUI() {
        self.backView1.layer.borderColor = SGrayBorderColor.CGColor;
        self.backView1.layer.cornerRadius = 5;
        self.backView1.layer.borderWidth = 0.5;
        
        self.backView2.layer.borderColor = SGrayBorderColor.CGColor;
        self.backView2.layer.cornerRadius = 5;
        self.backView2.layer.borderWidth = 0.5;
        
        confirmBtn.makeBackGroundColor_Red();
        self.nicknameField.delegate = self;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseTheSex(sender: AnyObject) {
    }
    @IBAction func commitTheInfo(sender: AnyObject) {
    }

    @IBAction func chooseBirthdayTap(sender: UITapGestureRecognizer) {
    }
    @IBAction func chooseRelationShipTap(sender: UITapGestureRecognizer) {
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
