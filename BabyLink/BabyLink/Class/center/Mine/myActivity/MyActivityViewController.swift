//
//  MyActivityViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/13.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class MyActivityViewController: UIBaseViewController {

    @IBOutlet weak var myListBtn: UIButton!
    @IBOutlet weak var otherListBtn: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的活动"
        myListBtn.makeBackGroundColor_PurpleSelected();
        otherListBtn.makeBackGroundColor_PurpleSelected();
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func otherlist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            myListBtn.selected = false;
        }
        
        
    }
    @IBAction func mylist(sender: UIButton) {
        if !sender.selected {
            sender.selected = true
            otherListBtn.selected = false;
        }
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
