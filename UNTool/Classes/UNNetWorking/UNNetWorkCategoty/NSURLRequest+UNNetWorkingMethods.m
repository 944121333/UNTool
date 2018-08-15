//
//  NSURLRequest+UNNetWorkingMethods.m
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import "NSURLRequest+UNNetWorkingMethods.h"
#import <objc/runtime.h>
static void *UNNetworkingRequestParams;

@implementation NSURLRequest (UNNetWorkingMethods)
- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &UNNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &UNNetworkingRequestParams);
}

@end
