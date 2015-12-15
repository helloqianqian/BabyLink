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

/**
 *  获取城市列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getCityList;


/**
 *  活动列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getActListUrl;
/**
 *  创建活动
 *
 *  @return <#return value description#>
 */
+ (NSString *)getAddActUrl;
/**
 *  参加活动
 *
 *  @return <#return value description#>
 */
+ (NSString *)getSignUpActUrl;
/**
 *  取消报名
 *
 *  @return <#return value description#>
 */
+ (NSString *)getCancelActUrl;

/**
 *  添加活动评论
 *
 *  @return <#return value description#>
 */
+ (NSString *)getActCommentUrl;
/**
 *  获取评论详情
 *
 *  @return <#return value description#>
 */
+ (NSString *)getActInfoUrl;
/**
 *  我的活动列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMyActLaunchUrl;

/**
 *  我参加的活动列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMyActJoinedUrl;












/**
 *  我的话题；话题列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMyTalkUrl;

/**
 *  评论话题
 *
 *  @return <#return value description#>
 */
+ (NSString *)getTalkCommendUrl;

/**
 *  添加话题
 *
 *  @return <#return value description#>
 */
+ (NSString *)getAddTalkUrl;

/**
 *  编辑话题
 *
 *  @return <#return value description#>
 */
+ (NSString *)getEditTalkUrl;

/**
 *  删除话题
 *
 *  @return <#return value description#>
 */
+ (NSString *)getdeleteTalkUrl;








#pragma mark - 置换相关
/**
 *  置换列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getExchangeListUrl;

/**
 *  置换详情
 *
 *  @return <#return value description#>
 */
+ (NSString *)getExchangeInfoUrl;

/**
 *  我参与的置换列表  和  我的置换列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getExchangeMyListUrl;

/**
 *  添加置换
 *
 *  @return <#return value description#>
 */
+ (NSString *)getAddExchangeUrl;

/**
 *  完成置换
 *
 *  @return <#return value description#>
 */
+ (NSString *)getFinishExchangeUrl;

/**
 *  置换
 *
 *  @return <#return value description#>
 */
+ (NSString *)getExchangeUrl;

/**
 *  取消置换
 *
 *  @return <#return value description#>
 */
+ (NSString *)getCancelExchangeUrl;

/**
 *  我的置换商品列表
 *
 *  @return <#return value description#>
 */
+ (NSString *)getMyExchangeListUrl;



#pragma mark - 秀
+ (NSString *)getAddXiuUrl;
+ (NSString *)getAddCommentUrl;
+ (NSString *)getLinkUrl;
+ (NSString *)getXiuUrl;
+ (NSString *)getMyXiuUrl;
+ (NSString *)getAddFriendUrl ;
+ (NSString *)getXiuFriendUrl ;
+ (NSString *)getXiuDeleteUrl;
+ (NSString *)getXiuNeighborUrl;
+ (NSString *)getXiuShareUrl;
+ (NSString *)getXiuZanUrl;
+ (NSString *)getXiuFansUrl;


#pragma mark - 发现
+ (NSString *)getGoodsUrl;
+ (NSString *)getGoodsInfoUrl;
+ (NSString *)getGoodsIssueUrl;
+ (NSString *)getGoodsFListUrl;

#pragma mark - 订单
+ (NSString *)getOrderNumUrl;
+ (NSString *)getOrderPayUrl;
+ (NSString *)getNotifyUrl;
+ (NSString *)getOrderUrl;
+ (NSString *)getOrderCancelUrl;
+ (NSString *)getOrderRefundUrl;
+ (NSString *)getPrePayUrl;
+ (NSString *)getWXDJUrl;
+ (NSString *)getWXWKUrl;
+ (NSString *)getAliDJUrl;
+ (NSString *)getAliWKUrl;







#pragma mark - 上传图片
+ (NSString *)getUploadImageUrl;
@end
