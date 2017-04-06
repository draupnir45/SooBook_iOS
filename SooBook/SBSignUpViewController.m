//
//  SBSignUpViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 3. 29..
//  Copyright © 2017년 Parkchanwoong. All rights reserved.
//

#import "SBSignUpViewController.h"
#import "SBAccountTableViewCell.h"
#import "SBIndicatorView.h"

@interface SBSignUpViewController ()
<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property UITextField *idTextField;
@property UITextField *password1TextField;
@property UITextField *password2TextField;
@property UITextField *nickNameTextField;

@property SBIndicatorView *indicatorView;

@end

@implementation SBSignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"SBAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"SBAccountTableViewCell"];
    
    //헤더 , 풋터를 없애기 위한 부분
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    //-----------------------
    
    self.indicatorView = [[SBIndicatorView alloc] init];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //화면이 띄어지고 첫번째 셀 텍스트 필드에 포커싱을 준다
    [self.idTextField becomeFirstResponder];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField
//리턴 버튼을 눌렀을 경우의 반응 첫번째에 리턴을 누르면 두번째로 , 두번째는 세번째로 , 세번째는 done을 누르면 회원가입이 되어야 한다.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    switch (textField.tag) {
        case 100:
            [self.password1TextField becomeFirstResponder];
            break;
        case 200:
            [self.password2TextField becomeFirstResponder];
            break;
        case 300:
            [self.nickNameTextField becomeFirstResponder];
            break;
        default:
           [self doSignUpRequest];
            break;
    }
    
    return YES;
}

//셀의 텍스트 필드 4곳 모두 무언가가 채워져 있으면 버튼 이미지 변경
- (void)editChanged:(UITextField *)sender
{

    if (self.idTextField.text.length > 0 && self.password1TextField.text.length > 0 &&self.password2TextField.text.length > 0 && self.nickNameTextField.text.length > 0)
    {
        [self.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.signUpButton setBackgroundColor:[UIColor sb_soobookBlueColor]];
    } else {
        [self.signUpButton setTitleColor:[UIColor sb_soobookBlueColor] forState:UIControlStateNormal];
        [self.signUpButton setBackgroundColor:[UIColor whiteColor]];
        
    }
    
}

#pragma mark - TableView

/*----------------------- 테이블뷰의 헤더와 푸터를 줄이기 위한 부분 ----------------------------*/
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

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

//section 당 row 의 갯수   섹션은 1개
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBAccountTableViewCell" forIndexPath:indexPath];
    
    
    [cell.tableViewCellTextField addTarget:self action:@selector(editChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    switch (indexPath.row)
    {
        case 0:
            cell.tableViewCellTextField.keyboardType = UIKeyboardTypeEmailAddress;
            cell.tableViewCellLabel.text = @"SooBook ID";
            cell.tableViewCellTextField.placeholder = @"example@soobook.com";
            cell.tableViewCellTextField.tag = 100;
            self.idTextField = cell.tableViewCellTextField;
            break;
        case 1:
            cell.tableViewCellLabel.text = @"Password";
            cell.tableViewCellTextField.placeholder = @"6자리 이상";
            cell.tableViewCellTextField.tag = 200;
            cell.tableViewCellTextField.secureTextEntry = YES;
            self.password1TextField = cell.tableViewCellTextField;
            break;
        case 2:
            cell.tableViewCellLabel.text = nil;
            cell.tableViewCellTextField.placeholder = @"비밀번호 확인";
            cell.tableViewCellTextField.tag = 300;
            cell.tableViewCellTextField.secureTextEntry = YES;
            self.password2TextField = cell.tableViewCellTextField;
            break;
        default:
            cell.tableViewCellLabel.text = @"NickName";
            cell.tableViewCellTextField.placeholder = @"별명을 입력해 주세요.";
            cell.tableViewCellTextField.returnKeyType = UIReturnKeyDone;
            self.nickNameTextField = cell.tableViewCellTextField;
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tableViewCellTextField.delegate = self;
    
    
    
    
    return cell;
}


#pragma mark - SignUp Request Methods
//이메일 , 패스워드 1, 패스워드 2 , 닉네임 체크 구간
- (BOOL)checkSignUpDataWithEmail:(NSString *)email
                       password1:(NSString *)password
                       password2:(NSString *)password2
                        nickName:(NSString *)nickName
{
    
    const char *tmp = [email cStringUsingEncoding:NSUTF8StringEncoding];
    //하나라도 빈칸이 있으면 발동
    if (email.length != strlen(tmp)) {
        // 한글이 포함되어있으면 ㄴㄴ
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"수북" message:@"한글이 포함되어 있습니다." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:noAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return NO;
        
    } else {
        NSString *check = @"([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\\.[0-9a-zA-Z_-]+){1,2}";
        NSRange match = [email rangeOfString:check options:NSRegularExpressionSearch];
        if (NSNotFound == match.location)  //이메일 형식으로 해야함
            
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"수북" message:@"이메일 형식이 아닙니다" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
            
            [alert addAction:noAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            return NO;
            
        } else if (password != password2 || password.length <6 ){ //비번 1 과 2가 다르거나 길이가 6자 이하라면
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"수북" message:@"패스워드를 확인해주세요" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            
            
            [alert addAction:okAction];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return NO;
            
            
        } else if (nickName.length < 2 ) { //닉네임의 길이가 2자이상이 아니면
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"수북" message:@"닉네임의 길이는 2자 이상입니다." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
            
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            return NO;
            
        } else {
            return YES;
        }
    
    }
    
    
    
}

//버튼을 클릭해도, done를 눌러도 이곳을 타야함
- (void)doSignUpRequest
{
    NSString *idString = self.idTextField.text;
    NSString *password1 = self.password1TextField.text;
    NSString *password2 = self.password2TextField.text;
    NSString *nickName = self.nickNameTextField.text;
    
    //별도의 메서드 checkSignUpDataWithEmail: 로 예외처리 후 사인업 요청
    if ([self checkSignUpDataWithEmail:idString password1:password1 password2:password2 nickName:nickName]) {
        
        //모든 포커싱 해제
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        
        //인디케이터를 화면에 띄움
        [self.indicatorView startIndicatorOnView:self.view];
        
        [[SBAuthCenter sharedInstance] signUpWithUserID:self.idTextField.text password:self.password1TextField.text nickName:self.nickNameTextField.text completion:^(BOOL sucess, id data) {
            
            if (sucess) {
                
                [[SBAuthCenter sharedInstance] logInWithUserID:idString password:password1 completion:^(BOOL sucess, id data) {
                    
                    //인디케이터 해제
                    [self.indicatorView stopIndicator];

                    if (sucess) {
                        NSDictionary *dataDict = (NSDictionary *)data;
                        NSLog(@"로그인까지 성공 , 토큰값 : %@",[dataDict objectForKey:USERTOKEN_KEY]);
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"회원가입 완료!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                        }];
                        
                        [alert addAction:okAction];
                        
                        [self presentViewController:alert animated:YES completion:nil];

                    } else {
                        //회원가입되고 로그인 안됐을 때 처리
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"회원가입 완료!"
                                                                                       message:@"로그인 해주세요"
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"확인"
                                                                           style:UIAlertActionStyleCancel
                                                                         handler:nil];
                        [alert addAction:noAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    

                }];
            } else {
                //회원가입 안됐을 때 처리
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"회원가입 실패"
                                                                               message:@"다시 시도해 주세요"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"확인"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:nil];
                [alert addAction:noAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}

#pragma mark - Action & Navigation
//회원가입 버튼 클릭
- (IBAction)signUpButtonSelected:(UIButton *)sender
{
    [self doSignUpRequest];
}

//로그인페이지로 돌아간다~
- (IBAction)backToLoginPage:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
