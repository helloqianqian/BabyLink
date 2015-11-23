//
//  NSHttpModel.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/17.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHttpModel : NSObject


/**
 *  发送验证码
 *
 *  @return <#return value description#>
 */
+(NSString *)getVerticalCode;

/**
 *  注册
 *
 *  @return <#return value description#>
 */
+(NSString *)getRegistUrl;

/**
 *  登录
 *
 *  @return <#return value description#>
 */
+(NSString *)getLoginUrl;

/**
 *  完善资料
 *
 *  @return <#return value description#>
 */
+(NSString *)getPerfectUrl;

/**
 *  第三方登录
 *
 *  @return <#return value description#>
 */
+(NSString *)getOtherLoginUrl;

/**
 *  忘记密码
 *
 *  @return <#return value description#>
 */
+(NSString *)getForgetPswUrl;

/**
 *  获取个人信息
 *
 *  @return <#return value description#>
 */
+(NSString *)getMemberInfoUrl;

/**
 *  上传头像
 *
 *  @return <#return value description#>
 */
+(NSString *)getUpdateHeadUrl;

/**
 *  修改昵称
 *
 *  @return <#return value description#>
 */
+(NSString *)getUpdateNicknameUrl;

/**
 *  更换手机号
 *
 *  @return <#return value description#>
 */
+(NSString *)getUpdateMobileUrl;

/**
 *  修改密码
 *
 *  @return <#return value description#>
 */
+(NSString *)getUpdatePswUrl;

/**
 *  自动定位
 *
 *  @return <#return value description#>
 */
+ (NSString *)getAutoPositionUrl;


/**
 *  小区联想
 *
 *  @return <#return value description#>
 */
+ (NSString *)getIndexSearchUrl;

@end
