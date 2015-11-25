//
//  Common.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/10.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import Foundation
/**
 *  RGB颜色值
 *
 *  @param rgbValue:Int <#rgbValue:Int description#>
 *
 *  @return <#return value description#>
 */
func hexRGB(rgbValue:Int) ->UIColor
{
    let r = CGFloat((rgbValue & 0xffffff)>>16)/255.0;
    let g = CGFloat((rgbValue & 0xFF00)>>8)/255.0;
    let b = CGFloat(rgbValue & 0xff)/255.0;
    return UIColor(red: r, green: g, blue: b, alpha: 1);
}
func Color_Custom(r : CGFloat, g : CGFloat, b : CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1);
}

func Color_Custom(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha);
}

let SGrayBackColor = hexRGB(0xEDEEEF)
let SGrayBorderColor = hexRGB(0xACACB4)
let SPurpleBtnColor = hexRGB(0xBE3D6F)
let SRedBtnColor = hexRGB(0xDC5055)


//frame
let iphone4:Bool = CGSizeEqualToSize(CGSizeMake(320, 480), UIScreen.mainScreen().bounds.size)
let iphone5:Bool = CGSizeEqualToSize(CGSizeMake(320, 568), UIScreen.mainScreen().bounds.size)
let iphone6:Bool = CGSizeEqualToSize(CGSizeMake(375, 667), UIScreen.mainScreen().bounds.size)
let iphone6Plus:Bool = CGSizeEqualToSize(CGSizeMake(414, 736), UIScreen.mainScreen().bounds.size)

let MainScreenHeight : CGFloat = UIScreen.mainScreen().bounds.size.height;
let MainScreenWidth : CGFloat = UIScreen.mainScreen().bounds.size.width;

//view controller

let  appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate


var activityListLoad:Bool = false;
var activityInfoLoad:Bool = false;









