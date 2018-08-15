//
//  UNAES.h
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UNAES : NSObject
+(NSData *)AES256ParmEncryptWithKey:(NSString *)key Encrypttext:(NSData *)text;   //加密
+(NSData *)AES256ParmDecryptWithKey:(NSString *)key Decrypttext:(NSData *)text;   //解密
+(NSString *) aes256_encrypt:(NSString *)key Encrypttext:(NSString *)text;
+(NSString *) aes256_decrypt:(NSString *)key Decrypttext:(NSString *)text;
@end
