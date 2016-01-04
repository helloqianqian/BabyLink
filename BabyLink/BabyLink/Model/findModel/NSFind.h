//
//  NSFind.h
//  BabyLink
//
//  Created by 黄倩 on 15/12/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFind : NSObject
@property (nonatomic,strong)NSString *goods_oprice;
@property (nonatomic,strong)NSString *goods_baseprice;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *images;
@property (nonatomic,strong)NSString *goods_price;
@property (nonatomic,strong)NSString *goods_dingjin;
@property (nonatomic,strong)NSString *order_num;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *store_id;
@property (nonatomic,strong)NSString *store_name;
@property (nonatomic,strong)NSString *store_class;
@property (nonatomic,strong)NSString *position_lo;
@property (nonatomic,strong)NSString *position_la;
@property (nonatomic,strong)NSString *image_url;
@property (nonatomic,strong)NSString *meters;

@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *member_name;

@property (nonatomic,strong)NSString *flag;

@end


@interface NSInfoFind : NSObject

@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic,strong)NSString *store_id;
@property (nonatomic,strong)NSString *store_name;
@property (nonatomic,strong)NSString *begin_time;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *buy_way;
@property (nonatomic,strong)NSString *goods_price;
@property (nonatomic,strong)NSString *goods_oprice;
@property (nonatomic,strong)NSString *goods_dingjin;
@property (nonatomic,strong)NSString *goods_baseprice;
@property (nonatomic,strong)NSString *homes;
@property (nonatomic,strong)NSMutableArray *imagesAD;
@property (nonatomic,strong)NSString *info;
@property (nonatomic,strong)NSString *mark;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *flag;
@property (nonatomic,strong)NSString *issue_time;
@property (nonatomic,strong)NSString *user_time;
@property (nonatomic,strong)NSString *order_num;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,assign)CGFloat heightLabel;


@property (nonatomic,strong)NSString *goods_weikuan;
@property (nonatomic,strong)NSString *use_time;
@property (nonatomic,strong)NSString *image_url;
@property (nonatomic,assign)NSInteger end_status;
@property (nonatomic,strong)NSString *end_status_desc;

@end


@interface NSOrder : NSObject

@property (nonatomic,strong)NSString *order_id;
@property (nonatomic,strong)NSString *order_no;
@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *order_code;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *dingjin_time;
@property (nonatomic,assign)NSInteger order_status;
@property (nonatomic,strong)NSString *order_status_desc;
@property (nonatomic,assign)NSInteger refund_status;
@property (nonatomic,strong)NSString *refund_desc;
@property (nonatomic,strong)NSString *qrcode;
@property (nonatomic,strong)NSInfoFind *good;


@end




















