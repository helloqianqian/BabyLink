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

typedef  enum : NSUInteger {
    squareType,//正方形
    rectangleType,//长方形
}ImageSizeType;


//审核手机号
+(BOOL)checkUserPhoneValidateWith:(NSString*)phone;

//提示
+ (void)showAlertViewWithTip:(NSString *)tipStr;

//压缩图片
+ (NSData *)fileOfPressedImage:(UIImage *)image withType:(ImageSizeType)type;


//时间
+ (NSInteger)currentYear;
+ (NSInteger)currentMonth;
+ (NSInteger)currentDay;


/**
 *  计算当月最多有几天
 *
 *  @param month 月份（注：从0开始的）
 *  @param year  年份
 *  @param day   几号（注：从0开始的）
 *
 *  @return <#return value description#>
 */
+ (NSInteger)maxDayOfTheMonth:(NSInteger)month andYear:(NSInteger)year andSelectedDay:(NSInteger)day;

/**
 *  <#Description#>
 *
 *  @param from  <#from description#>
 *  @param year  <#year description#>
 *  @param month <#month description#>
 *  @param day   <#day description#>
 */
+ (void)TheDayFromCurrentDay:(NSInteger)from isYear:(NSInteger *)year isMonth:(NSInteger *)month isDay:(NSInteger *)day;




+ (NSString *)timeStrFromeStamp:(NSString *)timeStamp;



+ (NSArray *)leftTimeFromStamp:(double)timeStamp;


+ (NSString *)jumpToBizPay;

+ (NSString *)getAliPay:(NSString *)orderSpec;


//版本号
+ (NSString*)appVesionVersionNum;

//+ (void)shareImage:(int)type sender:(UIViewController *)sender;


+(NSData *)getImageData:(NSString *)imageURL;
@end
