//
//  NSHelper.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/18.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSHelper : NSObject
//审核手机号
+(BOOL)checkUserPhoneValidateWith:(NSString*)phone;

//提示
+ (void)showAlertViewWithTip:(NSString *)tipStr;

//压缩图片
+ (NSData *)fileOfPressedImage:(UIImage *)image;


//时间
+ (NSInteger)currentYear;
+ (NSInteger)currentMonth;
+ (NSInteger)currentDay;

+ (NSString *)timeStrFromeStamp:(NSString *)timeStamp;
@end
