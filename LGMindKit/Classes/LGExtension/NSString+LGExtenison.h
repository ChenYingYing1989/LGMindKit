//
//  NSString+LBKJExtenison.h
// 
//
//

#import <Foundation/Foundation.h>
#import "HeaderFile.h"
@interface NSString (LGExtenison)

@property (readonly) NSString *md5String;
@property (readonly) NSString *sha1String;
@property (readonly) NSString *sha256String;
@property (readonly) NSString *sha512String;

- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

//是否是表情
-(BOOL)isEmoji;

//判断字符串是否为空
-(BOOL)isEmptyString;

//去除字符串中所有空格
-(NSString *)clearEmptyString;


//计算文字的宽、高
-(CGFloat)textWidthWithFont:(UIFont *)font maxHeight:(CGFloat)height;

-(CGFloat)textHeightWithFont:(UIFont *)font maxWidth:(CGFloat)width;

-(CGFloat)textHeightWithFont:(UIFont *)font maxWidth:(CGFloat)width lineSpacing:(CGFloat)spacing;

-(NSMutableAttributedString *)attributeString:(NSDictionary *)attributeDic;
-(NSMutableAttributedString *)attributeString:(NSDictionary *)attributeDic range:(NSRange)range;
-(NSMutableAttributedString *)attributeString:(NSDictionary *)attributeDic lineSpacing:(CGFloat)spacing;
-(NSMutableAttributedString *)attributeString:(NSDictionary *)attributeDic alignment:(NSTextAlignment)aligenment lineSpacing:(CGFloat)spacing;


@end
