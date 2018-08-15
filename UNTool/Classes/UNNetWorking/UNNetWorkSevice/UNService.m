//
//  UNService.m
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import "UNService.h"

@implementation UNService

- (NSString *)urlGeneratingRuleByMethodName:(NSString *)methodName {
    return [NSString stringWithFormat:@"%@/%@", self.apiBaseUrl, methodName];;
}

- (NSString *)apiBaseUrl {
    return self.child.isOnline ? self.child.onlineUrl : self.child.offlineUrl;
}
@end
