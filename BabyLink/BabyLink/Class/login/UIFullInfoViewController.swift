//
//  UIFullInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIFullInfoViewController: UIBaseViewController {

    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var relateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "完善资料"
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
