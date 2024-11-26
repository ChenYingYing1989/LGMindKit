//
//  JSRSA.h
//  JSEncryptModule
//
//  Created by JetHuang on 07/06/2018.
//

#import <Foundation/Foundation.h>

@interface RSATool : NSObject
// return base64 encoded string
+(NSString *)encryptString:(NSString *)string publicKey:(NSString *)pubKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+(NSString *)decryptString:(NSString *)string publicKey:(NSString *)pubKey;
+(NSString *)decryptString:(NSString *)string privateKey:(NSString *)privKey;

@end
