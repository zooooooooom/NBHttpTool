//
//  NBHttpTool.h
//  网络请求测试
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFNetworking;

typedef NS_ENUM(NSUInteger, NBHttpType) {
    NBHttpTypeGET,
    NBHttpTypePOST,
};

@interface NBHttpTool : NSObject

- (void)setTimeOut:(NSTimeInterval)timeInterval;

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)HeaderField;

/**
 网络请求的封装

 @param requestType 请求类型(枚举值)
 @param urlStr 请求地址
 @param param 请求参数
 @param resultBlock 请求结果
 */
- (void)request:(NBHttpType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param resultBlock: (void(^)(id responseObject, NSError *error))resultBlock;

- (void)cancel;


@end
