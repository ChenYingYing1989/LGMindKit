//
//  NSObject+LGExtension.m
//  EducationCollection
//
//  Created by mac on 2021/4/6.
//

#import "NSObject+LGExtension.h"

@implementation NSObject (LGExtension)

+ (BOOL)isNullOrNilWithObject:(id)object;{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@(0)]) {
            return NO;
        } else {
            return NO;
        }
    }
    
    return NO;
}

+(UIWindow *)mainWindow{
    id appDelegate = [UIApplication sharedApplication].delegate;
    if(appDelegate && [appDelegate respondsToSelector:@selector(window)]){
        return [appDelegate window];
    }
    NSArray *windows = [UIApplication sharedApplication].windows;
    if([windows count] == 1){
        return [windows firstObject];
        
    }else{
        for (UIWindow *window in windows) {
            if(window.windowLevel == UIWindowLevelNormal){
                return window;
            }
        }
    }
    return nil;
}

//日期转成周几
+(NSString *)dateToWeek:(NSString *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSDate *currentDate = [formatter dateFromString:date];
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:currentDate];
    NSInteger weekDay = [component weekday];
    return weekArray[weekDay-1];
}

//diseaseCode：1-房颤 、 5-房颤 、 2-肺癌 、 3、6-肺结节 、 4-食管癌 、7-心康管家
+(BOOL)isAFPatient:(NSString *)diseaseCode{
    NSString *code = LGNSString(diseaseCode);
    if ([code isEqualToString:@"1"] || [code isEqualToString:@"5"] || [code isEqualToString:@"7"]) {
        return YES;
    }
    return NO;
}

//diseaseCode：1-房颤 、 5-房颤 、 2-肺癌 、 3、6-肺结节 、 4-食管癌 、7-心康管家
+(NSString *)appType:(NSString *)diseaseCode{
    NSString *code = LGNSString(diseaseCode);
    if ([code isEqualToString:@"1"] || [code isEqualToString:@"5"]) {
        //心律助手 - 房颤
        return @"XLZS";
    }else if ([code isEqualToString:@"2"] || [code isEqualToString:@"3"] || [code isEqualToString:@"6"]){
        //圆荷健康 - 癌症
        return @"YHJK";
    }else{
        //华西 - 华小芯、心康管家
        return @"HX";
    }
}

@end
