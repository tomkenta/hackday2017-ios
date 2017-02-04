//
//  AppDelegate.m
//  SNS
//
//  Created by Kenta Yokota on 2/3/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSAppDelegate.h"
#import "SNSRegisterViewController.h"
#import "SNSTabBarManager.h"
#import "SNSTabBarController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "SNSApiClient.h"

@interface SNSAppDelegate ()

@end

@implementation SNSAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.tintColor =  kThemeColor;
    self.tabBarController = [[SNSTabBarManager sharedManager] tabBarController];
    self.window.rootViewController = (UIViewController*)_tabBarController;

    [self.window makeKeyAndVisible];
    
    
   if ([FBSDKAccessToken currentAccessToken]) {
           [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
            startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    KYLog(@"fetched user:%@", result);
                    KYLog(@"access token:%@", [FBSDKAccessToken currentAccessToken].tokenString)
                    KYLog(@"permmsion:%@", [[FBSDKAccessToken currentAccessToken] hasGranted:@"user_posts"] ? @"YES" : @"NO");
                    [[SNSApiClient sharedClient] GET:[FBSDKAccessToken currentAccessToken].tokenString parameters:nil
                                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                                 KYLog(@"responseObject %@",responseObject);
                                            }
                                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                 NSLog(@"error");
                                             }];
                }
            }];
   } else {
       SNSRegisterViewController *rv = [SNSRegisterViewController new];
       [self.tabBarController presentViewController:rv animated:NO completion:nil];
   }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled;
}


@end
