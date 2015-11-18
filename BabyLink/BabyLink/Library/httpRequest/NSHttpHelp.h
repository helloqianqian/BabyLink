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
}HttpUrlType;

+ (void)httpHelpWithUrlTpye:(HttpUrlType)urlType withParam:(id)param withResult:(ReturnValueBlock)resultBlock withFailure:(FailureBlock)failureBlock;

+(void)uploadUserIconWithImageData:(NSDictionary*)imageDic withResult:(resultBlock)resultBlock withFailure:(FailureBlock)failureBlock withUploadProgress:(void (^)(float progress))progressBlock;

@end
