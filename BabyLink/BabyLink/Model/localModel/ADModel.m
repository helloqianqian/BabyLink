//
//  ADModel.m
//  LeDoingHome
//     _   _____   _____                _____   _____   __   _
//    | | |  _  \ |  _  \      /\      /  ___| /  _  \ |  \ | |
//    | | | | | | | |_| |     /  \    | |      | | | | |   \| |
// _  | | | | | | |  _  /    / /\ \   | | ____ | | | | | |\   |
//| |_| | | |_| | | | \ \   / /__\ \  | |__| | | |_| | | | \  |
//\_____/ |_____/ |_|  \_\ /_/    \_\  \_____/ \,___,/ |_|  \_|
//  Created by JDragon on 15/9/28.
//  Copyright (c) 2015年 黄倩. All rights reserved.
//

#import "ADModel.h"


@implementation ADModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ADID = key;
    }
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.cover = @"";
    }
    return self;
}
@end
