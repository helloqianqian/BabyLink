//
//  CCLocationManager.h
//  MMLocationManager
//
//  Created by WangZeKeJi on 14-12-10.
//  Copyright (c) 2014年 Chen Yaoqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define  CCLastLongitude @"CCLastLongitude"
#define  CCLastLatitude  @"CCLastLatitude"
#define  CCLastCity      @"CCLastCity"
#define  CCLastAddress   @"CCLastAddress"

typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate);
typedef void (^LocationErrorBlock) (NSError *error);
typedef void(^NSStringBlock)(NSString *cityString);
typedef void(^NSStringBlock)(NSString *addressString);

typedef void(^PlacemarkBlock)(CLPlacemark *placemark);

@interface CCLocationManager : NSObject<CLLocationManagerDelegate>
@property (nonatomic) CLLocationCoordinate2D lastCoordinate;
@property(nonatomic,strong)NSString *lastCity;
@property (nonatomic,strong) NSString *lastAddress;

@property(nonatomic,assign)float latitude;
@property(nonatomic,assign)float longitude;


+ (CCLocationManager *)shareLocation;

/**
 *  获取坐标
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock ;

/**
 *  获取坐标和详细地址
 *
 *  @param locaiontBlock locaiontBlock description
 *  @param addressBlock  addressBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock;


/**
 *  获取地理信息
 *
 *  @param placemarkBlock <#placemarkBlock description#>
 *  @param addressBlock   <#addressBlock description#>
 */
- (void) getLocationPlacemark:(PlacemarkBlock)placemarkBlock withAddress:(NSStringBlock) addressBlock;
- (void) getLocationPlacemark:(PlacemarkBlock)placemarkBlock withAddress:(NSStringBlock) addressBlock withLocation:(LocationBlock)locationBlock;


/**
 *  获取坐标，详细地址，城市
 *
 *  @param locaiontBlock <#locaiontBlock description#>
 *  @param addressBlock  <#addressBlock description#>
 *  @param getAddress    <#getAddress description#>
 *  @param addressBlock  <#addressBlock description#>
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock)  addressBlock  withCity:(NSStringBlock)cityBlock;
/**
 *  获取详细地址
 *
 *  @param addressBlock addressBlock description
 */
- (void) getAddress:(NSStringBlock)addressBlock;

/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void) getCity:(NSStringBlock)cityBlock;
- (void) getCity:(NSStringBlock)cityBlock withLocation:(LocationBlock)location;
///**
// *  获取城市和定位失败
// *
// *  @param cityBlock  cityBlock description
// *  @param errorBlock errorBlock description
// */
//- (void) getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock;



@end
