//
//  UNEncrptionBaseClass.h
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UNEncrptionProtocol <NSObject>

@optional
- (NSString *)encrption:(NSString *)key data:(NSString *)data;
- (NSString *)addEncrption:(NSString *)key data:(NSString *)data;
- (NSData *)encrptionData:(NSString *)key data: (NSData *)data;
- (NSData *)addEncrptionData:(NSString *)key data: (NSData *)data;
@end

@interface UNEncrptionBaseClass : NSObject
@property (nonatomic, weak) id <UNEncrptionProtocol> childer;
@end

@interface UNNone : UNEncrptionBaseClass <UNEncrptionProtocol>

@end

@interface UNUNEncrptionAES : UNEncrptionBaseClass <UNEncrptionProtocol>
@end;
