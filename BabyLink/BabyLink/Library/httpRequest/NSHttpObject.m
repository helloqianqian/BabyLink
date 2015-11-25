//
//  NSHttpObject.m
//  BabyLink
//
//  Created by 黄倩 on 15/11/17.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import "NSHttpObject.h"
#import "Reachability.h"

@interface NSHttpObject()
@property (nonatomic,strong)Reachability *reachability;

@end

@implementation NSHttpObject


+(instancetype)shareInstance {
    static NSHttpObject *_httpObject = nil ;
    static dispatch_once_t oncePredicate;
    _dispatch_once(&oncePredicate, ^{
        _httpObject = [[NSHttpObject alloc] init];
        [_httpObject checkReachability];
    });
    return _httpObject;
}


- (void)checkReachability
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    [self updateInterfaceWithReachability:self.reachability];
    
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability * curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}
- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    int  net = 0;
    if(status == NotReachable)
    {
        //No internet
        NSLog(@"No Internet");
        net = 0;
    }
    else if (status == ReachableViaWiFi)
    {
        //WiFi
        NSLog(@"Reachable WIFI");
        net = 1;
    }
    else if (status == ReachableViaWWAN)
    {
        //3G
        NSLog(@"Reachable 3G");
        net=  [NSHttpObject checkNetWorkLocalType];
    }
//    if (_netBlock) {
//        [SoapHelp shareInstance].netBlock(net);
//    }
}
+(int)checkNetWorkLocalType
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    int state = 0;
    int netType ;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    //                    state = @"无网络";
                    state = 0;
                    //无网模式
                    break;
                case 1:
                    //                    state = @"2G";
                    state =2;
                    
                    break;
                case 2:
                    //                    state = @"3G";
                    state = 3;
                    break;
                case 3:
                    //                    state = @"4G";
                    state = 4;
                    break;
                case 5:
                {
                    //                    state = @"WIFI";
                    state = 1;
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}


+ (void)NetRequestGetWithUrl:(NSString *)urlString
               withParameter:(NSDictionary *)param
             withReturnValue:(ReturnValueBlock) returnBlock
                   withError:(ErrorCodeBlock)errorBlock
            withFailureBlock: (FailureBlock) failureBlock{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    AFHTTPRequestOperation *op = [manager GET:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        returnBlock(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
}

+ (void)NetRequestPostWithUrl:(NSString *)urlString
                withParameter:(NSDictionary *)parameter
              withReturnBlock:(ReturnValueBlock)returnBlock
               withErrorBlock:(ErrorCodeBlock)errorBlock
             withFailureBlock: (FailureBlock) failureBlock{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    AFHTTPRequestOperation *op = [manager POST:urlString parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        returnBlock(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
}

+(void)upLoadImagewithUrl:(NSString *)urlString
            withParameter:(NSDictionary *)parameter
               withResult:(resultBlock)resultBlock
         withFailureBlock: (FailureBlock) failureBlock
       withUploadProgress:(void (^)(float progress))progressBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager  alloc]init];
    
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSUserInfo shareInstance].member_id forKey:@"member_id"];
    AFHTTPRequestOperation *op = [manager POST:urlString  parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = [parameter objectForKey:@"imageData"];
        NSString *name = [parameter objectForKey:@"imageName"];
        NSString *fileName = [parameter objectForKey:@"fileName"];
        
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"jpg/png/jpeg/gif"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progress = ((float)totalBytesWritten) / totalBytesExpectedToWrite;
        progressBlock(progress);
    }];
}
@end
