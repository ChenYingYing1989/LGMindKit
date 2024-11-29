//
//  LGCalculateTool.h
//  LGSanofiPatient
//
//  Created by 陈莹莹 on 2022/10/11.
//  计算工具类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGCalculateTool : NSObject
//验证身份证号
+(BOOL)checkCardIDCorrected:(NSString *)cardID;

//根据身份证号获取年龄
+(NSString *)ageWithCardID:(NSString *)cardID;

//根据出生年月日获取年龄
+(NSString *)ageWithBirthDay:(NSString *)date;

//日期转星期几
+(NSString *)weekdayWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
