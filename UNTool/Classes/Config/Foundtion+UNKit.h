//
//  Foundtion+UNKit.h
//  CRM_New
//
//  Created by changxu on 2018/8/9.
//  Copyright © 2018年 changxu. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifdef __cplusplus
extern "c" {
#endif


    NSInteger UNInt(id obj,NSInteger defaultValue);
    double FLDouble(id obj, double defaultValue);
    float FLFloat(id obj, float defaultValue);
    BOOL FLBool(id obj, BOOL defaultValue);
    NSString * FLString(NSString * value, NSString * defaultString);

    NSArray * FLArray(NSArray * obj, NSArray * defaultValue);
    NSDictionary * FLDictionary(NSDictionary * obj, NSDictionary * defaultValue);
    NSNumber * FLNumber(NSNumber * obj, NSNumber * defaultValue);
    NSString * FLStringSlice(NSString * string, NSUInteger begin, NSUInteger length);
    NSArray * FLArraySlice(NSArray * array, NSUInteger begin, NSUInteger length);


    static inline NSString * FLNonNilString(NSString * obj)
    {
        return [obj isKindOfClass:[NSString class]] ? obj : @"";
    }
    static inline NSArray * FLNonNilArray(NSArray * obj)
    {
        return [obj isKindOfClass:[NSArray class]] ? obj : @[];
    }

    static inline NSDictionary * FLNonNilDictionary(NSDictionary * obj)
    {
        return [obj isKindOfClass:[NSDictionary class]] ? obj : @{};
    }

    static inline NSString * FLDirectoryPathString(NSString * dirPath)
    {
        if (dirPath.length == 0)
            return dirPath;
        if ([dirPath hasSuffix:@"/"])
            return dirPath;
        else
            return [dirPath stringByAppendingString:@"/"];
    }


#ifdef __cplusplus
}
#endif
