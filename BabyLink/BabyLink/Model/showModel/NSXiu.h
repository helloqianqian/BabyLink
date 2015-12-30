//
//  NSXiu.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/28.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSXiu : NSObject
@property (nonatomic,strong)NSString *xiu_id;
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *home;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *info;
@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)NSString *flag;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *member_name;
@property (nonatomic,strong)NSString *image_url;
@property (nonatomic,strong)NSMutableArray *commends;
@property (nonatomic,strong)NSMutableArray *zans;
@property (nonatomic,assign)BOOL isZan;
@property (nonatomic,assign)CGFloat infoHeight;
@property (nonatomic,assign)CGFloat zanHeight;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,strong)NSString *xiu_num;

@end

@interface NSXiuComment : NSObject
@property (nonatomic,strong)NSString *commend_id;
@property (nonatomic,strong)NSString *xiu_id;
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *info;
@property (nonatomic,assign)CGFloat position_x;
@property (nonatomic,assign)CGFloat position_y;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *member_name;
@property (nonatomic,assign)CGFloat infoHeight;
@property (nonatomic,assign)CGFloat infoWidth;
@end



@interface NSXiuZan : NSObject

@property (nonatomic,strong)NSString *zan_id;
@property (nonatomic,strong)NSString *xiu_id;
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *member_name;


@end