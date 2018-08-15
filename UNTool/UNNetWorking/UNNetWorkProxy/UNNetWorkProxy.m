//
//  UNNetWorkProxy.m
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import "UNNetWorkProxy.h"
#import <AFNetworking/AFNetworking.h>
#import "UNRequestGenerator.h"

@interface UNNetWorkProxy()

@property (nonatomic, strong) NSMutableDictionary *dispatch_table;
@property (nonatomic, strong) NSNumber *recorderdRequestId;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation UNNetWorkProxy

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _sessionManager;
}

+ (instancetype)shardInstance {
    static UNNetWorkProxy *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[UNNetWorkProxy _alloc] _init];
    });
    return _instance;
}

- (instancetype)_init {
    if (self = [super init]) {

    }
    return self;
}

+ (instancetype)_alloc {
    return [self allocWithZone:NSDefaultMallocZone()];
}

- (void)un_cancelRequstWithRequestId: (NSNumber *)requestId {
    NSURLSessionTask *requestTask =self.dispatch_table[requestId];
    [requestTask cancel];
    [self.dispatch_table removeObjectForKey: requestId];
}

- (NSNumber *)un_postWithParam:(NSDictionary *)params
                    methodName:(NSString *)methodName
             serviceIdentifice:(NSString *)identifice
                     encrption:(UNEncrptionBaseClass *)encrpitonClass
                  successHanle:(UNNetWorkSourceResultHandle)successHandle
                    failHandle:(UNNetWorkSourceResultHandle)failHandle {
    NSURLRequest *request = [[UNRequestGenerator shardInstance] generateRequestParams:params
                                                                           methodName:methodName
                                                                            encrption:encrpitonClass
                                                                     seviceIdentifice:identifice];
   return [self callApiWithRequest:request
                           success:successHandle
                              fail:failHandle];
}
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request
                         success:(UNNetWorkSourceResultHandle)success
                            fail:(UNNetWorkSourceResultHandle) fail {

    __block NSURLSessionTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request
                                      completionHandler:^(NSURLResponse * _Nonnull response,
                                                          id  _Nullable responseObject,
                                                          NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatch_table removeObjectForKey:requestID];
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        if (error) {
            UNURLResponse *responce = [[UNURLResponse alloc] initWithResponseString:responseString
                                                                          requestId:requestID
                                                                            request:request
                                                                       responseData:responseData
                                                                              error:error];
            fail?fail(responce):nil;
        } else {
            UNURLResponse *responce = [[UNURLResponse alloc] initWithResponseString:responseString
                                                                          requestId:requestID
                                                                            request:request
                                                                       responseData:responseData
                                                                             status:UNURLResponseStausSuccess];
            success?success(responce):nil;
        }
    }];
    NSNumber *requestId = @([dataTask taskIdentifier]);
    self.dispatch_table[requestId] = dataTask;
    [dataTask resume];
    return requestId;
}

- (NSMutableDictionary *)dispatch_table {
    if (_dispatch_table == nil) {
        _dispatch_table = [NSMutableDictionary dictionaryWithCapacity: 6];
    }
    return _dispatch_table;
}
@end

@interface UNURLResponse()
@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) NSString *contentString;
@property (nonatomic, copy) NSData *responseData;
@property (nonatomic, copy) id content;
@property (nonatomic, copy) NSDictionary *requestParams;
@property (nonatomic, assign) NSInteger requestId;
@property (nonatomic, assign) BOOL isCache;
@property (nonatomic, assign) UNURlResponseStatus status;
@property (nonatomic, strong) NSError *error;
@end

@implementation UNURLResponse

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(UNURlResponseStatus)status
{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        self.error = nil;
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        self.error = error;
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData
                                                           options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}

#pragma mark - private methods
- (UNURlResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        UNURlResponseStatus result = UNUrlResponseStatusNoNetwork;

        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = UNURLResponseStatusErrorTimeout;
        }
        return result;
    } else {
        return UNURLResponseStausSuccess;
    }
}

@end
