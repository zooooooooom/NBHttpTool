//
//  NBHttpTool.m
//  网络请求测试
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NBHttpTool.h"
#import "AFNetworking.h"

@interface NBHttpTool()

@end

@implementation NBHttpTool

static AFHTTPSessionManager *_sessionManager;

+ (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:_baseUrl]];
        
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        
        [requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        _sessionManager.requestSerializer = requestSerializer;
        
        // 自定义响应
        AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        _sessionManager.responseSerializer = responseSerializer;
        
    }
    return _sessionManager;
}

static NSString *_baseUrl;
+ (void)setBaseUrl:(NSString *)baseUrl
{
    _baseUrl = baseUrl;
}

+ (void)setTimeOut:(NSTimeInterval)timeInterval
{
    [self sessionManager].requestSerializer.timeoutInterval = timeInterval;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)HeaderField
{
    [[self sessionManager].requestSerializer setValue:value forHTTPHeaderField:HeaderField];
}

+ (NSURLSessionTask *)request:(NBHttpType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure
{
    NSLog(@"%@",[self sessionManager]);
    if (requestType == NBHttpTypeGET) {
        
        NSURLSessionTask *task = [self.sessionManager GET:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        return task;
        
    } else {
        
        NSURLSessionTask *task = [self.sessionManager POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            
        }];
        return task;
    }
}

/**
 *  取消所有的网络请求
 */
+ (void)cancelAllOperations
{
    [[self sessionManager].operationQueue cancelAllOperations];
}


@end

