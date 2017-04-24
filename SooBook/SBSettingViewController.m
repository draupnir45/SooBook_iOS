//
//  SettingViewController.m
//  SooBook
//
//  Created by 홍정기 on 2017. 4. 7..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBSettingViewController.h"
#import "SBLogInViewController.h"

@interface SBSettingViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property UISwitch *autoLoginSwich;
@property BOOL switchState;
@end

@implementation SBSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"설정";
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]] ;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 52;
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return  @"로그인 설정";
            break;
        case 1:
            return  @"soobook";
            break;
            
        default:
            break;
    }return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString *cellTitle;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SBAuthCenter *center = [SBAuthCenter sharedInstance];
            cellTitle = [NSString stringWithFormat:@"%@님 환영합니다!",center.userNickName];
            cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.detailTextLabel.text = center.userID;
        } else if (indexPath.row == 1) {
            
            UISwitch *autoLoginSwich = [[UISwitch alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
            [autoLoginSwich addTarget:self action:@selector(autoLoginSwich:) forControlEvents:UIControlEventValueChanged];
            [autoLoginSwich setOn:!([[NSUserDefaults standardUserDefaults]boolForKey:@"onOff"])];
            
            [cell setAccessoryView:autoLoginSwich];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cellTitle = @"자동 로그인";
            
        } else {
            cellTitle = @"로그아웃";
        }
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            UILabel *label = [[UILabel alloc] init];
            label.text = @"0.1.1";
            label.textColor = [UIColor grayColor];
            [label setTextAlignment:NSTextAlignmentRight];
            [label setFrame:CGRectMake(0, 0, 40, 30)];
            cell.accessoryView = label;
            [label setTextColor:[UIColor grayColor]];
            
            cellTitle = @"버전정보";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cellTitle = @"SooBook for iOS GitHub";
        }
    }
    cell.textLabel.text = cellTitle;
    
    return cell;
}

- (void)autoLoginSwich:(UISwitch *)sender
{
    
    if ([sender isOn])
    {
        NSLog(@"on");
        [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"onOff"];
        
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:![sender isOn] forKey:@"onOff"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERTOKEN_KEY];
        
        NSLog(@"off");
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section)
    {
        case 0: //로그인 설정
            switch (indexPath.row)
        {
            case 0:
            case 1:
                //자동로그인 부분
                
                break;
                
            case 2:
                //로그아웃 부분
                
                [self showLogoutAlertController];
                break;
        }
            
            
        case 1: //SOOBOOK
            switch (indexPath.row)
        {
            case 0:
                //버전정보 부분
                
                break;
                
            case 1:
                //SooBook for iOS GutHub
                
                break;
        }
    }
}

- (void)showLogoutAlertController
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"로그아웃 하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak SBSettingViewController *weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [[SBAuthCenter sharedInstance] logOut];
                           [weakSelf.tabBarController setSelectedIndex:0];
                       });
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
