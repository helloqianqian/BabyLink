//
//  NSExchange.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/26.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSExchange.h"

@implementation NSExchange

- (instancetype)init {
    self = [super init];
    if (self) {
        _member_id=@"";
        _exchange_id=@"";
        _home=@"";
        _from_gname=@"";
        _to_gname=@"";
        _add_time=@"";
        _info=@"";
        _member_name=@"";
        _member_avar=@"";
        _ing_time=@"";
        _end_time=@"";
        _status=@"";
        _role=@"";
        _link_exchange_id=@"";
        _image_url=@"";
        _link_name = @"";
        _link_mobile=@"";
        _link_avar = @"";
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end







