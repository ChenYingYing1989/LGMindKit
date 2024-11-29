//
//  LGCalculateTool.m
//  LGSanofiPatient
//
//  Created by 陈莹莹 on 2022/10/11.
//  计算工具类

#import "LGCalculateTool.h"

@implementation LGCalculateTool
//验证身份证号
+(BOOL)checkCardIDCorrected:(NSString *)cardID{
    NSString *content = [cardID stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (cardID.length<18) return NO;
    NSString *regxStr = @"^[1-9][0-9]{5}[1-9][0-9]{3}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])[0-9]{3}([0-9]|X|x)$";
    NSPredicate *idcardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regxStr];
    return [idcardTest evaluateWithObject:content];
}

//根据身份证号获取年龄
+(NSString *)ageWithCardID:(NSString *)cardID{
    NSString *age = @"";
    if (cardID.length>=14) {
        NSString *birthday = [cardID substringWithRange:NSMakeRange(6, 8)];
        NSString *year = [birthday substringWithRange:NSMakeRange(0, 4)];
        NSString *mouth = [birthday substringWithRange:NSMakeRange(4, 2)];
        NSString *day = [birthday substringWithRange:NSMakeRange(6, 2)];
        NSMutableString *result = [NSMutableString stringWithCapacity:0];
        [result appendString:year];
        [result appendString:@"-"];
        [result appendString:mouth];
        [result appendString:@"-"];
        [result appendString:day];
        age = [LGCalculateTool ageWithBirthDay:result];
    }
    return age;
}

//根据出生年月日获取年龄
+(NSString *)ageWithBirthDay:(NSString *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *birthday = [formatter dateFromString:date];
    NSTimeInterval interval = [birthday timeIntervalSinceNow];
    int age = trunc(interval/(60*60*24))/365;
    NSString *ageStr = [NSString stringWithFormat:@"%d",-age];
    NSLog(@">>>???>>>%@",ageStr);
    return ageStr;
}


+(NSString *)weekdayWithDate:(NSDate *)date{
    NSArray *weekArray = @[[NSNull null],@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Beijing"];
    [calendar setTimeZone: timeZone];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:date];
    return [weekArray objectAtIndex:component.weekday];
}

@end
