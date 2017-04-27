//
//  SBMainTableViewController.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "SBMainTableViewController.h"

//섹션 헤더
#import "SBSmallHeaderCell.h"
#import "SBLargeHeaderCell.h"

//첫번째 섹션 셀
#import "SBBookCoverFlowContainerCell.h"
#import "BookCoverCollectionViewDataSource.h"
#import "SBBookCoverFlowCell.h"

//두번째 섹션 셀
#import "SBMainTableViewCell.h"

//디테일 뷰
#import "SBDetailViewController.h"

@interface SBMainTableViewController ()
<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property BookCoverCollectionViewDataSource *firstSectionCollectionViewDataSource;
@property NSArray *mainImageArray;
@property NSArray *titleLabelArray;
@property NSArray *subLabelArray;
@property NSArray *contentsArray;
@property NSInteger nextPage;
@property UIRefreshControl *tableViewRefreshControl;
@property SBIndicatorView *indicator;


@end

@implementation SBMainTableViewController

static NSString * const SMALLHEADER_ID = @"SBSmallHeaderCell";
static NSString * const LARGEHEADER_ID = @"SBLargeHeaderCell";
static NSString * const MAINTABLEVIEW_CELL_ID = @"SBMainTableViewCell";


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.title = @"내 책장";
    
    self.indicator = [SBIndicatorView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:SMALLHEADER_ID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SMALLHEADER_ID];
    [self.tableView registerNib:[UINib nibWithNibName:LARGEHEADER_ID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:LARGEHEADER_ID];
    [self.tableView registerNib:[UINib nibWithNibName:MAINTABLEVIEW_CELL_ID bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MAINTABLEVIEW_CELL_ID];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
   
    UIImage *naviBarLogo = [UIImage imageNamed: @"logoForNavigation"];
    UIImageView *titleImageview = [[UIImageView alloc] initWithImage: naviBarLogo];
    self.navigationItem.titleView = titleImageview;
    
    self.tableViewRefreshControl = [[UIRefreshControl alloc] init];
    [self.tableViewRefreshControl addTarget:self
                                     action:@selector(refreshData:)
                           forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = self.tableViewRefreshControl;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMainTable) name:@"doneLoading" object:nil];
    if ([[[SBAuthCenter sharedInstance] userToken] length] != 0) {
        [self loadMyBookData];
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([[[SBAuthCenter sharedInstance] userToken] length] == 0) {
        [self performSegueWithIdentifier:@"LogInSegue" sender:self];
    } else {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)refreshData:(id)sender {
    [self loadMyBookData];
}

- (void)reloadMainTable {
    __weak SBMainTableViewController *weakSelf = self;
    [[SBDataCenter defaultCenter] loadRatingListWithCompletion:^(BOOL sucess, id data) {
        if (sucess) {
            weakSelf.firstSectionCollectionViewDataSource = [[BookCoverCollectionViewDataSource alloc] initWithSbDataArray:(NSArray *)data];
            [weakSelf.tableView reloadData];
            [weakSelf.indicator stopIndicator];
            if (weakSelf.tableViewRefreshControl.refreshing) {
                [weakSelf.tableViewRefreshControl endRefreshing];
            }
        }
    }];

}

- (void)loadMyBookData {
    
    [self.indicator startIndicatorOnView:self.tabBarController.view withMessage:@"책 로딩..."];
    __weak SBMainTableViewController *weakSelf = self;
    [[SBDataCenter defaultCenter] loadBookListWithCompletion:^(BOOL sucess, id data) {
        if (!sucess) {
            [weakSelf.indicator stopIndicator];
            if (weakSelf.tableViewRefreshControl.refreshing) {
                [weakSelf.tableViewRefreshControl endRefreshing];
            }
            UIAlertController *alert = [JCAlertController alertControllerWithTitle:@"책 로딩에 실패했습니다." message:@"다시 로그인해 주세요." preferredStyle:UIAlertControllerStyleAlert cancelTitle:@"취소" okTitle:@"확인" okHandler:^(UIAlertAction *action) {
                [[SBAuthCenter sharedInstance] logOut];
                [weakSelf performSegueWithIdentifier:@"LogInSegue" sender:self];
            }];
            
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    }];
}



#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0 :
            return 1;
            break;
            
        default:
            return [[[SBDataCenter defaultCenter] dataArray] count];
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            {
                SBSmallHeaderCell *view = [tableView dequeueReusableCellWithIdentifier:@"SBSmallHeaderCell"];
                view.titleLabel.text = @"내가 높게 평가한 책들";
                return view;
                break;
            }
        default:
            {
                SBLargeHeaderCell *view = [tableView dequeueReusableCellWithIdentifier:@"SBLargeHeaderCell"];
                view.secondLabel.text = @"나의 책 목록";
                return view;
                break;
            }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        SBBookCoverFlowContainerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBBookCoverFlowContainerCell" forIndexPath:indexPath];
        [cell.collectionView registerNib:[UINib nibWithNibName:@"SBBookCoverFlowCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:@"SBBookCoverFlowCell"];
        cell.collectionView.delegate = self;
        cell.collectionView.dataSource = self.firstSectionCollectionViewDataSource;
        

        return cell;
        
    } else {
        SBBookData *item = [[[SBDataCenter defaultCenter] dataArray] objectAtIndex:indexPath.row];
        SBMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBMainTableViewCell" forIndexPath:indexPath];
    
        NSString *encodedStr = [item.imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [cell.bookCoverImageView setShowActivityIndicatorView:YES];
        [cell.bookCoverImageView setIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.bookCoverImageView sd_setImageWithURL:[NSURL URLWithString:encodedStr]
                                   placeholderImage:[UIImage imageNamed:@"bookPlaceholder"]];
        
        
        cell.titleLabel.text = item.title;
        cell.subtitleLabel.text = item.author;
        cell.bookPrimaryKey = item.bookPrimaryKey;
        cell.starRateView.editable = NO;
        if (item.hasRating) {
            cell.starRateView.rating = item.rating.score;
            cell.starRateLabel.text = [NSString stringWithFormat:@"%.1f",item.rating.score];
        } else {
            cell.starRateView.rating = 0;
            cell.starRateLabel.text = @"0.0";
        }
        [cell layoutSubviews];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        switch (section) {
            case 0:
                return 40.0;
                break;
                
            default:
            {
                return 64.0;
                break;
            }
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [SBBookCoverFlowCell cellHeight];
            break;
            
        default:
            return 192.0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailSegue" sender:[collectionView cellForItemAtIndexPath:indexPath]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark - CollectionView Delegate (첫 섹션 컬렉션뷰 커스텀을 위한 코드)

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0,16.0,0.0,16.0); // top, left, bottom, right
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        SBDetailViewController *detailViewController = segue.destinationViewController;
        
        if ([sender isMemberOfClass:[SBBookCoverFlowCell class]]) {
            SBBookCoverFlowCell *cell = sender;
            detailViewController.bookPrimaryKey = cell.bookPrimaryKey;
        } else {
            SBMainTableViewCell *cell = sender;
            detailViewController.bookPrimaryKey = cell.bookPrimaryKey;
        }
        
    }
}

@end
