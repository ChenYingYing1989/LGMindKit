//
//  ObjectTool.m
//  haoshuimian365
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 CYY. All rights reserved.
//

#import "ObjectTool.h"
@implementation ObjectTool

+ (NSDictionary*)dictionaryWithObject:(id)obj{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //定义存储属性数量的变量
    unsigned int propersCount;
    //指向属性数组的指针，可以访问数组中的所有属性，传入存储属性数量的变量的地址，该方法就会为其赋值
    objc_property_t *propers = class_copyPropertyList([obj class], &propersCount);
    //遍历属性
    for(int i = 0;i < propersCount; i++) {
        
        objc_property_t proper = propers[i];
        //获得字符串类型的属性名
        NSString *properName = [NSString stringWithUTF8String:property_getName(proper)];
        //通过KVC取得属性值
        id value = [obj valueForKey:properName];
        
        if(value == nil) {
            value = [NSNull null];
            
        } else { //如果属性值不为空，则判断属性值类型
            value = [self objectByPropertyValue:value];
        }
        [dict setObject:value forKey:properName];
    }
    return dict;
}

+ (id)objectByPropertyValue:(id)obj {
    //对NSString、NSNumber、NSNull类型的属性值不做处理，直接返回
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]]) {
        return obj;
        //如果是数组类型，则遍历数组查看数组内部是否存在对象类型
    } else if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objArray = obj;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:objArray.count];
        for(int i = 0;i < objArray.count; i++) {
            //嵌套
            [array setObject:[self objectByPropertyValue:[objArray objectAtIndex:i]] atIndexedSubscript:i];
        }
        //返回转化后的数组
        return array;
        //字典类型
    } else if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objDict = obj;
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:[objDict count]];
        for(NSString *key in objDict.allKeys) {
            
            [dict setObject:[self objectByPropertyValue:[objDict objectForKey:key]] forKey:key];
        }
        //返回转化后的字典
        return dict;
    }
    //对象类型等
    return [self dictionaryWithObject:obj];
}

/**  将obj转换成json */
+ (NSString *)objectToJson:(id)obj{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

/**  将json转换成obj */
+(id)jsonToObject:(NSString *)json{
    if (json == nil || json.length == 0) {
        return nil;
    }
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return jsonObject;
}

#pragma mark
#pragma mark ====> 数据校验
//校验手机号
+(BOOL)checkPhoneNumber:(NSString *)phone{
    [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *pattern = @"^1+[3456789]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:phone];
    return isMatch;
}

//校验身份证号
+(BOOL)checkIDCardNumber:(NSString *)content{
    if(content.length != 15 && content.length != 18) {
        return NO;
    }
    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = content.length;
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [content substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [content substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:content
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, content.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:{
            //校验格式
            NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
            NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
            BOOL flag = [identityCardPredicate evaluateWithObject:content];
            if (!flag) {
                return flag;
            }else {
                NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
                NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                NSInteger idCardWiSum = 0;
                for(int i = 0;i < 17;i++){
                    NSInteger subStrIndex = [[content substringWithRange:NSMakeRange(i, 1)] integerValue];
                    NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                    idCardWiSum+= subStrIndex * idCardWiIndex;
                }
                NSInteger idCardMod=idCardWiSum%11;
                NSString * idCardLast= [content substringWithRange:NSMakeRange(17, 1)];
                //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                if(idCardMod==2){
                    if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                    if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]){
                        return YES;
                    }else{
                        return NO;
                    }
                }
            }
        }
        default:
            return NO;
    }
}

@end
