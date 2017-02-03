//
//  UIColor+KYkit.m
//  SNS
//
//  Created by Kenta Yokota on 2/3/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//


#import "UIColor+KYkit.h"

@implementation UIColor (KYkit)

+ (UIColor *)colorWithDecimalRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [[self class] colorWithDecimalRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithDecimalRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSUInteger)color24 {
    CGFloat r = (color24 >> 16);
    CGFloat g = (color24 >> 8 & 0xFF);
    CGFloat b = (color24 & 0xFF);
    return [[self class] colorWithDecimalRed:r green:g blue:b alpha:1.0f];
}

+ (UIColor *)colorWithHex:(NSUInteger)color24 alpha:(CGFloat)alpha {
    CGFloat r = (color24 >> 16);
    CGFloat g = (color24 >> 8 & 0xFF);
    CGFloat b = (color24 & 0xFF);
    return [[self class] colorWithDecimalRed:r green:g blue:b alpha:alpha];
}


@end
