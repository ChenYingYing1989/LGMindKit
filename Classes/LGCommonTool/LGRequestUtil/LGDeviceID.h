//
//  LGDeviceID.h
//  haoshuimian
//
//  Created by apple on 16/9/12.
//  Copyright © 2016年 CYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGDeviceID : NSObject

+(NSString *)getPasswordForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;

+(BOOL) storeUsername: (NSString *) username andPassword: (NSString *) password forServiceName: (NSString *)serviceName updateExisting: (BOOL) updateExisting error: (NSError **) error;

+(BOOL) deleteItemForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;

+(void)saveUUID;

+(NSString *)getIOSUUID;

//+(NSString *)getSystemVersion;

+(NSString *)getDeviceModel;

@end
