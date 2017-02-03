//
//  KYUtility.h
//  SNS
//
//  Created by Kenta Yokota on 2/3/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCommonStatusBarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kCommonTabBarHeight        49.0f
#define kCommonNavigationBarHeight 44.0f
#define kCommonCellHeight          52.0f
#define kCommonDeviceWidth         [UIScreen mainScreen].bounds.size.width
#define kCommonDeviceHeight        [UIScreen mainScreen].bounds.size.height

#ifdef DEBUG
#define KYLog(fmt, ...) NSLog((@"%s [Line %d] " fmt),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define KYLogPoint(p) NSLog(@"x:%f, y%f", p.x, p.y);
#define KYLogSize(p)  NSLog(@"w:%f, h:%f", p.width, p.height);
#define KYLogRect(p)  NSLog(@"x:%f, y:%f, w:%f, h:%f", p.origin.x, p.origin.y, p.size.width, p.size.height);
#else
#define KYLog(fmt, ...) ;
#define KYLogPoint(p) ;
#define KYLogSize(p) ;
#define KYLogRect(p) ;
#endif


@interface KYUtility : NSObject


+ (void)alertWithTitle:(NSString*)title message:(NSString*)message;

@end
