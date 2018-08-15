//
//  UNNetBaseManager.m
//  UNTool_Example
//
//  Created by changxu on 2018/8/15.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import "UNNetBaseManager.h"
#import "UNNetWorkProxy.h"
@interface UNNetBaseManager ()

@property (nonatomic, strong) id rawData;
@property (nonatomic, assign) NSInteger requestId;
@end
@implementation UNNetBaseManager
- (void)dealloc {
    [self cancelWithRequestId:_requestId];
}
- (instancetype)init {
    if ([self conformsToProtocol:@protocol(UNNetManagerProtocol)]) {
        self.child = (id <UNNetManagerProtocol>) self;
    } else {
         NSException *exception = [[NSException alloc] initWithName:@"UNNetBaseManager提示" reason:[NSString stringWithFormat:@"%@没有遵循UNNetManagerProtocol协议",self.child] userInfo:nil];
        @throw exception;
    }
    return self;
}
- (void)cancelWithRequestId:(NSInteger)requestId {
    [[UNNetWorkProxy shardInstance] un_cancelRequstWithRequestId:@(requestId)];
}

- (NSDictionary *)fetchDataWithReformer:(id<UNReformerProtocol>)reformer {
    if (reformer == nil) {
        return _rawData;
    } else {
        return [reformer reformDataWithManager:self];
    }
}

- (NSInteger)loadData {
    NSDictionary *params = [self.paramDataSource paramsForManager: self];
    _requestId = [self loadDataWithParams: params];
    return _requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)param {
    __weak typeof (self) weakSelf = self;
    return ([[[UNNetWorkProxy shardInstance] un_postWithParam:param
                                                   methodName:self.child.methodName
                                            serviceIdentifice:self.child.sserviceType
                                                    encrption:[UNEncrptionContext contextWithType:self.child.encrptionType]
                                                 successHanle:^(UNURLResponse *response) {
                                                     __strong typeof (weakSelf) StrongSelf = weakSelf;
                                                     [StrongSelf successData:response];
                                                 } failHandle:^(UNURLResponse *response) {
                                                     __strong typeof (weakSelf) StrongSelf = weakSelf;
                                                     [StrongSelf failData:response];
                                                 }]integerValue]);
}

- (void)successData:(UNURLResponse *)reponse {
    if (reponse.content) {
        self.rawData = reponse.content;
    } else {
        self.rawData = reponse.responseData;
    }
    [self cancelWithRequestId: self.requestId];
    if ([self.validator manager:self isCorrectWithCallBackData:reponse.content]) {
        [self.delegate un_requestSuccess:self];
    }
}

- (void)failData:(UNURLResponse *)reponse {
    [self.delegate un_requestFailed:self];
}
@end
