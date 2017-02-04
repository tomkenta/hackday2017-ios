//
//  SettingViewController.m
//  SNS
//
//  Created by Kenta Yokota on 2/4/17.
//  Copyright © 2017 Kenta Yokota. All rights reserved.
//

#import "SNSSettingViewController.h"

@interface SNSSettingViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}
@end

@implementation SNSSettingViewController


//===========================================================================
#pragma mark - Action 自分が宣言したメソッド

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"設定";
//    _rea_juSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    UITableView *settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    //    settingTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    settingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [settingTableView.tableFooterView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:settingTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//===========================================================================
#pragma mark - TableViewDelegate



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        default:
            return 0;
            
            break;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView   {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    int firstSectionHeight = 40;
    int otherSectionHeight = 50;
    
    switch (section) {
        case 0:
            return firstSectionHeight;
            break;
        default:
            return otherSectionHeight;
            break;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"リア充モード";
            break;
//        case 1:
//            return @"通知設定";
//            break;
//        case 2:
//            return @"その他";
//            break;
        default:
            return 0;
            
            break;
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    NSArray *profileTabelsArray = @[@"リア充モード！！"];
    
    if ( [profileTabelsArray[indexPath.section] isKindOfClass:[NSString class]]) {
        cell.textLabel.text = profileTabelsArray[indexPath.section];
        
        if (indexPath.section == 0) {
            _rea_juSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
            _rea_juSwitch.onTintColor = kThemeColor;
            _rea_juSwitch.on = NO;
            cell.accessoryView = _rea_juSwitch;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;            
        }
    }
    
    else if ( [profileTabelsArray[indexPath.section] isKindOfClass:[NSArray class]]) {
        cell.textLabel.text = profileTabelsArray[indexPath.section][indexPath.row];
    }
    // You gotta care about whether just string or array in 2d array unlike when all components is totally array
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section) {
        case 0: {
//            EditProfileViewController *edpvc= [[EditProfileViewController alloc] init];
//            [self.navigationController pushViewController:edpvc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

//-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([indexPath isEqual:[NSIndexPath indexPathForRow:0 inSection:1]]) {
//        return nil;
//    } else {
//        return indexPath;
//    }
//}





@end
