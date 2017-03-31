//
//  SBSignUpViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 3. 29..
//  Copyright © 2017년 Parkchanwoong. All rights reserved.
//

#import "SBSignUpViewController.h"
#import "SBCustomTableViewCell.h"

@interface SBSignUpViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *signupTableView;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation SBSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //헤더 , 풋터를 없애기 위한 부분
    self.signupTableView.sectionHeaderHeight = 0;
    self.signupTableView.sectionFooterHeight = 0;
    self.signupTableView.backgroundColor = [UIColor whiteColor];
    //-----------------------
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //화면이 띄어지고 첫번째 셀 텍스트 필드에 포커싱을 준다
    SBCustomTableViewCell *cell = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.tableViewCellTextField becomeFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TextField Delegate
//리턴 버튼을 눌렀을 경우의 반응 첫번째에 리턴을 누르면 두번째로 , 두번째는 세번째로 , 세번째는 done을 누르면 회원가입이 되어야 한다.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    SBCustomTableViewCell *cell = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    SBCustomTableViewCell *cell2 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    SBCustomTableViewCell *cell3 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    switch (textField.tag) {
        case 100:
            [cell.tableViewCellTextField becomeFirstResponder];
            break;
        case 200:
            [cell2.tableViewCellTextField becomeFirstResponder];
            break;
        case 300:
            [cell3.tableViewCellTextField becomeFirstResponder];
            break;
        default:
            [textField resignFirstResponder];
            break;
    }
    
    return YES;
}

//셀의 텍스트 필드 4곳 모두 무언가가 채워져 있으면 버튼 이미지 변경?
- (void)editChanged:(UITextField *)sender {
    SBCustomTableViewCell *cell1 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    SBCustomTableViewCell *cell2 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    SBCustomTableViewCell *cell3 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    SBCustomTableViewCell *cell4 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    if (cell1.tableViewCellTextField.text.length > 0 && cell2.tableViewCellTextField.text.length > 0 &&cell3.tableViewCellTextField.text.length > 0 && cell4.tableViewCellTextField.text.length > 0)
    {
        [self.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.signUpButton setBackgroundColor:[UIColor colorWithRed:25/255.0 green:142/255.0 blue:167/255.0 alpha:1]];
        
    } else {
        
        [self.signUpButton setTitleColor:[UIColor colorWithRed:25/255.0 green:142/255.0 blue:167/255.0 alpha:1] forState:UIControlStateNormal];
        [self.signUpButton setBackgroundColor:[UIColor whiteColor]];
        
    }
    
}





#pragma mark - TableView
/*----------------------- 테이블뷰의 헤더와 푸터를 줄이기 위한 부분 ----------------------------*/
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}
/*------------------------------------------------------------------------------------*/









#pragma mark - TableView DataSource
//section 당 row 의 갯수   세션은 1개
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBCustomTableViewCell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SBCustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"SBCustomTableViewCell"];
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"SBCustomTableViewCell"];
    }
    
    
    
    [cell.tableViewCellTextField addTarget:self action:@selector(editChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    switch (indexPath.row)
    {
        case 0:
            cell.tableViewCellLabel.text = @"SooBook ID";
            cell.tableViewCellTextField.placeholder = @"example@soobook.com";
            cell.tableViewCellTextField.tag = 100;
            break;
        case 1:
            cell.tableViewCellLabel.text = @"Password";
            cell.tableViewCellTextField.placeholder = @"영문, 숫자 포함 8자 이상";
            cell.tableViewCellTextField.tag = 200;
            cell.tableViewCellTextField.secureTextEntry = YES;
            break;
        case 2:
            cell.tableViewCellLabel.text = nil;
            cell.tableViewCellTextField.placeholder = @"비밀번호 확인";
            cell.tableViewCellTextField.tag = 300;
            cell.tableViewCellTextField.secureTextEntry = YES;
            break;
            
        default:
            cell.tableViewCellLabel.text = @"NickName";
            cell.tableViewCellTextField.placeholder = @"별명을 입력해 주세요.";
            cell.tableViewCellTextField.returnKeyType = UIReturnKeyDone;
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tableViewCellTextField.delegate = self;
    
    
    
    
    return cell;
}


#pragma mark - Button
//회원가입 버튼 클릭으로 바로 위 메소드 부름
- (IBAction)clickToSignUpButton:(UIButton *)sender
{
    SBCustomTableViewCell *cell1 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    SBCustomTableViewCell *cell2 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    SBCustomTableViewCell *cell3 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    SBCustomTableViewCell *cell4 = [self.signupTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    
    
    [self checkEmail:cell1.tableViewCellTextField.text CheckPasswordEqualsPassword1:cell2.tableViewCellTextField.text password2:cell3.tableViewCellTextField.text nickName:cell4.tableViewCellTextField.text];
}

//로그인페이지로 돌아간다~
- (IBAction)backToLoginPage:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


//이메일 , 패스워드 1, 패스워드 2 , 닉네임 체크 구간
- (BOOL)checkEmail:(NSString *)email CheckPasswordEqualsPassword1:(NSString *)password
         password2:(NSString *)password2 nickName:(NSString *)nickName

{
    
    const char *tmp = [email cStringUsingEncoding:NSUTF8StringEncoding];
    //하나라도 빈칸이 있으면 발동
    if (email.length == 0 || password.length == 0 || password2.length == 0 || nickName.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"빈칸을 모두 채워주세요" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:noAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (email.length != strlen(tmp))  // 한글이 포함되어있으면 ㄴㄴ
        
    {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"한글이 포함되어 있습니다." message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:noAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return NO;
        
    }
    
    
    
    NSString *check = @"([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\\.[0-9a-zA-Z_-]+){1,2}";
    
    NSRange match = [email rangeOfString:check options:NSRegularExpressionSearch];
    
    
    
    if (NSNotFound == match.location)  //이메일 형식으로 해야함
        
    {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"이메일 형식이 아닙니다" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:noAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        return NO;
        
    } else if (password != password2){ //비번 1 과 2가 다르면
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"비밀번호가 일치하지 않습니다." message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
        
        
        [alert addAction:okAction];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        
    } else if (nickName.length < 2 ) { //닉네임의 길이가 2자이상이 아니면
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"닉네임의 길이가 짧아" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"회원가입이 완료되었습니다" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    }
    
    return YES;
    
}
- (IBAction)trapButton:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"함정" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
