//
//  UNNetBaseManager.h
//  UNTool_Example
//
//  Created by changxu on 2018/8/15.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNEncrptionContext.h"

@class UNNetBaseManager;

/**< 回掉代理 */
@protocol UNNetManagerDelegate <NSObject>
@required
- (void)un_requestSuccess:(UNNetBaseManager *)manager;
- (void)un_requestFailed:(UNNetBaseManager *)manager;
@end

/**< 解析代理 */
@protocol UNReformerProtocol <NSObject>
- (NSDictionary *)reformDataWithManager:(UNNetBaseManager *)manager;
@end

/**< 数据源 */
@protocol UNManagerParamSourceProtocol <NSObject>
@required
- (NSDictionary *)paramsForManager:(UNNetBaseManager *)manager;
@end

/**< 子类遵守协议 */
@protocol UNNetManagerProtocol <NSObject>
- (NSString *)methodName;
- (NSString *)sserviceType;
- (EncrptionType)encrptionType;
@end

@protocol UNApiManagerValidator <NSObject>
- (BOOL)manager:(UNNetBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;

@end

@interface UNNetBaseManager : NSObject

@property (nonatomic, weak) id <UNNetManagerDelegate> delegate;
@property (nonatomic, weak) id <UNManagerParamSourceProtocol> paramDataSource;
@property (nonatomic, weak) id <UNNetManagerProtocol> child;
@property (nonatomic, weak) id <UNApiManagerValidator>validator;
@property (nonatomic, assign, readonly) NSInteger requestId;

- (NSDictionary *)fetchDataWithReformer:(id<UNReformerProtocol>)reformer;
- (void)cancelWithRequestId:(NSInteger)requestId;
- (NSInteger)loadData;
@end
