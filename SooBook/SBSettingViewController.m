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
@end

@implementation SBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"설정";
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]] ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
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
            
            UISwitch *autoLoginSwich = [[UISwitch alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
            [autoLoginSwich addTarget:self action:@selector(autoLoginSwich:) forControlEvents:UIControlEventValueChanged];
            [autoLoginSwich setOn:!([[NSUserDefaults standardUserDefaults]boolForKey:@"onOff"])];
            
            [cell setAccessoryView:autoLoginSwich];
            
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
            
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cellTitle = @"SooBook for iOS GitHub";
        }
    }
    cell.textLabel.text = cellTitle;
    
    return cell;
}

- (void)autoLoginSwich:(UISwitch*)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBAuthCenter *auth = [[SBAuthCenter alloc] init];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0: //로그인 설정
            switch (indexPath.row) {
                case 0:
                    //자동로그인 부분
                    break;
                    
                case 1:
                    //로그아웃 부분
                    [auth logOut];
                    [self showLogoutAlertController];
                    break;
            }
            break;
            
        case 1: //SOOBOOK
            switch (indexPath.row) {
                case 0:
                    //버전정보 부분
                    break;
                    
                case 1:
                    //SooBook for iOS GutHub
                    break;
            }
            break;
    }
    
//        if (indexPath.section == 0 && indexPath.row == 1)
//        {
//            SBAuthCenter *auth = [[SBAuthCenter alloc] init];
//            [auth logOut];
//            [self showLogoutAlertController];
//    
//        }
}

- (void)showLogoutAlertController
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"SBLoginViewController" bundle:nil];
    SBLogInViewController *loginView = [story instantiateViewControllerWithIdentifier:@"SBLoginViewController"];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"정말 로그아웃 하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"네" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self presentViewController:loginView animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
