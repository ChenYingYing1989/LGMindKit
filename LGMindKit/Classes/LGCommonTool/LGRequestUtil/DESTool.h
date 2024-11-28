//
//  DESTool.h
//  RedSunDigitalDoctor
//
//  Created by 1234 on 2022/7/25.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
NS_ASSUME_NONNULL_BEGIN

@interface DESTool : NSObject
+(NSString *)encryptString:(NSString *)string withKey:(NSString *)key;
+(NSString *)decryptString:(NSString *)string withKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
