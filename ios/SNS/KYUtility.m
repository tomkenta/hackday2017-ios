//
//  KYUtility.m
//  SNS
//
//  Created by Kenta Yokota on 2/3/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//


#import "KYUtility.h"

@implementation KYUtility

+ (void)alertWithTitle:(NSString*)title message:(NSString*)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    
    [alertController addAction:action];
    
    [[self class] presentViewController:alertController animated:YES completion:nil];
}

@end
