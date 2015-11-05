//
//  UIBaseNavViewController.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/26.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

class UIBaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        UINavigationBar.appearance().setBackgroundImage(self.imageWithColor(hexRGB(0xE64871), withSize: CGSizeMake(MainScreenWidth, 1)), forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().shadowImage = self.imageWithColor(UIColor.clearColor(), withSize: CGSizeMake(MainScreenWidth, 1))
        
        self.navigationBar.tintColor = UIColor.whiteColor()
        //设置标题颜色
        let titleAtt = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont.systemFontOfSize(17)]
        self.navigationBar.titleTextAttributes = titleAtt
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func imageWithColor(color:UIColor,withSize size:CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context,
            color.CGColor);
        CGContextFillRect(context, rect);
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
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
