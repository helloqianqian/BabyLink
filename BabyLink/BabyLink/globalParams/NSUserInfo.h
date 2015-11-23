//
//  NSUserInfo.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/18.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSUserInfo : NSObject


@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *member_name;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)NSString *passwordLocal;
@property (nonatomic,strong)NSString *openid;
@property (nonatomic,assign)BOOL islogin;

@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *baby_date;
@property (nonatomic,strong)NSString *baby_link;
@property (nonatomic,strong)NSString *baby_nam;
@property (nonatomic,strong)NSString *baby_sex;

@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *home;
@property (nonatomic,strong)NSString *position;

@property (nonatomic,strong)NSString *login_time;




+ (instancetype)shareInstance;

@end
