//
//  NSActivity.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/23.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSActivity : NSObject

@end


@interface NSActListObject : NSObject
/*{
 "activity_id": "12",
 "images": "public/uploads/20151129/565afa3923a59.jpg,public/uploads/20151129/565afaa3c59d0.jpg",
 "title": "新建活动测试",
 "jihe_time": "2015-12-31 16:33:48",
 "activity_address": "青龙湖",
 "member_id": "1",
 "count": "0",
 "status": 1,
 "status_desc": "进行中",
 "image_url": "http://101.200.174.65/babyLink/public/uploads/20151129/565afa3923a59.jpg"
 },
 */
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *activity_id;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *jihe_time;
@property (nonatomic,strong)NSString *activity_address;
@property (nonatomic,strong)NSString *count;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *member_name;
@property (nonatomic,strong)NSString *image_url;
@property (nonatomic,strong)NSString *images;
@property (nonatomic,strong)NSMutableArray *logs_list;
@property (nonatomic,assign)BOOL isOut;
@property (nonatomic,assign)BOOL isSign;
@property (nonatomic,assign)BOOL isFull;

@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *status_desc;
@end


@interface NSLogListObject : NSObject

@property (nonatomic,strong)NSString *log_id;
@property (nonatomic,strong)NSString *activity_id;
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *member_mobile;
@property (nonatomic,strong)NSString *num;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *member_name;
@property (nonatomic,strong)NSString *link_man;

@end

@interface NSActInfoObject : NSObject
@property (nonatomic,strong)NSString *activity_address;
@property (nonatomic,strong)NSString *activity_id;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *begin_time;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *home;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,strong)NSString *info;
@property (nonatomic,strong)NSString *is_help;
@property (nonatomic,strong)NSString *help;
@property (nonatomic,strong)NSString *jihe_address;
@property (nonatomic,strong)NSString *jihe_time;
@property (nonatomic,strong)NSString *link_mobile;
@property (nonatomic,strong)NSString *link_name;

@property (nonatomic,strong)NSString *count;
@property (nonatomic,strong)NSMutableArray *commends;
@property (nonatomic,strong)NSMutableArray *logs;
@property (nonatomic,strong)NSString *max_man;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *member_name;
@property (nonatomic,strong)NSString *pay_way;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *utils;

@end


@interface NSCommentObject : NSObject
@property (nonatomic,strong)NSString *activity_id;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *commend_id;
@property (nonatomic,strong)NSString *from_userAvar;
@property (nonatomic,strong)NSString *from_userId;
@property (nonatomic,strong)NSString *from_userName;
@property (nonatomic,strong)NSString *info;
@property (nonatomic,strong)NSString *to_userId;
@property (nonatomic,strong)NSString *to_userName;
@end
