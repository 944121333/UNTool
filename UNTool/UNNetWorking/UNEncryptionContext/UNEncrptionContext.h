//
//  UNEncrptionContext.h
//  UNTool_Example
//
//  Created by changxu on 2018/8/14.
//  Copyright © 2018年 z65Begin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNEncrptionBaseClass.h"
typedef NS_ENUM(NSInteger, EncrptionType) {
    EncrptionType_None,
    EncrptionType_AES256
};

@interface UNEncrptionContext : NSObject

@property (nonatomic, assign, readonly) EncrptionType type;
+ (UNEncrptionBaseClass *)contextWithType:(EncrptionType)type;
@property (nonatomic, strong) UNEncrptionBaseClass *curClass;
@end

