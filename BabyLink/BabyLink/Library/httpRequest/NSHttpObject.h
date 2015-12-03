//
//  NSHttpObject.h
//  BabyLink
//
//  Created by 黄倩 on 15/11/17.
//  Copyright © 2015年 黄倩. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)(id error);
typedef void (^NetWorkBlock)(int netConnetState);
typedef void (^resultBlock)(id resultValue);

@interface NSHttpObject : NSObject

+(instancetype)shareInstance;

+ (void)NetRequestPostWithUrl:(NSString *)urlString
                withParameter:(NSDictionary *)parameter
              withReturnBlock:(ReturnValueBlock)returnBlock
               withErrorBlock:(ErrorCodeBlock)errorBlock
             withFailureBlock:(FailureBlock)failureBlock;

+ (void)NetRequestGetWithUrl:(NSString *)urlString
               withParameter:(NSDictionary *)param
             withReturnValue:(ReturnValueBlock) returnBlock
                   withError:(ErrorCodeBlock)errorBlock
            withFailureBlock:(FailureBlock)failureBlock;

+(void)upLoadImagewithUrl:(NSString *)urlString
            withParameter:(NSDictionary *)parameter
               withResult:(resultBlock)resultBlock
         withFailureBlock:(FailureBlock)failureBlock
       withUploadProgress:(void (^)(float progress))progressBlock;

+(void)upLoadImagewithUrl:(NSString *)urlString
            withDataArray:(NSArray *)imageDataArray
               withResult:(resultBlock)resultBlock
         withFailureBlock: (FailureBlock) failureBlock
       withUploadProgress:(void (^)(float progress))progressBlock;

@end
