//
//  HttpManager.h
//  BSBDJ
//
//  Created by mike on 16/1/14.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManager : NSObject

/**
 *  Http  GET 请求
 *
 *  @param URLString  url
 *  @param parameters 请求参数
 *  @param success    请求成功block
 *  @param failure    请求失败block
 */
- (void)getRequestDataWithUrl:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

/**
 *  Http  POST 请求
 *
 *  @param URLString  url
 *  @param parameters 请求参数
 *  @param success    请求成功block
 *  @param failure    请求失败block
 */
- (void)postRequestDataWithUrl:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
