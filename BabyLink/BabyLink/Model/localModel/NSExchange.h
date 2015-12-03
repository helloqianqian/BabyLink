//
//  NSExchange.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/26.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSExchange : NSObject
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *exchange_id;
@property (nonatomic,strong)NSString *home;
@property (nonatomic,strong)NSString *from_gname;
@property (nonatomic,strong)NSString *to_gname;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *info;
@property (nonatomic,strong)NSString *member_name;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)id images;
@property (nonatomic,strong)NSString *ing_time;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *role;
@property (nonatomic,strong)NSString *link_exchange_id;
@property (nonatomic,strong)NSString *image_url;

@property (nonatomic,strong)NSString *link_name;
@property (nonatomic,strong)NSString *link_mobile;

@end

