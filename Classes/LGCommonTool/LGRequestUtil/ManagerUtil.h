//
//  ManagerUtil+ManagerUtil.h
//  chebaoSimple
//
//  Created by HERUNLIN on 15/7/27.
//  Copyright (c) 2015年 leiyi. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface ManagerUtil : NSObject

+(AFHTTPSessionManager *)buildManager;

+(AFHTTPSessionManager *)buildManagerWithKey:(NSString *)key;

@end
