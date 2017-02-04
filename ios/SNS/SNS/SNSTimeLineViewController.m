//
//  SNSTimeLineViewController.m
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSTimeLineViewController.h"
#import "SNSTimeLineCell.h"
#import "SNSApiClient.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface SNSTimeLineViewController () <UITableViewDataSource, UITableViewDelegate,SNSTimeLineCellDelegate>

@end

@implementation SNSTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ホーム";
    
    // UITableViewの設定
    [self.tableView registerClass:[SNSTimeLineCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.hidden = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self loadPosts:[FBSDKAccessToken currentAccessToken].tokenString];
    
    
    
    // TWTRLogInButtonの設定
//    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
//        if (error) {
//            NSLog(@"Error : %@", error);
//        } else {
//            NSLog(@"UserName : %@", session.userName);
//            self.logInButton.hidden = YES;
//            self.tableView.hidden = NO;
//            [self loadTweets:session.userID];
//        }
//    }];
//    logInButton.center = self.view.center;
//    self.logInButton = logInButton;
//    [self.view addSubview:logInButton];
}

//- (void)loadTweets:(NSString *)userId
- (void)loadPosts:(NSString *)accessToken
{
    // タイムラインを取得
    [[SNSApiClient sharedClient] GET:accessToken
                          parameters:nil
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 KYLog(@"responseObject %@",responseObject);
                             }
                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 KYLog(@"error :%@", error);
                             }];

}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SNSTimeLineCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    [cell configureWithTweet:self.posts[indexPath.row]];
    [cell configureWithPost:self.posts[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.posts[indexPath.row];
    return [[SNSTimeLineCell class] cellHeightForObject:object];
}

@end
