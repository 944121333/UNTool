//
//  UNEncrptionBaseClass.m
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import "UNEncrptionBaseClass.h"
#import "UNAES.h"
@implementation UNEncrptionBaseClass

- (instancetype)init {
    self = [super init];
    if (self && [self conformsToProtocol: @protocol(UNEncrptionProtocol)]) {
        self.childer = (id <UNEncrptionProtocol>)self;
    } 
    return self;
}

@end

@implementation UNNone

@end

@implementation UNUNEncrptionAES

- (NSString *)encrption:(NSString *)key data:(NSString *)data {
    return [UNAES aes256_decrypt:key Decrypttext:data];
}

- (NSString *)addEncrption:(NSString *)key data:(NSString *)data {
    return [UNAES aes256_encrypt:key Encrypttext:data];
}

- (NSData *)encrptionData:(NSString *)key data:(NSData *)data {
    return [UNAES AES256ParmDecryptWithKey:key Decrypttext:data];
}

- (NSData *)addEncrptionData:(NSString *)key data:(NSData *)data {
    return [UNAES AES256ParmEncryptWithKey:key Encrypttext:data];
}
@end
