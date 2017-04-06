//
//  ViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 3. 29..
//  Copyright © 2017년 Parkchanwoong. All rights reserved.
//

#import "SBLogInViewController.h"
#import "SBAccountTableViewCell.h"
#import "SBSignUpViewController.h"
#import "UIColor+SBAdditions.h"
#import "SBIndicatorView.h"

@interface SBLogInViewController ()
<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property UITextField *idTextField;
@property UITextField *passwordTextField;
@property SBIndicatorView *indicatorView;

@end

@implementation SBLogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //헤더와 풋터를 없애기 위해 ...
    self.tableView.sectionHeaderHeight = 0.0;
    self.tableView.sectionFooterHeight = 0.0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.indicatorView = [[SBIndicatorView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SBAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"SBAccountTableViewCell"];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    SBAccountTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.tableViewCellTextField becomeFirstResponder]; //view가 불리고 난 후 첫번쨰 셀 텍스트 필드에 포커싱을 준다.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField

//첫번쨰 텍스트 필드에서 리턴을 누르면 두번째 텍스트 필드로, 두번째 텍스트 필드에서 done을 누르면 로그인이 되어야함.(지금은 리자인)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if (textField.tag == 100) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self doLogInRequest];
    }
    return YES;
    
}

//각 텍스트필드에 텍스트들이 채워져 있으면 버튼이 변함
- (void)editChanged:(UITextField *)sender
{
    if (self.idTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginButton setBackgroundColor:[UIColor sb_soobookBlueColor]];
    } else {
        [self.loginButton setTitleColor:[UIColor sb_soobookBlueColor] forState:UIControlStateNormal];
        [self.loginButton setBackgroundColor:[UIColor whiteColor]];
    }
}

#pragma mark - TableView
////////////////////////헤더와 풋터를 줄이기 위한 방법//////////////////////

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

//섹션당 row의 갯수 섹션은 1개고 row는 2개
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBAccountTableViewCell" forIndexPath:indexPath];
    switch (indexPath.row)
    {
        case 0:
            cell.tableViewCellTextField.keyboardType = UIKeyboardTypeEmailAddress;
            cell.tableViewCellLabel.text = @"SooBook ID";
            cell.tableViewCellTextField.placeholder = @"example@soobook.com";
            cell.tableViewCellTextField.tag = 100;
            self.idTextField = cell.tableViewCellTextField;
            break;
            
        default:
            cell.tableViewCellLabel.text = @"Password";
            cell.tableViewCellTextField.placeholder = @"필수 항목";
            cell.tableViewCellTextField.returnKeyType = UIReturnKeyDone;
            cell.tableViewCellTextField.secureTextEntry = YES;
            self.passwordTextField = cell.tableViewCellTextField;
            break;
    }
    
    cell.tableViewCellTextField.delegate = self;
    [cell.tableViewCellTextField addTarget:self action:@selector(editChanged:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
}

#pragma mark - Action & Navigation

//로그인 클릭 버튼
- (IBAction)loginButtonSelected:(UIButton *)sender
{
    [self doLogInRequest];
}

//로그인 버튼 클릭 또는 Done을 눌렀을때의 반응
- (void)doLogInRequest
{
    //예외처리 - ID랑 비번이 있는지 검사
    if (self.idTextField.text.length == 0 || self.passwordTextField.text.length == 0)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"수북"
                                                                       message:@"빈칸을 모두 채워주세요"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"확인"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
        
        [alert addAction:noAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        //포커스 빼고 인디케이터뷰 실행
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        [self.indicatorView startIndicatorOnView:self.view];
        
        [[SBAuthCenter sharedInstance] logInWithUserID:self.idTextField.text
                                              password:self.passwordTextField.text
                                            completion:^(BOOL sucess, id data) {
                                                if (sucess) {
                                                    NSDictionary *dataDict = (NSDictionary *)data;
                                                    NSLog(@"로그인 성공, 토큰 : %@", [dataDict objectForKey:USERTOKEN_KEY]);
                                                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"로그인 성공"
                                                                                                                   message:nil
                                                                                                            preferredStyle:UIAlertControllerStyleAlert];

                                                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인"
                                                                                                       style:UIAlertActionStyleCancel
                                                                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                                    }];
                                                    [alert addAction:okAction];
                                                    [self presentViewController:alert animated:YES completion:nil];
                                                    [self.indicatorView stopIndicator];
                                                } else {
                                                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"로그인 실패"
                                                                                                                   message:@"인증 정보를 다시 확인해 주세요!"
                                                                                                            preferredStyle:UIAlertControllerStyleAlert];
                                                    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"확인"
                                                                                                       style:UIAlertActionStyleCancel
                                                                                                     handler:nil];
                                                    [alert addAction:noAction];
                                                    [self presentViewController:alert animated:YES completion:nil];
                                                    [self.indicatorView stopIndicator];
                                                }
                                            }];
    }
}

@end
