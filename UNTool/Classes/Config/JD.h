//
//  JD.h
//  CRM_New
//
//  Created by changxu on 2018/8/9.
//  Copyright © 2018年 changxu. All rights reserved.
//  /**< 判断机型 */

#ifndef JD_h
#define JD_h

typedef NS_ENUM(NSInteger, PhoneType) {
    PhoneType4s,
    PhoneType5,
    PhoneType6p,
    PhoneType6,
    PhoneTypeX
};


bool PhoneLevel(PhoneType type);

#define UN_4S PhoneLevel(PhoneType4s)
#define UN_6P PhoneLevel(PhoneType6p)
#define UN_5 PhoneLevel(PhoneType5)
#define UN_6 PhoneLevel(PhoneType6)
#define UN_X PhoneLevel(PhoneTypeX)

#endif /* JD_h */
