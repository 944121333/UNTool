//
//  Foundtion+UNKit.m
//  CRM_New
//
//  Created by changxu on 2018/8/9.
//  Copyright © 2018年 changxu. All rights reserved.
//

#import "Foundtion+UNKit.h"

#define CHECK_VALID_STRING(__aString) (__aString && [__aString isKindOfClass:[NSString class]] && [__aString length])

#define CHECK_VALID_DATA(__aData) (__aData && [__aData isKindOfClass:[NSData class]] && [__aData length])

#define CHECK_VALID_NUMBER(__aNumber) (__aNumber && [__aNumber isKindOfClass:[NSNumber class]])

#define CHECK_VALID_ARRAY(__aArray) (__aArray && [__aArray isKindOfClass:[NSArray class]] && [__aArray count])

#define CHECK_VALID_DICTIONARY(__aDictionary) \
(__aDictionary && [__aDictionary isKindOfClass:[NSDictionary class]] && [__aDictionary count])

#define CHECK_VALID_SET(__aSet) (__aSet && [__aSet isKindOfClass:[NSSet class]] && [__aSet count])

#define CHECK_VALID_DELEGATE(__aDelegate, __aSelector) (__aDelegate && [__aDelegate respondsToSelector:__aSelector])

NSInteger UNInt(id obj, NSInteger defaultValue)
{
    if ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])
        return [obj integerValue];


    return defaultValue;
}

double FLDouble(id obj, double defaultValue)
{
    if ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])
        return [obj doubleValue];

    return defaultValue;
}

float FLFloat(id obj, float defaultValue)
{
    if ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])
        return [obj floatValue];

    return defaultValue;
}

BOOL FLBool(id obj, BOOL defaultValue)
{
    if ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])
        return [obj boolValue];

    return defaultValue;
}

NSString * FLString(NSString * value, NSString * defaultString)
{
    if (CHECK_VALID_STRING(value))
        return value;

    if (defaultString && ![defaultString isKindOfClass:[NSString class]])
    {
        defaultString = @"";
    }

    return defaultString;
}

NSArray * FLArray(NSArray * obj, NSArray * defaultValue)
{
    if (CHECK_VALID_ARRAY(obj))
        return obj;

    if (defaultValue && ![defaultValue isKindOfClass:[NSArray class]])
    {
        defaultValue = @[];
    }


    return defaultValue;
}

NSDictionary * FLDictionary(NSDictionary * obj, NSDictionary * defaultValue)
{
    if (CHECK_VALID_DICTIONARY(obj))
        return obj;

    if (defaultValue && ![defaultValue isKindOfClass:[NSDictionary class]])
    {
        defaultValue = @{};
    }

    return defaultValue;
}

NSNumber * FLNumber(NSNumber * obj, NSNumber * defaultValue)
{
    if (CHECK_VALID_NUMBER(obj))
        return obj;

    if (defaultValue && ![defaultValue isKindOfClass:[NSNumber class]])
    {
        defaultValue = @(0);
    }

    return defaultValue;
}

NSString * FLStringSlice(NSString * string, NSUInteger begin, NSUInteger length)
{
    @try
    {
        string = FLNonNilString(string);

        if (begin < string.length && length > 0)
        {
            length = MIN(length, string.length - begin);

            return [string substringWithRange:NSMakeRange(begin, length)];
        }
        else
        {
            return @"";
        }
    }
    @catch (NSException *exception) {
        //QN_E(@"failed to slice string(%td), begin %td, %td, %@", string.length, begin, length, exception);
        return @"";
    }
}

NSArray * FLArraySlice(NSArray * array, NSUInteger begin, NSUInteger length)
{
    @try
    {
        array = FLNonNilArray(array);

        NSArray * ret = nil;

        if (begin < [array count] && length > 0)
        {
            NSUInteger len = MIN([array count] - begin, length);
            ret = [array subarrayWithRange:NSMakeRange(begin, len)];
        }

        return FLNonNilArray(ret);
    }
    @catch (NSException *exception)
    {
        //QN_E(@"failed to slice array(%td), begin %td, %td, %@", array.count, begin, length, exception);
        return @[];
    }
}

