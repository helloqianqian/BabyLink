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
    @IBOutlet weak var webview: UIWebView!
    var type = 0;
    var contentStr = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if type == 0 {
            self.title = "置换详情"
            self.webview.hidden = true;
            self.content.text = contentStr;
        } else if type == 1 {
            self.content.hidden = true;
            self.title = "商品详情"
            self.webview.loadHTMLString(self.contentStr, baseURL: nil);
        } else if type == 2 {
            self.title = "详情"
            self.content.hidden = true;
            let url = NSURL(string: self.contentStr);
            let request = NSURLRequest(URL: url!);
            self.webview.loadRequest(request);
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
