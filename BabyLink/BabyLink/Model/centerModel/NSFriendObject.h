//
//  NSFriendObject.h
//  BabyLink
//
//  Created by 黄倩 on 15/12/1.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFriendObject : NSObject

@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *friend_avar;
@property (nonatomic,strong)NSString *friend_id;
@property (nonatomic,strong)NSString *friend_name;
@property (nonatomic,strong)NSString *member_friend_id;
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *flag;

@end


@interface NSNeighborObject : NSObject

@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *member_name;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)NSString *qq_openid;
@property (nonatomic,strong)NSString *wb_openid;
@property (nonatomic,strong)NSString *wx_openid;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *baby_date;
@property (nonatomic,strong)NSString *baby_link;
@property (nonatomic,strong)NSString *baby_nam;
@property (nonatomic,strong)NSString *baby_sex;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *home;
@property (nonatomic,strong)NSString *position;
@property (nonatomic,strong)NSString *login_time;


@end


@interface NSFanObject : NSObject
@property (nonatomic,strong)NSString *fans_id;
@property (nonatomic,strong)NSString *fans_name;
@property (nonatomic,strong)NSString *fans_avar;
@property (nonatomic,strong)NSString *flag;
@property (nonatomic,strong)NSString *flag_desc;
@end










