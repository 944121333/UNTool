//
//  JustFont.m
//  CRM_New
//
//  Created by changxu on 2018/8/9.
//  Copyright © 2018年 changxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JustFont.h"
#import "DPX.h"

#define IsIphone6P UN_WIDTH == 414

static inline CGFloat sizeScale() {
    static dispatch_once_t onceToken;
    static CGFloat scale = 1.0f;
    dispatch_once(&onceToken, ^{
        if (IsIphone6P) {
            scale = 1.5;
        } else {
            scale = 1.0f;
        }
    });
    return scale;
}

CGFloat JFX(CGFloat x) {
    return x * sizeScale();
}

