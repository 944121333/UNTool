//
//  UNRequestGenerator.m
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import "UNRequestGenerator.h"
#import <AFNetworking/AFNetworking.h>
#import "NSURLRequest+UNNetWorkingMethods.h"
#import "UNService.h"
#import "UNServiceFactory.h"
#import "UNConfigNetWorking.h"
@interface UNRequestGenerator ()

@property (nonatomic, strong)AFHTTPRequestSerializer *serializer;
@end

@implementation UNRequestGenerator
+ (instancetype)shardInstance {
    static UNRequestGenerator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [UNRequestGenerator new];
    });
    return instance;
}

- (instancetype)init {
    if(self = [super init]) {
        _serializer = [AFHTTPRequestSerializer serializer];
        _serializer.timeoutInterval = [UNConfigNetWorking sharedInstance].apiNetworkingTimeoutSeconds;
        _serializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return self;
}

- (NSURLRequest *)generateRequestParams:(NSDictionary *)requestParams
                             methodName:(NSString *)methodName
                              encrption:(UNEncrptionBaseClass *)encrption
                       seviceIdentifice:(NSString *)identifice {
    UNService *service = [[UNServiceFactory shardInstace] serviceWithIdentifier: identifice];
    NSString *urlString = [service urlGeneratingRuleByMethodName:methodName];
    NSDictionary *totalRequestParams = [self totalRequestParamsByService:service
                                                           requestParams:requestParams];
    NSMutableURLRequest *request =  [self.serializer requestWithMethod:@"POST"
                                                             URLString:urlString
                                                            parameters:totalRequestParams
                                                                 error:NULL];
    if ([UNConfigNetWorking sharedInstance].shouldSetParamsInHTTPBodyButGET) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
        if ([encrption.childer respondsToSelector:@selector(encrptionData:data:)]) {
            request.HTTPBody = [encrption.childer encrptionData:@"" data:request.HTTPBody];
        }
    }
    request.requestParams = requestParams;
    return request;
}

- (NSDictionary *)totalRequestParamsByService:(UNService *)service
                                requestParams:(NSDictionary *)requestParams {
    NSMutableDictionary *totalRequestParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    if ([service.child respondsToSelector:@selector(extraParmas)]) {
        if ([service.child extraParmas]) {
            [[service.child extraParmas] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                                             id  _Nonnull obj,
                                                                             BOOL * _Nonnull stop) {
                [totalRequestParams setObject:obj forKey:key];
            }];
        }
    }
    return [totalRequestParams copy];
}

@end
