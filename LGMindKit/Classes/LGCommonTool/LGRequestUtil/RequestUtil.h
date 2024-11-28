//
//  RequestUtil+RequestUtil.h
//  chebaoSimple
//
//  Created by HERUNLIN on 15/7/26.
//  Copyright (c) 2015年 leiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestUtil :NSObject
/**  POST请求 */
+(void)withPOST:(NSString *)action
     parameters:(id)parameters
       withSign:(BOOL)sign
        success:(void (^)(id responseData))success
        failure:(void (^)(NSError *error))failure;

+(void)withPOST:(NSString *)action
     parameters:(id)parameters
       withSign:(BOOL)sign
        success:(void (^)(NSInteger code ,NSString *message, id returnData))success
        error:(void (^)(NSError *error))errorMsg;


+(void)mockPOST:(NSString *)action
     parameters:(id)parameters
       withSign:(BOOL)sign
        success:(void (^)(NSInteger code ,NSString *message, id returnData))success
        error:(void (^)(NSError *error))errorMsg;


/**  上传多张图片 */
+(void)uploadImage:(NSString *)action
         parameters:(id)parameters
           withSign:(BOOL)sign
          indexName:(NSString *)name
         imageArray:(NSArray *)imageArray
            success:(void (^)(id responseData))success
            failure:(void (^)(NSError *error))failure;

+(void)uploadVoice:(NSString *)action
         parameters:(id)parameters
           withSign:(BOOL)sign
          voiceData:(NSArray *)dataArray
            success:(void (^)(id responseData))success
            failure:(void (^)(NSError *error))failure;

/**  上传单张图片 */
+ (NSURLSessionDataTask *)uploadSingleImage:(NSString *)action
                               params:(NSDictionary *)params
                            indexName:(NSString *)name
                        image:(UIImage *)image
                              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**  上传语音 */
+ (NSURLSessionDataTask *)uploadVioce:(NSString *)URLString
                             withSign:(BOOL)withSign
                               params:(NSDictionary *)params
                            indexName:(NSString *)name
                            voiceData:(NSData *)data
                              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//下载文件
+(void)downloadFileWithFileUrl:(NSString *)url;

/**  webView请求 */
+(NSURLRequest *)postRequestWebviewWithAction:(NSString *)action withParams:(NSDictionary *)params;

+(NSString *)javaScriptStringWithAction:(NSString *)action withParams:(NSDictionary *)params;


+ (NSString *)webSignWithDic:(NSDictionary *)dic;
//获取时间戳
+(NSString *)timestampString;
@end
