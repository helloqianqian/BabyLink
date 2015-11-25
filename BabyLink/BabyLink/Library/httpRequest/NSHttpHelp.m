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
#pragma mark - 用户
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
        case autoPositionType:
            url = [NSHttpModel getAutoPositionUrl];
            break;
        case indexSearchType:
            url = [NSHttpModel getIndexSearchUrl];
            break;
#pragma mark - 活动
        case actListType:
            url = [NSHttpModel getActListUrl];
            break;
        case actInfoType:
            url = [NSHttpModel getActInfoUrl];
            break;
        case actLaunchType:
            url = [NSHttpModel getMyActLaunchUrl];
            break;
        case actJoinedType:
            url = [NSHttpModel getMyActJoinedUrl];
            break;
        case addActType:
            url = [NSHttpModel getAddActUrl];
            break;
        case commentActType:
            url = [NSHttpModel getActCommentUrl];
            break;
        case signInActType:
            url = [NSHttpModel getSignUpActUrl];
            break;
#pragma mark - 话题
        case talkListType:
            url = [NSHttpModel getMyTalkUrl];
            break;
        case addTalkType:
            url = [NSHttpModel getAddTalkUrl];
            break;
        case editTalkType:
            url = [NSHttpModel getEditTalkUrl];
            break;
        case commentTalkType:
            url = [NSHttpModel getTalkCommendUrl];
            break;
        default:
            break;
    }
    NSLog(@"url:%@",url);
    [NSHttpObject NetRequestPostWithUrl:url withParameter:param withReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        
        resultBlock(returnValue);
    } withErrorBlock:^(id errorCode) {
        
    } withFailureBlock:^(id error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
        failureBlock(error);
    }];
    
    
}
+(void)uploadUserIconWithImageData:(NSDictionary*)imageDic withResult:(resultBlock)resultBlock withFailure:(FailureBlock)failureBlock withUploadProgress:(void (^)(float progress))progressBlock{
    [NSHttpObject upLoadImagewithUrl:[NSHttpModel getUpdateHeadUrl] withParameter:imageDic withResult:^(id resultValue) {
        resultBlock(resultValue);
    } withFailureBlock:^(id error) {
        failureBlock(error);
    } withUploadProgress:^(float progress) {
        progressBlock(progress);
    }];
}

@end
