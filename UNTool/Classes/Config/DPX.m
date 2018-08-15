//
//  DPX.m
//  CRM_New
//
//  Created by changxu on 2018/8/9.
//  Copyright © 2018年 changxu. All rights reserved.
//

#import "DPX.h"
#import <UIKit/UIKit.h>
CGFloat un_scale() {
    static dispatch_once_t onceToken;
    static CGFloat scale = 1.0f;
    dispatch_once(&onceToken, ^{
        scale = [[UIScreen mainScreen] bounds].size.height / 667.0f;
    });
    return  scale;
}

int DPX(int x) {
    return un_scale() * x;
}

