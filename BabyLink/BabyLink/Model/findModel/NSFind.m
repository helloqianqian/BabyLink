//
//  NSFind.m
//  BabyLink
//
//  Created by 黄倩 on 15/12/4.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSFind.h"

@implementation NSFind

- (instancetype)init {
    self = [super init];
    if (self) {
        _goods_oprice = @"";
        _goods_baseprice = @"";
        _goods_id = @"";
        _images = @"";
        _goods_price = @"";
        _goods_dingjin = @"";
        _order_num = @"";
        _address = @"";
        _store_id = @"";
        _store_name = @"";
        _store_class = @"";
        _position_lo = @"";
        _position_la = @"";
        _image_url = @"";
        _meters = @"";
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end





@implementation NSInfoFind

- (instancetype)init {
    self = [super init];
    if (self) {
        _goods_oprice = @"0";
        _goods_baseprice = @"0";
        _goods_id = @"";
        _imagesAD = [NSMutableArray array];
        _goods_price = @"0";
        _goods_dingjin = @"0";
        _order_num = @"0";
        _mobile = @"";
        _store_id = @"";
        _store_name = @"";
        _goods_name = @"";
        _info = @"";
        _flag = @"";
        _mark = @"";
        _homes = @"";
        _begin_time = @"";
        _end_time = @"";
        _issue_time = @"";
        _user_time= @"";
        _add_time = @"";
        _buy_way = @"";
        _heightLabel = 0;
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end


@implementation NSOrder

- (instancetype)init {
    self = [super init];
    if (self) {
        _order_id = @"";
        _order_no = @"";
        _goods_id = @"";
        _order_code = @"";
        _add_time = @"";
        _dingjin_time = @"";
        _order_status = 0;
        _order_status_desc = @"";
        _refund_desc = @"";
        _refund_status = 0;
        _qrcode = @"";
        _good = [[NSInfoFind alloc] init];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end













