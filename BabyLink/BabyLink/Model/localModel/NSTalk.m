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

@end