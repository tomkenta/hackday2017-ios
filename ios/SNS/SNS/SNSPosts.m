//
//  YOPosts.m
//  SNS
//
//  Created by Kenta Yokota on 2/5/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSPosts.h"
#import "SNSPost.h"
#import "SNSApiClient.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation SNSPosts

+ (SNSPosts *)sharedPosts {
    static id sharedPosts;
    @synchronized (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedPosts = [[self alloc] init];
        });
    }
    return sharedPosts;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
            [[SNSApiClient sharedClient] GET:[FBSDKAccessToken currentAccessToken].tokenString
                                  parameters:nil
                                     success:^(NSURLSessionDataTask *task, id responseObject) {
                                         KYLog(@"responseObject %@",responseObject);
                                         
                                         NSArray * list = responseObject;
                                         for (NSDictionary *p in list) {
                                             //                                    KYLog(@"responseObject %@",p[@"name"]);
                                             //                                     KYLog(@"responseObject %@",p[@"text"]);
                                             
                                             SNSPost * post = [[SNSPost alloc] initWithAttributes:p];
                                             KYLog(@"text %@",post.text);
                                             [self.posts addObject:post];
                                             KYLog(@"text %@",self.posts[0]);
                                             
                                         }
                                     }
                                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         KYLog(@"error :%@", error);
                        
                                     }];
        
    }
    return self;
}

@end
