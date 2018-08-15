//
//  UIColor+Config.h
//  CRM_New
//
//  Created by changxu on 2018/8/9.
//  Copyright © 2018年 changxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Config)
/**
 *  @author jhx
 *
 *  生成随机颜色
 *
 *  @return 返回随机颜色
 */
+(UIColor *)colorRandom;

/**
 *  根据RGB色值获取颜色
 *
 *  @param red   红色值
 *  @param green 绿色值
 *  @param blue  蓝色值
 *  @param alpha 透明度
 *
 *  @return 返回带透明度的RGB颜色
 */
+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 *  根据RGB色值获取颜色
 *
 *  @param red   红色值
 *  @param green 绿色值
 *  @param blue  蓝色值
 *
 *  @return 返回RGB颜色
 */
+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue;

/**
 *  根据十六进制获取颜色
 *
 *  @param hexValue   十六进制数
 *  @param alphaValue 透明度
 *
 *  @return 返回带透明度的十六进制颜色
 */
+ (UIColor *)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue;

/**
 *  根据十六进制获取颜色
 *
 *  @param hexValue 十六进制数
 *
 *  @return 返回十六进制颜色
 */
+ (UIColor *)colorWithHex:(NSString *)hexValue;
@end
