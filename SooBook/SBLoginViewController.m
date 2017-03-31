//
//  ViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 3. 29..
//  Copyright © 2017년 Parkchanwoong. All rights reserved.
//

#import "SBLoginViewController.h"
#import "SBCustomTableViewCell.h"
#import "SBSignUpViewController.h"
#import "UIColor+SBAdditions.h"

@interface SBLoginViewController ()<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation SBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //헤더와 풋터를 없애기 위해 ...
    self.tableView.sectionHeaderHeight = 0.0;
    self.tableView.sectionFooterHeight = 0.0;
    self.tableView.backgroundColor = [UIColor whiteColor];

    
    // Do any additional setup after loading the view, typically from a nib.
    
}

//view가 불리고 난 후 첫번쨰 셀 텍스트 필드에 포커싱을 준다.
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    SBCustomTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.tableViewCellTextField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TextField Delegate


//첫번쨰 텍스트 필드에서 리턴을 누르면 두번째 텍스트 필드로, 두번째 텍스트 필드에서 done을 누르면 로그인이 되어야함.(지금은 리자인)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    SBCustomTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    
    if (textField.tag == 100) {
        [cell.tableViewCellTextField becomeFirstResponder];
    } else {
        [cell.tableViewCellTextField resignFirstResponder]; //나중에 없애야함
        
    }
    return YES;
    
}




#pragma mark - TableViewa
////////////////////////헤더와 풋터를 줄이기 위한 방법//////////////////////

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
//////////////////////////////////////////////////////////////////

#pragma mark - TableView DataSource
//섹션당 row의 갯수 세션은 1개고 row는 2개
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SBCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBCustomTableViewCell"];
    
    if (cell == nil)
    {
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
            
        default:
            cell.tableViewCellLabel.text = @"Password";
            cell.tableViewCellTextField.placeholder = @"필수 항목";
            cell.tableViewCellTextField.returnKeyType = UIReturnKeyDone;
            cell.tableViewCellTextField.secureTextEntry = YES;
            
            break;
            
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tableViewCellTextField.delegate = self;
    return cell;
}


//셀의 텍스트들이 채워져 있으면 버튼이 변함
- (void)editChanged:(UITextField *)sender {
    SBCustomTableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    SBCustomTableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    
    if (cell1.tableViewCellTextField.text.length > 0 && cell2.tableViewCellTextField.text.length > 0)
    {
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginButton setBackgroundColor:[UIColor colorWithRed:25/255.0 green:142/255.0 blue:167/255.0 alpha:1]];
        
    } else {
        
        [self.loginButton setTitleColor:[UIColor colorWithRed:25/255.0 green:142/255.0 blue:167/255.0 alpha:1] forState:UIControlStateNormal];
        [self.loginButton setBackgroundColor:[UIColor whiteColor]];
        
    }
    
}


#pragma mark - Button
//회원가입 페이지로 이동하는 버튼
- (IBAction)nextToSignUpPage:(UIButton *)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"SBSignUpViewController" bundle:nil];
    SBSignUpViewController *view = [story instantiateViewControllerWithIdentifier:@"SBSignUpViewController"];
    [self.navigationController pushViewController:view animated:YES];
}


@end
