//
//  NSUserInfo.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/18.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSUserInfo.h"

@implementation NSUserInfo


static NSUserInfo * sharedInstance = nil;

+(instancetype)shareInstance
{
    if (sharedInstance == nil) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            sharedInstance = [[NSUserInfo alloc] init];
        });
    }
    return sharedInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _member_id = @"";
        _mobile = @"";;
        _member_name = @"";
        _member_avar = @"";
        _password = @"";
        _passwordLocal = @"";
        _openid = @"";
        _islogin = NO;
        _add_time = @"";
        _baby_date = @"";
        _baby_link = @"";
        _baby_nam = @"";
        _baby_sex = @"";
        
        _city = @"";
        _home = @"";
        _position = @"";
        _login_time = @"";
        
        _home2 = @"";
    }
    return self;
}

@end
