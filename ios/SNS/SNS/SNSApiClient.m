//
//  SNSApiClient.m
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSApiClient.h"

@implementation SNSApiClient

+ (SNSApiClient *)sharedClient {
        static id sharedClient;
        @synchronized (self) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:[[self class] baseURL]]];
            });
        }
    return sharedClient;
}

+ (NSString *)apiKey {
    return nil;
}

+ (NSString *)baseURL {
    return @"https://esu-enu-esu.herokuapp.com/api/facebook/statuses";
}

+ (void)cancelAll {
    [[[self sharedClient] operationQueue] cancelAllOperations];
    for (NSURLSessionDataTask* task in [[self sharedClient] tasks]) {
        [task cancel];
    }
}



@end
