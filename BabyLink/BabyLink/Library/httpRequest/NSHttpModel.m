//
//  NSHttpModel.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/17.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSHttpModel.h"

@implementation NSHttpModel

#define httpHost @"http://101.200.174.65/babyLink/mobile.php"

#define Mobile @"/Mobile"


#define loginSession       @"/Login"
#define registSuf          @"/Login/register"
#define loginSuf           @"/Login"
#define sendCodeSuf        @"/Login/sendCode"
#define perfectSuf         @"/Login/perfect"
#define otherLoginSuf      @"/Login/otherLogin"
#define resetPSWSuf        @"/Login/forgetPassword"

#define memberInfoSuf      @"/Member/member_info"
#define uploadHeadSuf      @"/Member/uploadHead"
#define updateMemberSuf    @"/Member/updateMember"
#define updateMobileSuf    @"/Member/updateMobile"
#define updatePSWSuf       @"/Member/updatePassword"

#define autoPositionSuf   @"/Index/autoPosition"
#define indexSearchSuf    @"/Index/search"






//用户
/**
 *  发送验证码
 *
 *  @return <#return value description#>
 */
+(NSString *)getVerticalCode{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:sendCodeSuf];
}

/**
 *  注册
 *
 *  @return <#return value description#>
 */
+(NSString *)getRegistUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:registSuf];
}

/**
 *  登录
 *
 *  @return <#return value description#>
 */
+(NSString *)getLoginUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:loginSuf];
}

/**
 *  完善资料
 *
 *  @return <#return value description#>
 */
+(NSString *)getPerfectUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:perfectSuf];
}

/**
 *  第三方登录
 *
 *  @return <#return value description#>
 */
+(NSString *)getOtherLoginUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:perfectSuf];
}

/**
 *  忘记密码
 *
 *  @return <#return value description#>
 */
+(NSString *)getForgetPswUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:resetPSWSuf];
}

/**
 *  获取个人信息
 *
 *  @return <#return value description#>
 */
+(NSString *)getMemberInfoUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:memberInfoSuf];
}

/**
 *  上传头像
 *
 *  @return <#return value description#>
 */
+(NSString *)getUpdateHeadUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:uploadHeadSuf];
}

/**
 *  修改昵称
 *
 *  @return <#return value description#>
 */
+(NSString *)getUpdateNicknameUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:updateMemberSuf];
}

/**
 *  更换手机号
 *
 *  @return <#return value description#>
 */
+(NSString *)getUpdateMobileUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:updateMobileSuf];
}

/**
 *  修改密码
 *
 *  @return <#return value description#>
 */
+(NSString *)getUpdatePswUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:updatePSWSuf];
}

/**
 *  自动定位
 *
 *  @return <#return value description#>
 */
+ (NSString *)getAutoPositionUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:autoPositionSuf];
}

/**
 *  小区联想
 *
 *  @return <#return value description#>
 */
+ (NSString *)getIndexSearchUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:indexSearchSuf];
}
@end
