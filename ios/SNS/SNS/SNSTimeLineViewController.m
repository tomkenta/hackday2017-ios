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
#import "SNSPost.h"
#import "SNSPosts.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface SNSTimeLineViewController () <UITableViewDataSource, UITableViewDelegate,SNSTimeLineCellDelegate>

@end

@implementation SNSTimeLineViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ホーム";
    
    
    // UITableViewの設定
    //self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[SNSTimeLineCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]  style:UITableViewStylePlain];
;
    self.tableView.hidden = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = kSNSBackgroundColor;

    
    self.posts = [[NSMutableArray alloc] initWithCapacity:100];
    KYLog("%@",[FBSDKAccessToken currentAccessToken].tokenString)
    [self loadPosts:[FBSDKAccessToken currentAccessToken].tokenString]; ////todo tokenがない場合はおちる
    [self.tableView reloadData];

    [self.view addSubview:self.tableView];
    
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
                                 
                                 NSArray * list = responseObject;
                                 NSMutableArray * posts = [NSMutableArray new];
                                 for (NSDictionary *p in list) {
//                                    KYLog(@"responseObject %@",p[@"name"]);
                                     //                                     KYLog(@"responseObject %@",p[@"text"]);
                                     
                                     SNSPost * post = [[SNSPost alloc] initWithAttributes:p];
//                                     KYLog(@"text %@",post.text);
                                     [posts addObject:post];
                                 }
                                 self.posts = posts;
                                 [self.tableView reloadData];
                             }
                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 KYLog(@"error :%@", error);
                                 NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                                      @"http://hogehoge.com", @"picture",
                                                      @"ken", @"name",
                                                      @"最高です", @"text",
                                                      @"12:10", @"time",
                                                      nil];
                                 [self.posts addObject:dic];
                             }];

}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KYLog(@"count :%d", [self.posts count]);
    return [self.posts count];
//    return 3;

}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    SNSTimeLineCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    [cell configureWithPost:self.posts[indexPath.row]];
//    return cell;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    SNSTimeLineCell *cell;
    
//      cellIdentifier = NSStringFromClass([SNSTimeLineCell class]);
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = (SNSTimeLineCell *)[[[SNSTimeLineCell class] alloc] initWithReuseIdentifier:cellIdentifier delegate:self];
        }

    [cell configureWithPost:self.posts[indexPath.row]];
//    [cell configureWithPost:[SNSPosts sharedPosts].posts[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.posts[indexPath.row];
    return [[SNSTimeLineCell class] cellHeightForObject:object];
}

@end
