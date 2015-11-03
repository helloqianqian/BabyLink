//
//  UILocalViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UILocalViewController: UIBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let titleView = NSBundle.mainBundle().loadNibNamed("UILocalNavigationView", owner: nil, options: nil).first as! UILocalNavigationView;
        titleView.selectedItem = 0;
        titleView.frame = CGRectMake(0, 0, MainScreenWidth, 44)
        self.navigationItem.titleView = titleView;
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
