//
//  SNSTabBarManager.h
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SNSTabBarController;

@interface SNSTabBarManager : NSObject
@property (nonatomic, strong) SNSTabBarController * tabBarController;
@property (nonatomic, assign, getter = isTabBarHidden ) BOOL tabBarHidden;

+ (SNSTabBarManager*)sharedManager;

@end
