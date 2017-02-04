//
//  SNSTimeLineViewController.m
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSTimeLineViewController.h"

@interface SNSTimeLineViewController () <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;

@end

@implementation SNSTimeLineViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    // UITableViewの設定
//    [self.tableView registerClass:[TWTRTweetTableViewCell class] forCellReuseIdentifier:@"Cell"];
//    self.tableView.hidden = YES;
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    
//    // TWTRLogInButtonの設定
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
//}
//
//- (void)loadTweets:(NSString *)userId
//{
//    // タイムラインを取得
//    NSString *endpoint = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
//    NSDictionary *parameters = @{};
//    NSError *error = nil;
//    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:userId];
//    NSURLRequest *request = [client URLRequestWithMethod:@"GET"
//                                                     URL:endpoint
//                                              parameters:parameters
//                                                   error:&error];
//    if (error) {
//        NSLog(@"Error: %@", error);
//        return;
//    }
//    __weak typeof(self) weakSelf = self;
//    [client sendTwitterRequest:request
//                    completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                        if (connectionError) {
//                            NSLog(@"Error: %@", error);
//                            return;
//                        }
//                        NSError *jsonError = nil;
//                        id jsonData = [NSJSONSerialization JSONObjectWithData:data
//                                                                      options:NSJSONReadingMutableContainers
//                                                                        error:&jsonError];
//                        if (jsonError) {
//                            NSLog(@"Error: %@", jsonError);
//                            return;
//                        }
//                        weakSelf.tweets = [TWTRTweet tweetsWithJSONArray:jsonData];
//                        [weakSelf.tableView reloadData];
//                    }];
//}

#pragma mark - UITableView
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.tweets count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    TWTRTweetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    [cell configureWithTweet:self.tweets[indexPath.row]];
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [TWTRTweetTableViewCell heightForTweet:self.tweets[indexPath.row] width:self.tableView.bounds.size.width];
//}

@end
