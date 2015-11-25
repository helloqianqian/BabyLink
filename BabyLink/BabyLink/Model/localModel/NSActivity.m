//
//  NSActivity.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/23.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSActivity.h"

@implementation NSActivity

@end



@implementation NSActListObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.logs_list = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end

@implementation NSLogListObject



@end


@implementation NSActInfoObject
/*@property (nonatomic,strong)NSString *activity_address;
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
 @property (nonatomic,strong)NSString *utils;*/
- (instancetype)init {
    self = [super init];
    if (self) {
        self.logs = [NSMutableArray array];
        self.commends = [NSMutableArray array];
        self.activity_address = @"";
        self.activity_id = @"";
        self.add_time = @"";
        self.begin_time = @"";
        self.end_time = @"";
        self.home = @"";
        self.images = [NSArray array];;
        self.info = @"";
        self.is_help = @"0";
        self.help = @"";
        self.jihe_time = @"";
        self.jihe_address = @"";
        self.link_name = @"";
        self.link_mobile = @"";
        self.count = @"";
        self.max_man = @"";
        self.member_id = @"";
        self.member_avar = @"";
        self.member_name = @"";
        self.pay_way = @"";
        self.price = @"";
        self.title = @"";
        self.utils = @"";
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end


@implementation NSCommentObject

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end