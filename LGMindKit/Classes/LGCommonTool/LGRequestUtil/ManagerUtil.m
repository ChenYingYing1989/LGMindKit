//
//  ManagerUtil+ManagerUtil.m
//  chebaoSimple
//
//  Created by HERUNLIN on 15/7/27.
//  Copyright (c) 2015年 leiyi. All rights reserved.
//

#import "ManagerUtil.h"
#import "RSATool.h"
#import "HeaderFile.h"
//公钥
#define PublicKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHP3bjYGpDW7ZWgpFEdOwxfJFAPaW1Ks+bo7WjPGtbkW5rHI8eYh7WhIi+jtiCY4s5rnKgnatzyaLhM01jQJ7Jlmymdb4GCR2VwSM16GGGZDjHbAZBr/AD+49TkLZuMi60miemwqNoqFRBAUP4urlwc1R04zz95eHSwRIpGbgydwIDAQAB"

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject;

static AFHTTPSessionManager *manager;

@interface ManagerUtil()

@end

@implementation ManagerUtil 

/**
 * 构建manager
 * @return AFHTTPSessionManager httpSessionManager
 */
+(AFHTTPSessionManager *)buildManager{
    if (manager == nil) {
        //设置和加入头信息
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer setTimeoutInterval:20];//超时时间为20s
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"application/octet-stream",@"application/x-www-form-urlencoded",@"",@"text/plain",nil];
    }
    return manager;
}


/**
 * 构建自定义manager
 * @return AFHTTPSessionManager httpSessionManager
 */
+(AFURLSessionManager *)buildManagerWithKey:(NSString *)key{
    //设置和加入头信息
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
//    request.timeoutInterval= 5.0;
//    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
//    NSString *rsaStr = [RequestUtil randomEncryptedString];
//    [request setValue:rsaStr forHTTPHeaderField:@"APP-TOKEN-KEY"];
//    NSString *desStr = [DESTool encryptString:[ObjectTool objectToJson:param] withKey:@"12kdj478"];
//    NSData *body = [desStr dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:body];
//    AFHTTPSessionManager * custom = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
//
//    custom.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [custom.requestSerializer setTimeoutInterval:20];//超时时间为20s
//
//    custom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"application/octet-stream",@"text/plain",nil];
//
    return manager;
}
@end
