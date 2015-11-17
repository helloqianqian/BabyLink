//
//  NSHttpHelp.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/17.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSHttpHelp.h"
#import "NSHttpModel.h"

@implementation NSHttpHelp


+ (void)httpHelpWithUrlTpye:(HttpUrlType)urlType withParam:(NSDictionary *)param withResult:(ReturnValueBlock)resultBlock withFailure:(FailureBlock)failureBlock{
    NSString *url = @"";
    switch (urlType) {
        case registerType:
            url = [NSHttpModel getRegistUrl];
            break;
        case loginType:
            url = [NSHttpModel getLoginUrl];
            break;
        case verticalCodeType:
            url = [NSHttpModel getVerticalCode];
            break;
        case perfectType:
            url = [NSHttpModel getPerfectUrl];
            break;
        case otherLoginType:
            url = [NSHttpModel getOtherLoginUrl];
            break;
        case forgetPswType:
            url = [NSHttpModel getForgetPswUrl];
            break;
        case memberInfotype:
            url = [NSHttpModel getMemberInfoUrl];
            break;
        case updatePswType:
            url = [NSHttpModel getUpdatePswUrl];
            break;
        case uploadHeadType:
            url = [NSHttpModel getUpdateHeadUrl];
            break;
        case updateMobileType:
            url = [NSHttpModel getUpdateMobileUrl];
            break;
        case updateNicknameType:
            url = [NSHttpModel getUpdateNicknameUrl];
            break;
        default:
            break;
    }
    [NSHttpObject NetRequestPostWithUrl:url withParameter:param withReturnBlock:^(id returnValue) {
        
    } withErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id error) {
        
    }];
    
    
}
+(void)uploadUserIconWithImageData:(NSDictionary*)imageDic withResult:(resultBlock)resultBlock withFailure:(FailureBlock)failureBlock withUploadProgress:(void (^)(float progress))progressBlock{
    [NSHttpObject upLoadImagewithUrl:@"" withParameter:imageDic withResult:^(id resultValue) {
        
    } withFailureBlock:^(id error) {
        
    } withUploadProgress:^(float progress) {
        
    }];
}

@end
