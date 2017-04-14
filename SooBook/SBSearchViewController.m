//
//  SBSearchViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 10..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBSearchViewController.h"
#import "SBSearchTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SBSearchViewController ()
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property NSArray *allData;
@property NSMutableArray *resultData;

@property SBDataCenter *dataCenter;
@property SBBookData *bookData;

@property IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;
@property IBOutlet UIView  *grayView;
@property SBIndicatorView *indicator;

@end

@implementation SBSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataCenter = [SBDataCenter sharedBookData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SBSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"SBSearchTableViewCell"];
    
    self.resultData = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];

    
    self.searchBar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"책 / 출판사";
    self.searchBar.delegate = self;

    self.indicator = [SBIndicatorView new];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}
#pragma mark - Notification
//키보드가 보이면
- (void)keyboardShown:(NSNotification *)note
{
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height -= keyboardFrame.size.height;
    [self.tableView setFrame:tableViewFrame];
}
//키보드가 감춰지면
- (void)keyboardHidden:(NSNotification *)note
{
    [self.tableView setFrame:self.view.bounds];
}



#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //현재 사용가능한 Cell 객체 준비
    SBSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBSearchTableViewCell" forIndexPath:indexPath];
    
    //내용 아이템 준비
    SBBookData *item = self.resultData[indexPath.row];
    
    //셀에 내용 넣기
    cell.titleLabel.text = item.title;
    cell.subtitleLabel.text = [NSString stringWithFormat:@"%@ | %@",item.author,item.publisher];
    
//    cell.bookCoverImageView.image = [UIImage imageNamed:item.imageURL]; //데이터 붙이면 바꿔야 함
    
    NSString *encodedStr = [item.imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [cell.bookCoverImageView sd_setImageWithURL:[NSURL URLWithString:encodedStr]
                 placeholderImage:[UIImage imageNamed:@"1.jpeg"]];
    
    cell.bookPrimaryKey = item.bookPrimaryKey;
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}

#pragma mark- SearchBar

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.grayView setHidden:NO];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self.grayView setHidden:YES];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"편집 들어갑");

    if([searchText length] == 0)
    {
        [self.resultData removeAllObjects];
    }
    [self.tableView reloadData];
}

#pragma mark - Button & Gesture
- (void)searchBarSearchButtonClicked:(UISearchBar *)SearchBar
{
    NSLog(@"서치버튼 눌렀습니다.");
    [self.searchBar resignFirstResponder];
    [self.indicator startIndicatorOnView:self.view];

    //서치 요청
   [self.dataCenter searchWithQuery:self.searchBar.text completion:^(BOOL sucess, id data)
    {
        NSDictionary *receivedData = data;
        NSArray *resultArray = [receivedData objectForKey:@"results"];
        [self.resultData addObjectsFromArray:resultArray];
        [self.tableView reloadData];
        [self.indicator stopIndicator];
        
   }];
}
//제스쳐 그레이뷰와 반응
- (IBAction)tapGestureResignFirstResponder:(UITapGestureRecognizer *)sender
{
    [self.searchBar resignFirstResponder];
}

@end
