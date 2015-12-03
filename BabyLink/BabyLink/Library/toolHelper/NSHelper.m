//
//  NSHelper.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/18.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSHelper.h"

@implementation NSHelper



/**
 *  检查用户手机
 *
 *  @return <#return value description#>
 */
+(BOOL)checkUserPhoneValidateWith:(NSString*)phone
{
    NSString *pattern = @"^1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:phone];
    return isMatch;
}


+ (void )showAlertViewWithTip:(NSString *)tipStr{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:tipStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

+ (NSData *)fileOfPressedImage:(UIImage *)image withType:(ImageSizeType)type{
    UIImage *newImage = [NSHelper cutImageInRect:image withType:type];
    CGSize imageSize = newImage.size;
    if (imageSize.width>840) {
        imageSize.height = imageSize.height/(imageSize.width/840);
        imageSize.width = 840;
        UIGraphicsBeginImageContext(imageSize);
        [newImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *pressSizeData = UIImageJPEGRepresentation(scaledImage, 0.3);
        return pressSizeData;
    }
    NSData *pressSizeData=UIImageJPEGRepresentation(newImage, 0.3);
    return pressSizeData;
}

+ (UIImage *)cutImageInRect:(UIImage *)originImage withType:(ImageSizeType)type{
    switch (type) {
        case squareType:
            if (originImage.size.width == originImage.size.height){
                return  originImage;
            } else {
                CGImageRef imageRef = nil;
                if (originImage.size.width>originImage.size.height) {
                    imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake((originImage.size.width - originImage.size.height)/2, 0, originImage.size.height, originImage.size.height));
                } else {
                    imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake(0, (originImage.size.height - originImage.size.width)/2, originImage.size.width, originImage.size.width));
                }
                return [UIImage imageWithCGImage:imageRef];
            }
        case rectangleType:
            if (originImage.size.width == 2*originImage.size.height){
                return  originImage;
            } else {
                CGImageRef imageRef = nil;
                if (originImage.size.width>2*originImage.size.height) {
                    imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake((originImage.size.width - 2*originImage.size.height)/2, 0, 2*originImage.size.height, originImage.size.height));
                } else {
                    imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake(0, (originImage.size.height - originImage.size.width/2)/2, originImage.size.width, originImage.size.width/2));
                }
                return [UIImage imageWithCGImage:imageRef];
            }
        default:
            break;
    }
}

+ (NSString *)timeStrFromeStamp:(NSString *)timeStamp {
    NSTimeInterval time=[timeStamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *timeStr = [dateFormatter stringFromDate: detaildate];
    return timeStr;
}
+ (NSInteger)currentYear {
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearStr = [formatter stringFromDate:today];
    return yearStr.integerValue;
}
+ (NSInteger)currentMonth{
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *month = [formatter stringFromDate:today];
    return month.integerValue;
}
+ (NSInteger)currentDay{
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *day = [formatter stringFromDate:today];
    return day.integerValue;
}


/**
 *  计算当月最多有几天
 *
 *  @param month 月份（注：从0开始的）
 *  @param year  年份
 *  @param day   几号（注：从0开始的）
 *
 *  @return <#return value description#>
 */
+ (NSInteger)maxDayOfTheMonth:(NSInteger)month andYear:(NSInteger)year andSelectedDay:(NSInteger)day{
    if (month == 1) {
        if (year%100 == 0) {
            if (year%400 == 0) {
                if (day > 28) {
                    return 28;
                }
            } else {
                if (day > 27) {
                    return 27;
                }
            }
        } else if (year%4==0) {
            if (day > 28) {
                return 28;
            }
        } else {
            if (day > 27) {
                return 27;
            }
        }
    } else if (month == 3 || month == 5 || month == 8 || month == 10){
        if (day == 30) {
            return 29;
        }
    }
    return day;
}


/**
 *  几天后的时间
 *
 *  @param from  几天后
 *  @param year  年份
 *  @param month 月份
 *  @param day   日
 */
+ (void)TheDayFromCurrentDay:(NSInteger)from isYear:(NSInteger *)year isMonth:(NSInteger *)month isDay:(NSInteger *)day{
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow:60*60*24*from];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *dayStr = [formatter stringFromDate:today];
    *day = dayStr.integerValue;
    [formatter setDateFormat:@"MM"];
    NSString *monthStr = [formatter stringFromDate:today];
    *month = monthStr.integerValue;
    [formatter setDateFormat:@"yyyy"];
    NSString *yearStr = [formatter stringFromDate:today];
    *year = yearStr.integerValue;
}
@end
