//
//  UIColor+Config.m
//  CRM_New
//
//  Created by changxu on 2018/8/9.
//  Copyright © 2018年 changxu. All rights reserved.
//

#import "UIColor+Config.h"

@implementation UIColor (Config)

+ (UIColor *)colorRandom
{
    return [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
}

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
}

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue
{
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1];
}

+ (UIColor*)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue
{
    char *stopstring;
    long hex = strtol([hexValue cStringUsingEncoding:NSUTF8StringEncoding], &stopstring, 16);
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*)colorWithHex:(NSString *)hexValue{
    char *stopstring;
    long hex = strtol([hexValue cStringUsingEncoding:NSUTF8StringEncoding], &stopstring, 16);
    int r, g, b;
    r = ( 0xff <<16 & hex ) >> 16;
    g = ( 0xff <<8 & hex ) >> 8;
    b = 0xff & hex;
    return [UIColor colorWithRed:(0.0f + r)/255 green:(0.0f + g)/255 blue:(0.0f + b)/255 alpha:1.0];
}

@end
