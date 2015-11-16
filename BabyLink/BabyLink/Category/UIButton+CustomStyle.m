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
 *  <#Description#>
 */
- (void)makeBackGroundColor_DarkGray {
    self.clipsToBounds=YES;
    self.layer.cornerRadius=4;
        
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image=[UIImage imageWithColor:DarkGrayBtnColor size:self.frame.size];
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
    self.layer.borderColor = GrayBorderColor.CGColor;
    
    [self setTitleColor:PurpleBtnColor forState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
}

- (void)makeBackGroundColor_Gray{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4;
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = GrayBorderColor.CGColor;
    
    UIImage *image = [UIImage imageWithColor:GrayBackColor size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
}


- (void)makeBackGroundColor_PurpleSelected{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4;
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = GrayBorderColor.CGColor;
    
    
    [self setTitleColor:PurpleBtnColor forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    UIImage *image = [UIImage imageWithColor:PurpleBtnColor size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateSelected];
    image = [UIImage imageWithColor:[UIColor whiteColor] size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
}

- (void)makeBackGroundColor_Green{
    self.clipsToBounds=YES;
    self.layer.cornerRadius=4;
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image=[UIImage imageWithColor:GreenBtnColor size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateNormal];
}
@end
