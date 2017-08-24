//
//  YOPosts.h
//  SNS
//
//  Created by Kenta Yokota on 2/5/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSPosts : NSObject

@property (nonatomic, strong) NSMutableArray * posts;

+ (SNSPosts *)sharedPosts;
@end
