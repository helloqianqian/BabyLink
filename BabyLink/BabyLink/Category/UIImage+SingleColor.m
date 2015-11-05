//
//  UIImage+SingleColor.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "UIImage+SingleColor.h"

@implementation UIImage (SingleColor)
+(UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *singleColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return singleColorImg;
}
@end
