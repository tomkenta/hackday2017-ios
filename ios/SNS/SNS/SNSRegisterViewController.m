//
//  ViewController.m
//  SNS
//
//  Created by Kenta Yokota on 2/3/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSRegisterViewController.h"

@interface SNSRegisterViewController ()

@end

@implementation SNSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [UILabel new];
    label.text = @"えすえぬえす";
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
    
//    UIButton *button = [UIButton new];
    FBSDKLoginButton *button = [[FBSDKLoginButton alloc] init];    
    button.width = kCommonDeviceWidth / 2.0f;
    button.height = 30;
    button.y = self.view.centerY + 100;
    button.centerX = self.view.centerX;
    button.layer.borderWidth = 1.0f;
    [button setTitle:@"はじめる" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
///    button.readPermissions = @[@"public_profile", @"user_posts"];
    _loginButton = button;
    _loginButton.readPermissions = @[@"public_profile", @"user_posts"];
    [self.view addSubview:_loginButton];
    [_loginButton addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPushed:(UIButton*)button{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
