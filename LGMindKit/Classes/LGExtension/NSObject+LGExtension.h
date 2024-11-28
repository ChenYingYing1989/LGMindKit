//
//  NSObject+LGExtension.h
//  EducationCollection
//
//  Created by mac on 2021/4/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    appType_FC,
    appType_YHJK,
    appType_HX,
} appType;

@interface NSObject (LGExtension)

/**
 *  判断对象是否为空
 *  PS：nil、NSNil、@""、@0 以上4种返回YES
 *
 *  @return YES 为空  NO 为实例对象
 */
+ (BOOL)isNullOrNilWithObject:(id)object;

//日期转成周几
+(NSString *)dateToWeek:(NSString *)date;

+(UIWindow *)mainWindow;

//是否是房颤患者
+(BOOL)isAFPatient:(NSString *)diseaseCode;

//APP类型：房颤、圆荷健康、华西（华小芯、心康管家）
+(NSString *)appType:(NSString *)diseaseCode;

@end

NS_ASSUME_NONNULL_END
