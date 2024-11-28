//
//
//

#import "NSString+LGExtenison.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
@implementation NSString (LGExtenison)

- (NSString *)md5String{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(NSInteger)length{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}


//是否是表情
- (BOOL)isEmoji{
    const unichar high = [self characterAtIndex:0];
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff && self.length >= 2){
        const unichar low = [self characterAtIndex:1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        // Not surrogate pair (U+2100-27BF)
    }else{
        return (0x2100 <= high && high <= 0x27bf);
    }
}

//判断字符串是否为空
-(BOOL)isEmptyString{
    if (self == nil) {
        return YES;
    }
    if (self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([self isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([[self clearEmptyString] length] == 0) {
        return YES;
    }
    return NO;
}

//清空字符串中的空白字符
- (NSString *)clearEmptyString{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark
#pragma mark ====> 计算文字宽高
//计算文字宽度
-(CGFloat)textWidthWithFont:(UIFont *)font maxHeight:(CGFloat)height{
    if(self.length == 0) return 0;
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width;
}
//计算文字高度
-(CGFloat)textHeightWithFont:(UIFont *)font maxWidth:(CGFloat)width{
    if(self.length == 0) return 0;
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}
//计算带行间距的文字高度
-(CGFloat)textHeightWithFont:(UIFont *)font maxWidth:(CGFloat)width lineSpacing:(CGFloat)spacing{
    CGSize size = CGSizeZero;
    if (![self isEmptyString]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        if (spacing>0) {
            NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
            paraStyle.lineSpacing = spacing;
            [tempDic setValue:paraStyle forKey:NSParagraphStyleAttributeName];
        }
        size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tempDic context:nil].size;
    }
    return size.height;
}


-(NSMutableAttributedString *)attributeString:(NSDictionary *)attributeDic{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:self];
    [attString addAttributes:attributeDic range:NSMakeRange(0, self.length)];
    return attString;
}

-(NSMutableAttributedString *)attributeString:(NSDictionary *)attributeDic range:(NSRange)range{
    if(self.length>0){
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:self];
        [attString addAttributes:attributeDic range:range];
        return attString;
    }else{
        return [[NSMutableAttributedString alloc] init];
    }
}

-(NSMutableAttributedString *)attributeString:(NSDictionary *)attributeDic lineSpacing:(CGFloat)spacing{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attString addAttributes:attributeDic range:NSMakeRange(0, self.length)];
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    return attString;
}

-(NSMutableAttributedString *)attributeString:(NSDictionary *)attributeDic alignment:(NSTextAlignment)aligenment lineSpacing:(CGFloat)spacing{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = spacing;
    paragraphStyle.alignment = aligenment;
    [attString addAttributes:attributeDic range:NSMakeRange(0, self.length)];
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    return attString;
}

@end
