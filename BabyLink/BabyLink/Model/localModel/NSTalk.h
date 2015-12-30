//
//  NSTalk.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/25.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTalk : NSObject
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *talk_id;
@property (nonatomic,strong)NSString *home;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *info;
@property (nonatomic,strong)NSString *member_name;
@property (nonatomic,strong)NSString *member_avar;
@property (nonatomic,strong)NSString *images;
@property (nonatomic,strong)NSArray *images_url;
@property (nonatomic,strong)NSMutableArray *commends;
@property (nonatomic,assign)CGFloat tableViewHeight;
@property (nonatomic,assign)CGFloat infoTableViewHeight;
@property (nonatomic,strong)NSString *talk_num;
@end


@interface NSTalkCommentObject : NSObject
@property (nonatomic,strong)NSString *commend_id;
@property (nonatomic,strong)NSString *talk_id;
@property (nonatomic,strong)NSString *info;
@property (nonatomic,strong)NSString *add_time;
@property (nonatomic,strong)NSString *from_id;
@property (nonatomic,strong)NSString *to_id;
@property (nonatomic,strong)NSString *from_name;
@property (nonatomic,strong)NSString *from_avar;
@property (nonatomic,strong)NSString *to_name;
@property (nonatomic,strong)NSString *to_avar;
@property (nonatomic,assign)NSInteger indexRow;
@property (nonatomic,assign)CGFloat cellHeight;
@end

