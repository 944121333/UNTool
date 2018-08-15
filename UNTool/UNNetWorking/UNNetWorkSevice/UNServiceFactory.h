//
//  UNServiceFactory.h
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNService.h"

@protocol UNServiceDataSource <NSObject>
- (NSDictionary <NSString *,NSString *>*)servicesKindsOfServiceFactory;
@end

@interface UNServiceFactory : NSObject

@property (nonatomic, weak) id <UNServiceDataSource> dataSource;
+ (instancetype)shardInstace;
- (UNService<UNServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
