//
//  ObjectTool.h
//  haoshuimian365
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 CYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface ObjectTool : NSObject

+(NSDictionary *)dictionaryWithObject:(id)obj;

/**  将obj转换成json */
+ (NSString *)objectToJson:(id)obj;

/**  将json转换成obj */
+(id)jsonToObject:(NSString *)json;

//校验手机号
+(BOOL)checkPhoneNumber:(NSString *)phone;

//校验身份证号
+(BOOL)checkIDCardNumber:(NSString *)content;


@end

