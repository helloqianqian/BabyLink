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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavigationBarStyleDark(){
        var image = "";
        if iphone6Plus {
            image = "nav_dark_6p";
        } else if iphone6 {
            image = "nav_dark_6";
        } else {
            image = "nav_dark_5";
        }
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: image), forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().shadowImage = self.imageWithColor(UIColor.clearColor(), withSize: CGSizeMake(MainScreenWidth, 1))
        
        self.navigationBar.tintColor = UIColor.whiteColor()
        //设置标题颜色
        let titleAtt = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont.systemFontOfSize(17)]
        self.navigationBar.titleTextAttributes = titleAtt
    }
    
    func setNavigationBarStyleLight(){
        var image = "";
        if iphone6Plus {
            image = "nav_light_6p";
        } else if iphone6 {
            image = "nav_light_6";
        } else {
            image = "nav_light_5";
        }
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: image), forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().shadowImage = self.imageWithColor(UIColor.clearColor(), withSize: CGSizeMake(MainScreenWidth, 1))
        
        self.navigationBar.tintColor = UIColor.whiteColor()
        //设置标题颜色
        let titleAtt = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont.systemFontOfSize(17)]
        self.navigationBar.titleTextAttributes = titleAtt
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
