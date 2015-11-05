//
//  ADModel.h
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

#import <Foundation/Foundation.h>

@interface ADModel : NSObject

@property(nonatomic,strong) NSString *ads_name;
@property(nonatomic,assign) NSInteger ads_type;
@property(nonatomic,strong) NSString *ads_url;
@property(nonatomic,strong) NSString *media_url;
@property(nonatomic,strong) NSString *ads_content;
@property(nonatomic,strong) NSString *start_time;
@property(nonatomic,strong) NSString *end_time;


@end
