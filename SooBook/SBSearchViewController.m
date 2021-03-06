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
//#import <SDWebImage/UIImageView+WebCache.h>

@interface SBSearchViewController ()
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property NSString *url;
@property NSInteger page;

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
    self.page = 1;
    self.url = [NSString stringWithFormat:@"%@%@%@page=%ld",BASE_URL,SEARCH,self.searchBar.text,(long)self.page];
    self.dataCenter = [SBDataCenter defaultCenter];
    
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
    
    self.grayView.alpha = 0.4;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    cell.myBook = item.isMyBook;
    cell.bookPrimaryKey = item.bookPrimaryKey;
    cell.favoriteButton.tag = indexPath.row;
    
    if(cell.myBook) {
        [cell.favoriteButton setSelected:YES];
    } else {
        [cell.favoriteButton setSelected:NO];
    }
    //    cell.favoriteButton
    
    [cell.favoriteButton addTarget:self action:@selector(requestAddBook:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *encodedStr = [item.imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [cell.bookCoverImageView setShowActivityIndicatorView:YES];
    [cell.bookCoverImageView setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.bookCoverImageView sd_setImageWithURL:[NSURL URLWithString:encodedStr]
                               placeholderImage:[UIImage imageNamed:@"bookPlaceholder"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //     || ![self.url isEqual:[NSNull null]]
    if (indexPath.row == self.resultData.count - 1 )
    {
        if (![self.url isEqual:[NSNull null]] && [self.url length])
        {
            NSLog(@"케헤헤헤헿");
            [self.dataCenter nextSearchResultWithURLString:self.url completion:^(BOOL sucess, id data) {
                
                if(sucess) {
    
                    NSArray *array = [data objectForKey:@"results"];
                    [self.resultData addObjectsFromArray:array];
                    self.url   = [data objectForKey:@"next"];
                    
                    NSLog(@"%@", [data objectForKey:@"next"]);
                    
                    [self.tableView reloadData];
                  
                } else {
                    NSLog(@"%@", data);
                }
            }];
        
        }
        self.url = @"";
    }
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
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"서치버튼 눌렀습니다.");
    [self.searchBar resignFirstResponder];
    [self.indicator startIndicatorOnView:self.view withMessage:@"책 찾는중..."];
    
    [self.resultData removeAllObjects];
    
    self.url = [NSString stringWithFormat:@"%@%@keyword=%@&page=%d",BASE_URL,SEARCH, searchBar.text,1];
    
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

- (void)requestAddBook:(UIButton *)sender
{
    NSLog(@"requestAddBook");
    
    [self.indicator startIndicatorOnView:self.view withMessage:@"책 쌓는중..."];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    SBSearchTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    SBBookData *item = self.resultData[indexPath.row];
    __weak SBIndicatorView *indicator = self.indicator;
    
    if (!sender.selected)
    {
        
        [self.dataCenter addBook:[cell bookPrimaryKey] completion:^(BOOL sucess, id data) {
            if (sucess)
            {
                NSLog(@"YES");
                sender.selected = YES;
                item.myBook =YES;
            } else {
                //책장에 책이 들어오지 못했다는 알럿창
            }
            
            [indicator stopIndicator];
        }];
    } else {
//        [self.indicator startIndicatorOnView:self.view withMessage:@"책 빼는중..."];
        [self.dataCenter deleteBook:[cell bookPrimaryKey] completion:^(BOOL sucess, id data) {
            if (sucess)
            {
                NSLog(@"NO");
                sender.selected = NO;
                item.myBook = NO;
            } else {
                //책장에 책이 들어오지 못했다는 알럿창
            }
            
            [indicator stopIndicator];
        }];
    }
}



@end
