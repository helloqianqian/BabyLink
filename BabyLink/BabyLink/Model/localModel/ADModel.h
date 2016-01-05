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

@property (nonatomic,strong)NSString *ADID;
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *cover;
@property (nonatomic,strong)NSString *home;
@property (nonatomic,strong)NSString *type;

@end
