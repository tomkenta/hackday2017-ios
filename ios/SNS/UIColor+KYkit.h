//
//  UIColor+KYkit.h
//  SNS
//
//  Created by Kenta Yokota on 2/3/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KYkit)
    + (UIColor *)colorWithDecimalRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
    + (UIColor *)colorWithDecimalRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
    + (UIColor *)colorWithHex:(NSUInteger)color24;
    + (UIColor *)colorWithHex:(NSUInteger)color24 alpha:(CGFloat)alpha;
@end
