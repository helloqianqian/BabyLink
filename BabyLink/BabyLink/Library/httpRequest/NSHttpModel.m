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

//用户管理
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


#define getCityListSuf    @"/Index/getCityList"

#pragma mark - 用户管理
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
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:otherLoginSuf];
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

/**
 *  修改小区
 *
 *  @return <#return value description#>
 */
+ (NSString *)getChangeHomeUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:updateMemberSuf];
}

+ (NSString *)getCityList{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:@"/Index/getCityList"];
}


#pragma mark - 活动数据
//活动
#define activityListSuf  @"/Activity"
#define addActivitySuf   @"/Activity/addActivity"
#define signUpActSuf     @"/Activity/signUp"
#define actCommentSuf    @"/Activity/commend"
#define actInfoSuf       @"/Activity/activity_info"
#define actLaunchSuf     @"/Activity/MyLaunch"
#define actJoinedSuf     @"/Activity/MyJoin"
#define cancelActSuf     @"/Activity/cancel_activity"
/**
 *  活动列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getActListUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:activityListSuf];
}
/**
 *  创建活动
 *
 *  @return <#return value description#>
 */
+ (NSString *)getAddActUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:addActivitySuf];
}
/**
 *  参加活动
 *
 *  @return <#return value description#>
 */
+ (NSString *)getSignUpActUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:signUpActSuf];
}

/**
 *  取消报名
 *
 *  @return <#return value description#>
 */
+ (NSString *)getCancelActUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:cancelActSuf];
}

/**
 *  添加活动评论
 *
 *  @return <#return value description#>
 */
+ (NSString *)getActCommentUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:actCommentSuf];
}
/**
 *  获取活动详情
 *
 *  @return <#return value description#>
 */
+ (NSString *)getActInfoUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:actInfoSuf];
}
/**
 *  我的活动列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMyActLaunchUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:actLaunchSuf];
}

/**
 *  我参加的活动列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMyActJoinedUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:actJoinedSuf];
}


#pragma mark - 话题相关
#define talkListSuf       @"/Talk"
#define talkCommendSuf    @"/Talk/commend"
#define addTalkSuf        @"/Talk/addTalk"
#define editTalkSuf       @"/Talk/editTalk"
#define deleteTalkSuf     @"/Talk/delTalk"
/**
 *  我的话题；话题列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMyTalkUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:talkListSuf];
}

/**
 *  评论话题
 *
 *  @return <#return value description#>
 */
+ (NSString *)getTalkCommendUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:talkCommendSuf];
}

/**
 *  添加话题
 *
 *  @return <#return value description#>
 */
+ (NSString *)getAddTalkUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:addTalkSuf];
}

/**
 *  编辑话题
 *
 *  @return <#return value description#>
 */
+ (NSString *)getEditTalkUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:editTalkSuf];
}

/**
 *  删除话题
 *
 *  @return <#return value description#>
 */
+ (NSString *)getdeleteTalkUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:deleteTalkSuf];
}


#pragma mark - 置换相关
#define exchangeListSuf      @"/Exchange"
#define exchangeInfoSuf      @"/Exchange/exchangeInfo"
#define exchangeMyListSuf    @"/Exchange/meExchange"
#define addExchangeSuf       @"/Exchange/addExchange"
#define finishExchangeSuf    @"/Exchange/finishExchange"
#define exchangeSuf          @"/Exchange/exchange"
#define cancelExchangeSuf    @"/Exchange/cancelExchange"
#define myExchangeListSuf    @"/Exchange/issueExchange"

/**
 *  置换列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getExchangeListUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:exchangeListSuf];
}

/**
 *  置换详情
 *
 *  @return <#return value description#>
 */
+ (NSString *)getExchangeInfoUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:exchangeInfoSuf];
}

/**
 *  我参与的置换列表  和  我的置换列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getExchangeMyListUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:exchangeMyListSuf];
}

/**
 *  添加置换
 *
 *  @return <#return value description#>
 */
+ (NSString *)getAddExchangeUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:addExchangeSuf];
}

/**
 *  完成置换
 *
 *  @return <#return value description#>
 */
+ (NSString *)getFinishExchangeUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:finishExchangeSuf];
}

/**
 *  置换
 *
 *  @return <#return value description#>
 */
+ (NSString *)getExchangeUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:exchangeSuf];
}

/**
 *  取消置换
 *
 *  @return <#return value description#>
 */
+ (NSString *)getCancelExchangeUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:cancelExchangeSuf];
}

/**
 *  我的置换商品列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMyExchangeListUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:myExchangeListSuf];
}







#pragma mark - 秀逗相关
#define addXiuSuf       @"/Xiu/addXiu"
#define addCommentSuf   @"/Xiu/addCommend"
#define xiuLinkSuf      @"/Xiu/link"
#define xiuSuf          @"/Xiu"
#define myXiuSuf        @"/Xiu/myXiu"
#define addFriendSuf    @"/Xiu/addFriend"
#define xiuFriendSuf    @"/Xiu/friendList"
#define xiuDeleteSuf    @"/Xiu/deleteFriend"
#define xiuNeighborSuf  @"/Xiu/neighborList"
#define xiuShareSuf     @"/Index/share"
#define xiuzanSuf       @"/Xiu/zan"
#define xiuFansSuf      @"/Xiu/fansList"


+ (NSString *)getAddXiuUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:addXiuSuf];
}
+ (NSString *)getAddCommentUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:addCommentSuf];
}
+ (NSString *)getLinkUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:xiuLinkSuf];
}
+ (NSString *)getXiuUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:xiuSuf];
}
+ (NSString *)getMyXiuUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:myXiuSuf];
}
+ (NSString *)getAddFriendUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:addFriendSuf];
}
+ (NSString *)getXiuFriendUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:xiuFriendSuf];
}
+ (NSString *)getXiuDeleteUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:xiuDeleteSuf];
}
+ (NSString *)getXiuNeighborUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:xiuNeighborSuf];
}
+ (NSString *)getXiuShareUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:xiuShareSuf];
}
+ (NSString *)getXiuZanUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:xiuzanSuf];
}
+ (NSString *)getXiuFansUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:xiuFansSuf];
}


#pragma mark - 发现
#define goodsSuf       @"/Goods"
#define goodsInfoSuf   @"/Goods/goods_info"
#define goodsIssueSuf  @"/Goods/issue_friend"
#define goodsFListSuf  @"/Goods/friend_list"


+ (NSString *)getGoodsUrl {
    return [httpHost stringByAppendingString:goodsSuf];
}
+ (NSString *)getGoodsInfoUrl {
    return [httpHost stringByAppendingString:goodsInfoSuf];
}
+ (NSString *)getGoodsIssueUrl{
    return [httpHost stringByAppendingString:goodsIssueSuf];
}
+ (NSString *)getGoodsFListUrl {
    return [httpHost stringByAppendingString:goodsFListSuf];
}


#pragma mark - 订单
#define orderPaySuf     @"/Order/pay"
#define notifySuf       @"/Pay/notify/pay_way/1/pay_type/1"
#define orderSuf        @"/Order"

#define orderCancelSuf  @"/Order/cancel"
#define orderRefundSuf  @"/Order/refund"

#define getPrePaySuf    @"Order/getPrepay"
#define notifyWXDJSuf   @"/Pay/notifyWx_dingjin"
#define notifyWXWKSuf   @"/Pay/notifyWx_weikuan"

#define notifyAliDJSuf  @"/Pay/notifyAli_dingjin"
#define notifyAliWKSuf  @"/Pay/notifyAli_weikuan"

#define orderNumSuf     @"/Member/getOrderNum"
+ (NSString *)getOrderNumUrl{
    return [httpHost stringByAppendingString:orderNumSuf];
}

+ (NSString *)getOrderPayUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:orderPaySuf];
}
+ (NSString *)getNotifyUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:notifySuf];
}
+ (NSString *)getOrderUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:orderSuf];
}
+ (NSString *)getOrderCancelUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:orderCancelSuf];
}
+ (NSString *)getOrderRefundUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:orderRefundSuf];
}
+ (NSString *)getPrePayUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:getPrePaySuf];
}
+ (NSString *)getWXDJUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:notifyWXDJSuf];
}
+ (NSString *)getWXWKUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:notifyWXWKSuf];
}

+ (NSString *)getAliDJUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:notifyAliDJSuf];
}
+ (NSString *)getAliWKUrl {
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:notifyAliWKSuf];
}










#pragma mark - 上传图片
#define uploadImageSuf   @"/Index/uploadFile"
+ (NSString *)getUploadImageUrl{
    return [[httpHost stringByAppendingString:Mobile] stringByAppendingString:uploadImageSuf];
}


@end
