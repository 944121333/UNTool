//
//  UNServiceFactory.m
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import "UNServiceFactory.h"

@interface UNServiceFactory ()
@property (nonatomic, strong) NSMutableDictionary *serviceSorage;
@end

@implementation UNServiceFactory

- (NSMutableDictionary *)serviceSorage {
    if (_serviceSorage == nil) {
        _serviceSorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceSorage;
}

+ (instancetype)shardInstace {
    static UNServiceFactory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [UNServiceFactory new];
    });
    return instance;
}

//多线程环境可能会引起崩溃，对dataSource加个同步锁
#pragma mark - public methods
- (UNService<UNServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier
{
    @synchronized (self.dataSource) {

        NSAssert(self.dataSource, @"必须提供dataSource绑定并实现servicesKindsOfServiceFactory方法，否则无法正常使用Service模块");

        if (self.serviceSorage[identifier] == nil) {
            self.serviceSorage[identifier] = [self newServiceWithIdentifier:identifier];
        }
        return self.serviceSorage[identifier];

    }
}

#pragma mark - private methods
- (UNService<UNServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier
{
    NSAssert([self.dataSource respondsToSelector:@selector(servicesKindsOfServiceFactory)], @"请实现servicesKindsOfServiceFactory方法");

    if ([[self.dataSource servicesKindsOfServiceFactory]valueForKey:identifier]) {
        NSString *classStr = [[self.dataSource servicesKindsOfServiceFactory]valueForKey:identifier];
        id service = [[NSClassFromString(classStr) alloc]init];
        NSAssert(service, [NSString stringWithFormat:@"无法创建service，请检查servicesKindsOfServiceFactory提供的数据是否正确"],service);
        NSAssert([service conformsToProtocol:@protocol(UNServiceProtocol)], @"你提供的Service没有遵循UNServiceProtocol");
        return service;
    }else {
        NSAssert(NO, @"servicesKindsOfServiceFactory中无法找不到相匹配identifier");
    }

    return nil;
}
@end
