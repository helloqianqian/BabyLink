//
//  NSHelper.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/18.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHelper : NSObject
+(BOOL)checkUserPhoneValidateWith:(NSString*)phone;


+ (void)showAlertViewWithTip:(NSString *)tipStr;


+ (NSInteger)currentYear;
+ (NSInteger)currentMonth;
+ (NSInteger)currentDay;
@end
