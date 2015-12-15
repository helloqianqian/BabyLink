//
//  NSHelper.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/18.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSHelper.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
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
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *timeStr = [dateFormatter stringFromDate: detaildate];
    return timeStr;
}


+ (NSArray *)leftTimeFromStamp:(double)timeStamp{
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:4];
    double left = timeStamp;
    int day = left/86400;
    left = left - day*86400;
    if (day>0) {
        [resultArray addObject:[NSString stringWithFormat:@"%d",day]];
    } else {
        [resultArray addObject:@"0"];
    }
    
    int hour = left/3600;
    left = left - hour*3600;
    if (hour>0) {
        [resultArray addObject:[NSString stringWithFormat:@"%d",hour]];
    } else {
        [resultArray addObject:@"0"];
    }
    
    int minute = left/60;
    left = left - minute*60;
    if (minute>0) {
        [resultArray addObject:[NSString stringWithFormat:@"%d",minute]];
    } else {
        [resultArray addObject:@"0"];
    }
    
    int second = left;
    if (left>0) {
        [resultArray addObject:[NSString stringWithFormat:@"%d",second]];
    } else {
        [resultArray addObject:@"0"];
    }
    
    return resultArray;
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
+ (NSString *)getAliPay:(NSString *)orderSpec {
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOQ6XhqQY6Kh2Di6VN6EOaKMV/uLfWMRUJcFMeEOfkQRKqvD47tM0NnEFR+BMRWkcItPqGXqECWHXBW3TiSB9TtwuePT2fAXvXjlQrrmXDd35ItcuPdqyejChxvQiZtcyfJEwQgHyxFoP29P1tmaqDhcqaJhbhdBjaj7tr5QGcbtAgMBAAECgYEArfUzPyopV4/nAC4+fDDqwVQZx9jlpLpQ5BuIjlN+uKEhFjVEgsIlOqcztoTBhg6F3hnEcJH85q4K6V6DyF3qLYime/hRQhcnB/gmCaEpkZdKyZYCod9bFyR0ZijARfi09Fm1eGsYzeoF88dAlDqJ2qd2b5T8xnDs0jqLUtnV+f0CQQD6K6VeN6a4dWArYryicj5oWtm/cgggc1t+DCNfQfJz6jGbXPrrdYmCYsu2XIEmdEFtXaZ0t8f3OpDz2zV59rNrAkEA6YvTtzhdYztz+kdM6OLMplVr2exNjRwKCzPe6O6Tlyyw8MKMDKvo2u5rBo7NI+l8EM1qjppxo22uPgoXacddBwJBAJ/MHVdvaNlOcF2GNkP1gZOa5Jf7OOGxjfGXw0hnkX0lTQaWf9jDPVDB1qnnsL9lZx16woavldV/3XNGxIPhZ30CQBh7VehA+lkqpE+6Ja/MBpPxJGslwENoiwz9lQJp8ALK5ol2e2PgqXo5v/JiCdMX6K+COQdV3U+6caeDO00VXwUCQGU1CAFX2YTaj3jKbyyEf2TRjW2uYHTQc6ky4+/s8Z3I+jh/iOKTt6BfmlWaci7M3waWfU2cUSDCuO7JYdSGOrg=";
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    return signedString;
}

+ (NSString *)jumpToBizPay {
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
}
@end
