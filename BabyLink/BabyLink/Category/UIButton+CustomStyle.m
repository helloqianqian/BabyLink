//
//  UIButton+CustomStyle.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "UIButton+CustomStyle.h"
#import "UIImage+SingleColor.h"

@implementation UIButton (CustomStyle)

/**
 *  我要报名
 */
-(void)makeBackGroundColor_Purple {
    self.clipsToBounds=YES;
    self.layer.cornerRadius=4;
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image=[UIImage imageWithColor:PurpleBtnColor size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

/**
 *  登录，注册，完善信息，我要报名
 */
-(void)makeBackGroundColor_Red {
    self.clipsToBounds=YES;
    self.layer.cornerRadius=4;
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image=[UIImage imageWithColor:RedBtnColor size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateNormal];
}
/**
 *  <#Description#>
 */
- (void)makeBackGroundColor_White{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4;
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = RGBCOLOR(0xF4F4F5).CGColor;
    
    [self setTitleColor:RGBCOLOR(0xBE3D6F) forState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
}
@end
