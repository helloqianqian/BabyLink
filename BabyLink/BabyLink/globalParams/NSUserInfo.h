//
//  NSUserInfo.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/18.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserInfo : NSObject
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *userid;
@property (nonatomic,strong)NSString *userSex;
@property (nonatomic,strong)NSString *userAddr;

+ (instancetype)shareInstance;

@end
