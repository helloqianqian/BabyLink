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


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end


@implementation NSActInfoObject
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