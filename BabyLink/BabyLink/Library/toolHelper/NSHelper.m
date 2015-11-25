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

+ (NSData *)fileOfPressedImage:(UIImage *)image{
    CGSize imageSize = image.size;
    if (imageSize.width>640) {
        imageSize.height = imageSize.height/(imageSize.width/640);
        imageSize.width = 640;
        UIGraphicsBeginImageContext(imageSize);
        [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *pressSizeData = UIImageJPEGRepresentation(scaledImage, 0.3);
        return pressSizeData;
    }
    NSData *pressSizeData=UIImageJPEGRepresentation(image, 0.3);
    return pressSizeData;
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
@end
