//
//  NSXiu.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/28.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSXiu.h"

@implementation NSXiu
- (instancetype)init {
    self = [super init];
    if (self) {
        self.xiu_id = @"";
        self.member_id = @"";
        self.home = @"";
        self.add_time = @"";
        self.info = @"";
        self.image = @"";
        self.flag = @"";
        self.time = @"";
        self.member_avar = @"";
        self.member_name = @"";
        self.image_url = @"";
        self.commends = [NSMutableArray array];
        self.zans = [NSMutableArray array];
        self.isZan = false;
        
        if (MainScreenWidth == 320) {
            self.cellHeight = 414;
        } else if (MainScreenWidth == 375) {
            self.cellHeight = 469;
        } else {
            self.cellHeight = 508;
        }
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end

@implementation NSXiuZan

- (instancetype)init {
    self = [super init];
    if (self) {
        self.xiu_id = @"";
        self.member_id = @"";
        self.add_time = @"";
        self.member_avar = @"";
        self.member_name = @"";
        self.zan_id = @"";
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end


@implementation NSXiuComment


- (instancetype)init {
    self = [super init];
    if (self) {
        self.xiu_id = @"";
        self.member_id = @"";
        self.add_time = @"";
        self.info = @"";
        self.member_avar = @"";
        self.member_name = @"";
        self.commend_id = @"";
        self.position_x = 0;
        self.position_y = 0;
        self.infoWidth = 0;
        self.infoHeight = 0;
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end