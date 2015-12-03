//
//  NSHttpHelp.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/17.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSHttpObject.h"
@interface NSHttpHelp : NSObject

typedef  enum : NSUInteger {
    //用户管理
    registerType,
    loginType,
    verticalCodeType,
    perfectType,
    otherLoginType,
    memberInfotype,
    uploadHeadType,
    updateNicknameType,
    updateMobileType,
    updatePswType,
    forgetPswType,
    loginOutType,
    autoPositionType,
    indexSearchType,
    
    getCityType,
    
    //活动相关
    actListType,
    actInfoType,
    commentActType,
    signInActType,
    actLaunchType,
    actJoinedType,
    addActType,
    cancelActType,
    
    //话题相关
    talkListType,
    commentTalkType,
    deleteTalkType,
    addTalkType,
    editTalkType,//
    
    
    //置换相关
    exchangeListType,
    exchangeInfoType,
    exhangeMyListType,
    addExchangeType,
    finishExchangeType,
    exchangeType,
    cancelExchangeType,
    myExchangeListType,
    
    
    //link相关
    addXiuType,
    addCommentType,
    xiuLinkType,
    xiuType,
    myXiuType,
    addFriendType,
    xiuFriendType,
    xiuDeleteType,
    xiuNeighborType,
    xiuShareType,
    xiuZanType,
    xiuFansType,
    
}HttpUrlType;

/*NSHttpHelp.httpHelpWithUrlTpye(uploadHeadType, withParam: nil, withResult: { (result:AnyObject!) -> Void in
 
 }) { (error:AnyObject!) -> Void in
 
 };*/
+ (void)httpHelpWithUrlTpye:(HttpUrlType)urlType withParam:(id)param withResult:(ReturnValueBlock)resultBlock withFailure:(FailureBlock)failureBlock;

+(void)uploadUserIconWithImageData:(NSDictionary*)imageDic withResult:(resultBlock)resultBlock withFailure:(FailureBlock)failureBlock withUploadProgress:(void (^)(float progress))progressBlock;


+(void)uploadUserIconWithImageData:(NSArray*)imageArray withUrl:(NSString *)url withResult:(resultBlock)resultBlock withFailure:(FailureBlock)failureBlock withUploadProgress:(void (^)(float progress))progressBlock;
@end
