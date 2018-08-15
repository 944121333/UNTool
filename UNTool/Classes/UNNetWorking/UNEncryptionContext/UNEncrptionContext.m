//
//  UNEncrptionContext.m
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import "UNEncrptionContext.h"
NSString *classType[] = {
    [EncrptionType_None] = @"UNNone",
    [EncrptionType_AES256] = @"UNAES"
};
@implementation UNEncrptionContext
+ (UNEncrptionBaseClass *)contextWithType:(EncrptionType)type {
    NSString *string = classType[type];
    Class class = NSClassFromString(string);
    UNEncrptionBaseClass *base = [[class alloc] init];
    return base;
}

@end
