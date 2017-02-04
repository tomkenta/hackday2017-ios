//
//  ViewController.h
//  SNS
//
//  Created by Kenta Yokota on 2/3/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface SNSRegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

