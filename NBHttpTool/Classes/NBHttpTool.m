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
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation NBHttpTool

static AFHTTPSessionManager *_sessionManager;

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        
        _sessionManager = [AFHTTPSessionManager manager];
        
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];

        [requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

        _sessionManager.requestSerializer = requestSerializer;

        // 自定义响应
        AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        _sessionManager.responseSerializer = responseSerializer;
        
    }
    return _sessionManager;
}

- (void)setTimeOut:(NSTimeInterval)timeInterval
{
    self.sessionManager.requestSerializer.timeoutInterval = timeInterval;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)HeaderField
{
    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:HeaderField];
}

- (void)request:(NBHttpType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param resultBlock: (void(^)(id responseObject, NSError *error))resultBlock
{
    
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultBlock(responseObject, nil);
    };
    
    void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil, error);
    };
    
    if (requestType == NBHttpTypeGET) {
        [self.sessionManager GET:urlStr parameters:param progress:nil success:successBlock failure:failBlock];
    }else {
        [self.sessionManager POST:urlStr parameters:param progress:nil success:successBlock failure:failBlock];
    }
}

- (void)cancel
{
    [self.sessionManager.operationQueue cancelAllOperations];
}



@end

