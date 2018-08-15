//
//  UNNormalSevice.m
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import "UNNormalSevice.h"
#import "UNConfigNetWorking.h"
@implementation UNNormalSevice

- (BOOL)isOnline {
    return [UNConfigNetWorking sharedInstance].serviceIsOnline;
}

- (NSString *)onlineUrl {
    return @"";
}

- (NSString *)offlineUrl {
    return @"";
}
@end
