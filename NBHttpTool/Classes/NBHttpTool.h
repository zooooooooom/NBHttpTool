//
//  NBHttpTool.h
//  网络请求测试
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSUInteger, NBHttpType) {
    NBHttpTypeGET,
    NBHttpTypePOST,
};

@interface NBHttpTool : NSObject

+ (void)setBaseUrl:(NSString *)baseUrl;

+ (void)setTimeOut:(NSTimeInterval)timeInterval;

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)HeaderField;


/**
 网络请求的封装
 
 @param requestType 请求类型(枚举值)
 @param urlStr 请求地址
 @param param 请求参数
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (NSURLSessionTask *)request:(NBHttpType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/**
 *  取消所有的网络请求
 */
+ (void)cancelAllOperations;


@end
