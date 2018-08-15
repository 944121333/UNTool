//
//  UNService.h
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UNServiceProtocol <NSObject>

@property (nonatomic, readonly) BOOL isOnline;
@property (nonatomic, readonly) NSString *onlineUrl;
@property (nonatomic, readonly) NSString *offlineUrl;
@optional
- (NSDictionary *)extraParmas;
- (id)Encryption:(id)params;
@end

@interface UNService : NSObject
@property (nonatomic, strong, readonly) NSString *apiBaseUrl;
@property (nonatomic, weak, readonly) id<UNServiceProtocol> child;
- (NSString *)urlGeneratingRuleByMethodName:(NSString *)methodName;
@end
