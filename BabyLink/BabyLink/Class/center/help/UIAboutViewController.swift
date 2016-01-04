//
//  UIAboutViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/12/18.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIAboutViewController: UIBaseViewController {
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!

    @IBOutlet weak var right: NSLayoutConstraint!
    @IBOutlet weak var left: NSLayoutConstraint!
    @IBOutlet weak var contentText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "关于我们"
        if iphone4 {
            width.constant = 80;
            height.constant = 80;
            
            right.constant = 5;
            left.constant = 5;
            contentText.font = UIFont.systemFontOfSize(13);
        }
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
