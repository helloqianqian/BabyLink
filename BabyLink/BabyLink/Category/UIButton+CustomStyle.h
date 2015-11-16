//
//  UIButton+CustomStyle.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CustomStyle)
/**
 *  我要报名
 */
-(void)makeBackGroundColor_Purple;


/**
 *  登录，注册，完善信息，我要报名
 */
-(void)makeBackGroundColor_Red;


/**
 *  发现中分类
 */
- (void)makeBackGroundColor_White;


/**
 *  退款
 */
- (void)makeBackGroundColor_Gray;


/**
 *  兑换券
 */
- (void)makeBackGroundColor_PurpleSelected;

/**
 *  发送验证码
 */
- (void)makeBackGroundColor_Green;

/**
 *  我的主页中，不可点
 */
- (void)makeBackGroundColor_DarkGray;
@end
