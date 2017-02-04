//
//  SNSPost.h
//  SNS
//
//  Created by Kenta Yokota on 2/5/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSPost : NSObject

@property (nonatomic, assign) CGFloat confidence;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *picture_url;
@property (nonatomic, assign) BOOL rea_ju;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
