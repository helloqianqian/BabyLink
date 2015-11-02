//
//  NSUserInfoObject.swift
//  BabyLink
//
//  Created by 黄倩 on 15/10/27.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

let MainScreenHeight : CGFloat = UIScreen.mainScreen().bounds.size.height;
let MainScreenWidth : CGFloat = UIScreen.mainScreen().bounds.size.width;


 let homeListColor0 = UIColor(red: 247/255.0, green: 151/255.0, blue: 30/255.0, alpha: 1.0)
 let homeListColor1 = UIColor(red: 236/255.0, green: 164/255.0, blue: 2/255.0, alpha: 1.0)
 let homeListColor2 = UIColor(red: 245/255.0, green: 223/255.0, blue: 60/255.0, alpha: 1.0)
 let homeListColor3 = UIColor(red: 195/255.0, green: 209/255.0, blue: 64/255.0, alpha: 1.0)
 let homeListColor4 = UIColor(red: 100/255.0, green: 176/255.0, blue: 68/255.0, alpha: 1.0)
 let homeListColor5 = UIColor(red: 52/255.0, green: 182/255.0, blue: 122/255.0, alpha: 1.0)
 let homeListColor6 = UIColor(red: 77/255.0, green: 191/255.0, blue: 217/255.0, alpha: 1.0)

 let backgroudColor = UIColor(red: 213/255.0, green: 229/255.0, blue: 207/255.0, alpha: 1.0)

 let greenColor = UIColor(red: 70/255.0, green: 169/255.0, blue: 64/255.0, alpha: 1.0)

 let tabbarBgColor = UIColor(red: 77/255.0, green: 85/255.0, blue: 84/255.0, alpha: 1.0)
 let videoNavColor = UIColor(red: 52/255.0, green: 52/255.0, blue: 52/255.0, alpha: 1.0)

 let baseBlueColor = hexRGB(0x0BB4D3)
 let baseBarBlueColor = hexRGB(0x3E4EB8)

 let iphone4:Bool = CGSizeEqualToSize(CGSizeMake(320, 480), UIScreen.mainScreen().bounds.size)
 let iphone5:Bool = CGSizeEqualToSize(CGSizeMake(320, 568), UIScreen.mainScreen().bounds.size)
 let iphone6:Bool = CGSizeEqualToSize(CGSizeMake(375, 667), UIScreen.mainScreen().bounds.size)
 let iphone6Plus:Bool = CGSizeEqualToSize(CGSizeMake(414, 736), UIScreen.mainScreen().bounds.size)

func Color_Custom(r : CGFloat, g : CGFloat, b : CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1);
}

func Color_Custom(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha);
}

/**
 *  RGB颜色值
 *
 *  @param rgbValue:Int <#rgbValue:Int description#>
 *
 *  @return <#return value description#>
 */
func  hexRGB(rgbValue:Int) ->UIColor
{
    let r = CGFloat((rgbValue & 0xffffff)>>16)/255.0;
    let g = CGFloat((rgbValue & 0xFF00)>>8)/255.0;
    let b = CGFloat(rgbValue & 0xff)/255.0;
    return UIColor(red: r, green: g, blue: b, alpha: 1);
}

class NSUserInfoObject: NSObject {

}
