//
//  JD.m
//  CRM_New
//
//  Created by changxu on 2018/8/9.
//  Copyright © 2018年 changxu. All rights reserved.
//
#include <sys/sysctl.h>
#import <Foundation/Foundation.h>
#import "JD.h"

NSString *PhoneTypeString[] = {
    [PhoneType4s] = @"iPhone4,1",
    [PhoneType5]  = @"iPhone5,1",
    [PhoneType6p] = @"iPhone7,1",
    [PhoneType6]  = @"iPhone7,2",
    [PhoneTypeX]  = @"iPhone10,3",
};

NSString* PhoneTypeCu(void) {

    static dispatch_once_t onceToken;
    static NSString *platform;
    dispatch_once(&onceToken, ^{
        int mib[2];
        size_t len;
        char *machine;
        mib[0] = CTL_HW;
        mib[1] = HW_MACHINE;
        sysctl(mib, 2, NULL, &len, NULL, 0);
        machine = malloc(len);
        sysctl(mib, 2, machine, &len, NULL, 0);
        platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
             free(machine);
    });
    return platform;
}

bool PhoneLevel(PhoneType type) {
    return [PhoneTypeCu() isEqualToString: PhoneTypeString[type]];
}
