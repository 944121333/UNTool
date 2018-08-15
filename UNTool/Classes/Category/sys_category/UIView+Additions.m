//
//  UIView+Additions.m
//  CRM_New
//
//  Created by changxu on 2018/8/8.
//  Copyright © 2018年 changxu. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (UIView * (^)(void))un_frame: (void(^)(CGRect frame))argument {
    return ^ {
        argument(self.frame);
        return  self;
    };
}

- (CGFloat)un_left {
    return self.frame.origin.x;
}

- (void)setUn_left: (CGFloat)x {
    [self un_frame:^(CGRect frame) {
        frame.origin.x = x;
        self.frame = frame;
    }];
}

- (CGFloat)un_top {
    return self.frame.origin.y;
}

- (void)setUn_top: (CGFloat)y {
    [self un_frame:^(CGRect frame) {
        frame.origin.y = y;
        self.frame = frame;
    }];
}

- (CGFloat)un_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setUn_right: (CGFloat)right {
    [self un_frame:^(CGRect frame) {
        frame.origin.x = right - frame.size.width;
        self.frame = frame;
    }];
}

- (CGFloat)un_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setUn_bottom: (CGFloat)bottom {
    [self un_frame:^(CGRect frame) {
        frame.origin.y = bottom - frame.size.height;
        self.frame = frame;
    }];
}

- (CGFloat)un_centerX {
    return self.center.x;
}

- (void)setUn_centerX:(CGFloat)centerX {
    [self un_frame:^(CGRect frame) {
        self.center = CGPointMake(centerX, self.center.y);
    }];
}

- (CGFloat)un_centerY {
    return self.center.y;
}

- (void)setUn_centerY:(CGFloat)centerY {
    [self un_frame:^(CGRect frame) {
        self.center = CGPointMake(self.center.x, centerY);
    }];
}

- (CGFloat)un_width {
    return self.frame.size.width;
}

- (void)setUn_width:(CGFloat)width {
    [self un_frame:^(CGRect frame) {
        frame.size.width = width;
        self.frame = frame;
    }];
}

- (CGFloat)un_height {
    return self.frame.size.height;
}

- (void)setUn_height:(CGFloat)height {
    [self un_frame:^(CGRect frame) {
        frame.size.height = height;
        self.frame = frame;
    }];
}

- (CGPoint)un_orgin {
    return self.frame.origin;
}

- (void)setUn_orgin:(CGPoint)orgin {
    [self un_frame:^(CGRect frame) {
        frame.origin = orgin;
        self.frame = frame;
    }];
}

- (CGSize)un_size {
    return self.frame.size;
}

- (void)setUn_size:(CGSize)size {
    [self un_frame:^(CGRect frame) {
        frame.size = size;
        self.frame = frame;
    }];
}
@end
