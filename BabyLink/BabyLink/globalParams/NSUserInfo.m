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
        
    }
    return self;
}

@end
