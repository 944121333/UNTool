//
//  UNNetWorkProxy.h
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLRequest+UNNetWorkingMethods.h"
#import "UNEncrptionContext.h"

@class UNURLResponse;

typedef void(^UNNetWorkSourceResultHandle) (UNURLResponse *response);

#define UNUSEDMETHOD(method) __attribute__((unavailable (method))
#define UNSubClassing __attribute__((objc_subclassing_restricted))

@interface UNNetWorkProxy : NSObject

+ (instancetype)shardInstance;
- (NSNumber *)un_postWithParam: (NSDictionary *)params
                    methodName: (NSString *)methodName
             serviceIdentifice: (NSString *)identifice
                     encrption:(UNEncrptionBaseClass *)encrpitonClass
                 successHanle: (UNNetWorkSourceResultHandle)successHandle
                   failHandle: (UNNetWorkSourceResultHandle)failHandle;

- (void)un_cancelRequstWithRequestId: (NSNumber *)requestId;

+ (instancetype)alloc UNUSEDMETHOD("shardInstance"));
- (instancetype)init  UNUSEDMETHOD("shardInstance"));
@end

typedef NS_ENUM(NSUInteger, UNURlResponseStatus) {
    UNURLResponseStausSuccess,
    UNURLResponseStatusErrorTimeout,
    UNUrlResponseStatusNoNetwork
};

@interface UNURLResponse : NSObject

@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, copy, readonly) id content;
@property (nonatomic, copy, readonly) NSDictionary *requestParams;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, assign, readonly) BOOL isCache;
@property (nonatomic, assign, readonly) UNURlResponseStatus status;
@property (nonatomic, strong, readonly) NSError *error;

- (instancetype)initWithResponseString: (NSString *)responseString
                             requestId: (NSNumber *)requestId
                               request: (NSURLRequest *)request
                          responseData: (NSData *)responseData
                                status: (UNURlResponseStatus)status;

- (instancetype)initWithResponseString: (NSString *)responseString
                             requestId: (NSNumber *)requestId
                               request: (NSURLRequest *)request
                          responseData: (NSData *)responseData
                                 error: (NSError *)error;

- (instancetype)initWithData:(NSData *)data;
@end
