//
//  NSTalk.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/25.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSTalk.h"



@implementation NSTalk

- (instancetype)init {
    self = [super init];
    if (self) {
        self.images_url = [NSArray array];
        self.commends = [NSMutableArray array];
        self.tableViewHeight = 0;
        self.infoTableViewHeight = 0;
        self.images = @"";
        self.member_id = @"";
        self.member_avar = @"";
        self.member_name = @"";
        self.info = @"";
        self.talk_id = @"";
        self.home = @"";
        self.add_time = @"";
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

@implementation NSTalkCommentObject

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end











