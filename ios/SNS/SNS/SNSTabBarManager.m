//
//  SNSTabBarManager.m
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSTabBarManager.h"
#import "SNSTabBarController.h"
#import "SNSSettingViewController.h"

@implementation SNSTabBarManager

+(SNSTabBarManager*)sharedManager{
        static id sharedManager;
        @synchronized (self) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                sharedManager = [self new];
            });
        }
        return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIViewController *ViewController1 = [UIViewController new];
        ViewController1.view.backgroundColor = [UIColor grayColor];
        UINavigationController *nv0 = [[UINavigationController alloc] initWithRootViewController:ViewController1];
        
        SNSSettingViewController *vc = [SNSSettingViewController new];
        UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:vc];
        
        

        _tabBarController = [SNSTabBarController new];
        [_tabBarController setViewControllers:@[nv0,nv1]];
        
        [_tabBarController.tabBar.items[0] setTitle:NSLocalizedString(@"ホーム", nil)];
        [_tabBarController.tabBar.items[1] setTitle:NSLocalizedString(@"設定", nil)];
         
    }
    return self;
}

@end
