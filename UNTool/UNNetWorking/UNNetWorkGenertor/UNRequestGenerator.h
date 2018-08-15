//
//  UNRequestGenerator.h
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNEncrptionContext.h"
@interface UNRequestGenerator : NSObject
+ (instancetype)shardInstance;
- (NSURLRequest *)generateRequestParams:(NSDictionary *)requestParams
                             methodName:(NSString *)methodName
                              encrption:(UNEncrptionBaseClass *)encrption
                       seviceIdentifice:(NSString *)identifice;
@end
