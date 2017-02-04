//
//  SNSPost.m
//  SNS
//
//  Created by Kenta Yokota on 2/5/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSPost.h"
#import "SNSApiClient.h"

@implementation SNSPost

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        [self updatePropertyWithAttributes:attributes];
        
    }
    return self;
}

- (void)updatePropertyWithAttributes:(NSDictionary *)attributes {
    _confidence = [attributes[@"confidence"] floatValue];
    _name       = attributes[@"name"];
    _text       = attributes[@"text"];
    _time       = [NSDate dateWithTimeIntervalSince1970:[attributes[@"time"] longLongValue]];
    _picture_url = attributes[@"profile_picture"];
    _rea_ju      = [attributes[@"rea_ju"] boolValue];
    
}

+ (NSMutableArray*)loadPosts:(NSString *)accessToken
{
    // タイムラインを取得
    NSMutableArray *posts;
    [[SNSApiClient sharedClient] GET:accessToken
                          parameters:nil
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 KYLog(@"responseObject %@",responseObject);
                                 
                                 NSArray * list = responseObject;
                                 for (NSDictionary *p in list) {
                                     //                                    KYLog(@"responseObject %@",p[@"name"]);
                                     //                                     KYLog(@"responseObject %@",p[@"text"]);

                                     
                                     SNSPost * post = [[SNSPost alloc] initWithAttributes:p];
                                     //                                     KYLog(@"text %@",post.text);
                                     [posts addObject:post];
                                 }
                             }
                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 KYLog(@"error :%@", error);

                                 NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                                      @"http://hogehoge.com", @"picture",
                                                      @"ken", @"name",
                                                      @"最高です", @"text",
                                                      @"12:10", @"time",
                                                      nil];
                                 [posts addObject:dic];
                             }];
    return posts;
}


@end
