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
    
    //活动相关
    actListType,
    actInfoType,
    commentActType,
    signInActType,
    actLaunchType,//
    actJoinedType,//
    addActType,//
    
    //话题相关
    talkListType,
    addTalkType,//
    editTalkType,//
    commentTalkType,
    deleteTalkType,
    
}HttpUrlType;

/*NSHttpHelp.httpHelpWithUrlTpye(uploadHeadType, withParam: nil, withResult: { (result:AnyObject!) -> Void in
 
 }) { (error:AnyObject!) -> Void in
 
 };*/
+ (void)httpHelpWithUrlTpye:(HttpUrlType)urlType withParam:(id)param withResult:(ReturnValueBlock)resultBlock withFailure:(FailureBlock)failureBlock;

+(void)uploadUserIconWithImageData:(NSDictionary*)imageDic withResult:(resultBlock)resultBlock withFailure:(FailureBlock)failureBlock withUploadProgress:(void (^)(float progress))progressBlock;

@end
