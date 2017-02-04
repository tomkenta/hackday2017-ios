//
//  SNSApiClient.h
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SNSApiClient : AFHTTPSessionManager

+ (SNSApiClient *)sharedClient;
+ (NSString *)apiKey;
+ (NSString *)baseURL;

+ (void)cancelAll;

//- (NSURLSessionDataTask *)GET:(NSString *)URLString
//                   parameters:(NSDictionary *)parameters
//                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
//
//- (NSURLSessionDataTask *)POST:(NSString *)URLString
//                    parameters:(NSDictionary *)parameters
//                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
//
//- (NSURLSessionDataTask *)POST:(NSString *)URLString
//                    parameters:(NSDictionary *)parameters
//                      progress:(void (^)(float progress))progress
//     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
//                       success:(void (^)(NSURLSessionDataTask *, id))success
//                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end
