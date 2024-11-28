//
//  RequestUtil+RequestUtil.m
//  chebaoSimple
//
//  Created by HERUNLIN on 15/7/26.
//  Copyright (c) 2015年 leiyi. All rights reserKved.
//

#import "RequestUtil.h"
#import "ManagerUtil.h"
#import "SingleClass.h"
#import "ObjectTool.h"
#import "LGDeviceID.h"
#import "Reachability.h"
#import "RSATool.h"
#import "DESTool.h"
#import "LGNavigationController.h"
#import "MBProgressHUD.h"
@implementation RequestUtil

+(void)withPOST:(NSString *)action parameters:(id)parameters withSign:(BOOL)sign success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //单例类
    SingleClass *single = [SingleClass shareSingleClass];
    NSDictionary *singleDic = @{@"action":action,@"params":parameters};
    BOOL isExist = [single searchObjectWithDic:singleDic];
    if (isExist == NO){
        [single insertObjectWithDic:singleDic];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSMutableURLRequest *request = [RequestUtil requestWithAction:action withParams:parameters withSign:sign];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"application/octet-stream",@"application/x-www-form-urlencoded",@"",@"text/plain",nil];
        manager.responseSerializer = responseSerializer;
        [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [single delegateObjectWithDic:singleDic];
            if (!error) {
                NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
                if([dataDic[@"code"] integerValue] == 401){
                    //token过期--重新登录
//                    [LGLoginManager logoutAction];
                }else{
                    if(success){
                        success(dataDic);
                    }
                }
            }else{
                NSDictionary *dataDic;
                if([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]){
                   dataDic = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:(NSJSONReadingMutableContainers) error:nil];
                }
                NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
                if(dataDic && dataDic.allKeys.count>0){
                    if([dataDic[@"code"] integerValue] == 401){
                        //token过期--重新登录
//                        [LGLoginManager logoutAction];
                    }else{
                        if(success){
                            success(dataDic);
                        }
                    }
                }else if(failure){
                    failure(error);
                }
            }
        }] resume];
    }
}

+(void)withPOST:(NSString *)action parameters:(id)parameters withSign:(BOOL)sign success:(void (^)(NSInteger code ,NSString *message, id returnData))success error:(void (^)(NSError *error))errorMsg{
    //单例类
    SingleClass *single = [SingleClass shareSingleClass];
    NSDictionary *singleDic = @{@"action":action,@"params":parameters};
    BOOL isExist = [single searchObjectWithDic:singleDic];
    if (isExist == NO){
        [single insertObjectWithDic:singleDic];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSMutableURLRequest *request = [RequestUtil requestWithAction:action withParams:parameters withSign:sign];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"application/octet-stream",@"application/x-www-form-urlencoded",@"",@"text/plain",nil];
        manager.responseSerializer = responseSerializer;
        [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [single delegateObjectWithDic:singleDic];
            if (!error) {
                NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
                NSInteger code = [dataDic[@"code"] integerValue];
                if(code == 401){
                    //token过期--重新登录
//                    [LGLoginManager logoutAction];
                }else{
                    if(success){
                        success(code , dataDic[@"msg"] , dataDic[@"data"]);
                    }
                }
            }else{ 
                NSDictionary *dataDic;
                if([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]){
                   dataDic = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:(NSJSONReadingMutableContainers) error:nil];
                }
                if(dataDic && dataDic.allKeys.count>0){
                    NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
                    NSInteger code = [dataDic[@"code"] integerValue];
                    if(code == 401){
                        //token过期--重新登录
//                        [LGLoginManager logoutAction];
                    }else{
                        if(success){
                            success(code , dataDic[@"msg"] , dataDic[@"data"]);
                        }
                    }
                }else if(errorMsg){
                    NSLog(@"action:%@\nparams:%@\nerro:%@",action,parameters,error);
                    errorMsg(error);
                }
            }
        }] resume];
    }
}

//mock测试请求
+(void)mockPOST:(NSString *)action
     parameters:(id)parameters
       withSign:(BOOL)sign
        success:(void (^)(NSInteger code ,NSString *message, id returnData))success
          error:(void (^)(NSError *error))errorMsg{
    //单例类
    SingleClass *single = [SingleClass shareSingleClass];
    NSDictionary *singleDic = @{@"action":action,@"params":parameters};
    BOOL isExist = [single searchObjectWithDic:singleDic];
    if (isExist == NO){
        [single insertObjectWithDic:singleDic];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseUrl,action];
    //    NSData *data = [params d]
//        NSData *body = [[ObjectTool objectToJson:params] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:action]];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod: @"POST"];
//        [request setHTTPBody:body];
//        if(sign == YES){
//            NSDictionary *signDic = [RequestUtil singWithParams:params];
//            [request setValue:signDic[@"Authorization"] forHTTPHeaderField:@"Authorization"];
//            [request setValue:signDic[@"token"] forHTTPHeaderField:@"token"];
//            [request setValue:signDic[@"Timestamp"] forHTTPHeaderField:@"Timestamp"];
//        }
//        return  request;
        
//        NSMutableURLRequest *request = [RequestUtil requestWithAction:action withParams:parameters withSign:sign];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"application/octet-stream",@"application/x-www-form-urlencoded",@"",@"text/plain",nil];
        manager.responseSerializer = responseSerializer;
        [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [single delegateObjectWithDic:singleDic];
            if (!error) {
                NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
                NSInteger code = [dataDic[@"code"] integerValue];
                if(code == 401){
                    //token过期--重新登录
//                    [LGLoginManager logoutAction];
                }else{
                    if(success){
                        success(code , dataDic[@"msg"] , dataDic[@"data"]);
                    }
                }
            }else{
                NSDictionary *dataDic;
                if([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]){
                   dataDic = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:(NSJSONReadingMutableContainers) error:nil];
                }
                NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
                if(dataDic && dataDic.allKeys.count>0){
                    NSInteger code = [dataDic[@"code"] integerValue];
                    if(code == 401){
                        //token过期--重新登录
//                        [LGLoginManager logoutAction];
                    }else{
                        if(success){
                            success(code , dataDic[@"msg"] , dataDic[@"data"]);
                        }
                    }
                }else if(errorMsg){
                    errorMsg(error);
                }
            }
        }] resume];
    }
    
}

//NSMutableURLRequest
+(NSMutableURLRequest *)requestWithAction:(NSString *)action withParams:(NSDictionary *)params withSign:(BOOL)sign{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseUrl,action];
//    NSData *data = [params d]
    NSData *body = [[ObjectTool objectToJson:params] dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:body];
    if(sign == YES){
        NSDictionary *signDic = [RequestUtil singWithParams:params];
        [request setValue:signDic[@"Authorization"] forHTTPHeaderField:@"Authorization"];
        [request setValue:signDic[@"token"] forHTTPHeaderField:@"token"];
        [request setValue:signDic[@"Timestamp"] forHTTPHeaderField:@"Timestamp"];
//        [request setValue:headCode forHTTPHeaderField:@"doctorappcode"];
    }
    return  request;
}

/**  将参数签名 */
+(NSDictionary *)singWithParams:(NSDictionary *)params{
    NSString *timestamp = [RequestUtil timestampString];
    //取key排序
    NSArray *keyArray = params.allKeys;
    NSArray *sortedArray =  [keyArray sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *signStr = [NSMutableString string];
    for (NSString *key in sortedArray) {
        if([params[key] isKindOfClass:[NSDictionary class]]){
            //字典
            NSDictionary *parama2 = params[key];
            NSArray *keyArray2 = parama2.allKeys;
            NSArray *sortedArray2 =  [keyArray2 sortedArrayUsingSelector:@selector(compare:)];
            NSMutableString *signStr2 = [NSMutableString string];
            for (NSString *key2 in sortedArray2){
                [signStr2 appendString:LGNSString(parama2[key2])];
            }
            [signStr appendString:signStr2];
        }else if ([params[key] isKindOfClass:[NSArray class]]){
            //数组
            NSArray *tempArray = params[key];
//            if(tempArray.count == 0) break;
            NSMutableString *signStr3 = [NSMutableString string];
            if(tempArray.count>0){
                if([tempArray[0] isKindOfClass:[NSDictionary class]]){
                    //数组对象 -- [{} 、{}、{}]
                    for (NSDictionary *parama3 in tempArray) {
                        NSArray *keyArray3 = parama3.allKeys;
                        NSMutableString *signStr4 = [NSMutableString string];
                        for (NSString *key3 in keyArray3){
                            [signStr4 appendString:LGNSString(parama3[key3])];
                        }
                        [signStr3 appendString:signStr4];
                    }
                }else{
                    //数组字符串 -- [" " , " " , ""];
                    for (NSString *content in tempArray) {
                        [signStr3 appendString:LGNSString(content)];
                    }
                }
            }else{
                [signStr3 appendString:@""];
            }
            [signStr appendString:signStr3];
        }else{
            [signStr appendString:LGNSString(params[key])];
        }
    }
    [signStr appendString:kToken];
    [signStr appendString:timestamp];
    NSLog(@">>???>>%@",signStr);
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *tempDic = @{@"Authorization":signStr.md5String.lowercaseString , @"token":kToken , @"Timestamp":timestamp,@"APP_VERSION":currentVersion};
    return tempDic;
}



/**  上传图片--Form表单上传 */
+(void)uploadImage:(NSString *)action parameters:(id)parameters withSign:(BOOL)sign indexName:(NSString *)name imageArray:(NSArray *)imageArray success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure{
    //单例类
    SingleClass *single = [SingleClass shareSingleClass];
    NSDictionary *singleDic = @{@"action":action,@"params":parameters};
    BOOL isExist = [single searchObjectWithDic:singleDic];
    if (isExist == NO){
        [single insertObjectWithDic:singleDic];
        AFHTTPSessionManager *manager = [ManagerUtil buildManager];
        NSDictionary *headerDic = nil;
        if(sign == YES){
            headerDic = [RequestUtil singWithParams:parameters];
        }
        [manager POST:action parameters:parameters headers:headerDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
            //for循环上传图片
            for (NSInteger i=0; i<imageArray.count; i++) {
                NSData *imageData = UIImageJPEGRepresentation(imageArray[i], 0.5);
                [formData appendPartWithFileData:imageData name:name fileName:@"pictur.jpeg" mimeType:@"image/jpeg"];
            }
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [single delegateObjectWithDic:singleDic];
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
            if([dataDic[@"code"] integerValue] == 401){
                //token过期--重新登录
//                LGLoginTestController *controller = [[LGLoginTestController alloc]init];
//                [UIApplication sharedApplication].delegate.window.rootViewController = [[LGNavigationController alloc] initWithRootViewController:controller];
            }else{
                if(success){
                    success(dataDic);
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [single delegateObjectWithDic:singleDic];
            NSDictionary *dataDic;
            if([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]){
               dataDic = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:(NSJSONReadingMutableContainers) error:nil];
            }
            NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
            if(dataDic && dataDic.allKeys.count>0){
                if([dataDic[@"code"] integerValue] == 401){
                    //token过期--重新登录
//                    LGLoginTestController *controller = [[LGLoginTestController alloc]init];
//                    [UIApplication sharedApplication].delegate.window.rootViewController = [[LGNavigationController alloc] initWithRootViewController:controller];
                }else{
                    if(success){
                        success(dataDic);
                    }
                }
            }else if(failure){
                failure(error);
            }
        }];
    }
}

/**  上传语音--Form表单上传 */
+(void)uploadVoice:(NSString *)action parameters:(id)parameters withSign:(BOOL)sign voiceData:(NSArray *)dataArray success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure{
    //单例类
    SingleClass *single = [SingleClass shareSingleClass];
    NSDictionary *singleDic = @{@"action":action,@"params":parameters};
    BOOL isExist = [single searchObjectWithDic:singleDic];
    if (isExist == NO){
        [single insertObjectWithDic:singleDic];
        AFHTTPSessionManager *manager = [ManagerUtil buildManager];
        NSDictionary *headerDic = nil;
        if(sign == YES){
            headerDic = [RequestUtil singWithParams:parameters];
        }

        [manager POST:action parameters:parameters headers:headerDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
            //for循环上传图片
            for (NSInteger i=0; i<dataArray.count; i++) {
                [formData appendPartWithFileData:dataArray[i] name:@"audio" fileName:@"audio.m4a" mimeType:@"audio/m4a"];
            }
            
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [single delegateObjectWithDic:singleDic];
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
            if([dataDic[@"code"] integerValue] == 401){
                //token过期--重新登录
//                LGLoginTestController *controller = [[LGLoginTestController alloc]init];
//                [UIApplication sharedApplication].delegate.window.rootViewController = [[LGNavigationController alloc] initWithRootViewController:controller];
            }else{
                if(success){
                    success(dataDic);
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [single delegateObjectWithDic:singleDic];
            NSDictionary *dataDic;
            if([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]){
               dataDic = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:(NSJSONReadingMutableContainers) error:nil];
            }
            NSLog(@"action:%@\nparams:%@\nresult:%@",action,parameters,dataDic);
            if(dataDic && dataDic.allKeys.count>0){
                if([dataDic[@"code"] integerValue] == 401){
                    //token过期--重新登录
//                    LGLoginTestController *controller = [[LGLoginTestController alloc]init];
//                    [UIApplication sharedApplication].delegate.window.rootViewController = [[LGNavigationController alloc] initWithRootViewController:controller];
                }else{
                    if(success){
                        success(dataDic);
                    }
                }
            }else if(failure){
                failure(error);
            }
        }];
    }
}


/**  上传单张图片 */
+ (NSURLSessionDataTask *)uploadSingleImage:(NSString *)URLString
                                   withSign:(BOOL)withSign
                                     params:(NSDictionary *)params
                                  indexName:(NSString *)name
                                      image:(UIImage *)image
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    //单例类
    SingleClass *single = [SingleClass shareSingleClass];
    NSDictionary *singleDic = @{@"action":URLString,@"params":params};
    BOOL isExist = [single searchObjectWithDic:singleDic];
    if (isExist == YES) {
        return nil;
    }else{
        [single insertObjectWithDic:singleDic];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:params];
        [tempDic setObject:[RequestUtil timestampString] forKey:@"timestamp"];
        //对参数签名
        NSDictionary *dic = [NSDictionary dictionary];
        if (withSign) {
//            dic = [self singWithDic:tempDic];
        }else{
            NSString *str = [ObjectTool objectToJson:tempDic];
            dic = [@{@"params":str} mutableCopy];
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseUrl,URLString];
        AFHTTPSessionManager *manager = [ManagerUtil buildManager];
        
        NSURLSessionDataTask *task =  [manager POST:urlStr parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //for循环上传图片
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:@"pictur.jpg" mimeType:@"pictur/jpg"];
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //上传进度
//            NSLog(@">>>%lld--%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
            NSLog(@"upload:%lld--%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [single delegateObjectWithDic:singleDic];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
//            NSLog(@">>>>%@",dataDic);
            NSLog(@"params:%@\nresult:%@",singleDic,dataDic);
            if (success) {
                success(task,dataDic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [single delegateObjectWithDic:singleDic];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (failure) {
//                NSLog(@"error:>>>%@",error);
                NSLog(@"params:%@\nerror:%@",singleDic,error);
//                NSString *tempString = [NSString stringWithFormat:@"%@",error.userInfo];
                //                [SVProgressHUD showErrorWithStatus:tempString];
                
                failure(task,error);
            }
        }];
        
        return task;
    }
    
}


/**  上传语音 */
+(NSURLSessionDataTask *)uploadVioce:(NSString *)URLString
                            withSign:(BOOL)withSign
                              params:(NSDictionary *)params
                           indexName:(NSString *)name
                           voiceData:(NSData *)data
                             success:(void (^)(NSURLSessionDataTask *, id))success
                             failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    if (![RequestUtil isConnectionAvailable]) {
        return nil;
    }
    //单例类
    SingleClass *single = [SingleClass shareSingleClass];
    NSDictionary *singleDic = @{@"action":URLString,@"params":params};
    BOOL isExist = [single searchObjectWithDic:singleDic];
    if (isExist == YES) {
        return nil;
    }else{
        [single insertObjectWithDic:singleDic];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:params];
        [tempDic setObject:[RequestUtil timestampString] forKey:@"timestamp"];
        //对参数签名
        NSDictionary *dic = [NSDictionary dictionary];
        if (withSign) {
//            dic = [self singWithDic:tempDic];
        }else{
            NSString *str = [ObjectTool objectToJson:tempDic];
            dic = [@{@"params":str} mutableCopy];
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseUrl,URLString];
        AFHTTPSessionManager *manager = [ManagerUtil buildManager];
        
        NSURLSessionDataTask *task = [manager POST:urlString parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:data name:name fileName:@"voice.wav" mimeType:@"voice/wav"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
//            NSLog(@">>>%lld--%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
            NSLog(@"upload:%lld--%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [single delegateObjectWithDic:singleDic];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@">>>>%@",dataDic);
            NSLog(@"params:%@\nresult:%@",singleDic,dataDic);
            if (success) {
                success(task,dataDic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [single delegateObjectWithDic:singleDic];
//            NSLog(@">>>>%@",error);
            NSLog(@"params:%@\nerror:%@",singleDic,error);
            if (failure) {
                failure(task,error);
            }
        }];
        return task;
    }
}

+(void)downloadFileWithFileUrl:(NSString *)url{
    NSArray *tempArray = [url componentsSeparatedByString:@"/"];
    NSString *fileName = LGNSString([tempArray lastObject]);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 判断文件夹是否存在
    __block NSString *documentPath = [path stringByAppendingPathComponent:@"document"];
    if(![[[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentPath error:nil] count]){
        [[NSFileManager defaultManager] createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
    } //
    __block NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        //不存在，则下载
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
        NSURLSessionDownloadTask *downloadTask = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return [NSURL fileURLWithPath:filePath];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            if(error){
                NSLog(@"download file failed : %@", [error description]);
            }else{
                NSLog(@"download file success");
            }
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        }];
        [downloadTask resume];
    }
}


#pragma mark
#pragma mark ====> 备用方法
//时间戳
+(NSString *)timestampString{
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld",timestamp];
}
//自动生成8位随机密码
+(NSString *)randomEncryptedString{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomStr = [NSMutableString stringWithCapacity:8];
    for (NSInteger i = 0; i < 8; i++) {
        [randomStr appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)letters.length)]];
    }
    return randomStr;
}


+(NSString *)javaScriptStringWithAction:(NSString *)action withParams:(NSDictionary *)params{
    NSString *urlStr = ([action containsString:@"http"] || [action containsString:@"https"])?action:[NSString stringWithFormat:@"%@%@",BaseUrl,action];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":kUserId}];
    for (NSInteger i=0; i<params.allKeys.count; i++) {
        NSString *key = params.allKeys[i];
        [tempDic setObject:[params objectForKey:key] forKey:key];
    }
    [tempDic setObject:[RequestUtil timestampString] forKey:@"timestamp"];
    NSString *signStr = [RequestUtil webSignWithDic:tempDic];
    NSData *signData = [NSJSONSerialization dataWithJSONObject:@{@"params":signStr} options:(NSJSONWritingPrettyPrinted) error:nil];
    NSString *sssss = [[NSString alloc] initWithData:signData encoding:(NSUTF8StringEncoding)];
    NSString *jscript = [NSString stringWithFormat:@"post('%@', %@);", urlStr, sssss];
    return jscript;
}

/**  获取当前屏幕显示的viewcontroller */
+ (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return result;
}

/**  检测网络是否连接 */
+(BOOL)isConnectionAvailable{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus state = [reach currentReachabilityStatus];
    if (state == NotReachable) {
        //无网络
        return NO;
    }else{
        return YES;
    }
}


/**  AFN的HTTPS验证 */
//+ (AFSecurityPolicy*)customSecurityPolicy{
//    //先导入证书
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server1" ofType:@"cer"];//证书的路径
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//
//    // AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//
//    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
//    // 如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = YES;
//
//    //validatesDomainName 是否需要验证域名，默认为YES；
//    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
//    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
//    //如置为NO，建议自己添加对应域名的校验逻辑。
//    securityPolicy.validatesDomainName = NO;
//
//    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];
//
//    return securityPolicy;
//}


@end
