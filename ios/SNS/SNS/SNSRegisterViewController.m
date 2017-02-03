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
    
    UIButton *button = [UIButton new];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
