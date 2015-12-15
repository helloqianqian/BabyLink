//
//  UIInfoViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/23.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIInfoViewController: UIBaseViewController {

    @IBOutlet weak var content: UITextView!
    
    var type = 0;
    var contentStr = "";
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if type == 0 {
            self.title = "置换详情"
            self.content.text = contentStr;
        } else {
            
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
