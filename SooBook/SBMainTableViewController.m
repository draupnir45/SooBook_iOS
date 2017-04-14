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


@end

@implementation SBMainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"내 책장";
        
/////////////////////////////////테스트용 DataSource//////////////////////////////////
    
    self.titleLabelArray  = @[@"엘리자베스가 사라졌다",@"걸 온 더 트레인",@"영어책 한권 외워봤니?",@"드라마 도깨비 소설2 - 쓸쓸하고 찬란하神",@"여교수와 남제자",@"겨울에서 봄",@"드래곤볼 슈퍼",@"사랑해, 심청아!",@"타락천사",@"말괄량이의 늑대 길들이기: 늑대삼형제 시리즈"];

    self.firstSectionCollectionViewDataSource = [[BookCoverCollectionViewDataSource alloc] initWithSbDataArray:self.titleLabelArray];
    ///rate List로부터
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SBSmallHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SBSmallHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SBLargeHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SBLargeHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SBMainTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SBMainTableViewCell"];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
   
    UIImage *naviBarLogo = [UIImage imageNamed: @"logoForNavigation"];
    UIImageView *titleImageview = [[UIImageView alloc] initWithImage: naviBarLogo];
    self.navigationItem.titleView = titleImageview;
    
}
- (void)viewDidAppear:(BOOL)animated {
    if ([[[SBAuthCenter sharedInstance] userToken] length] == 0) {
        [self performSegueWithIdentifier:@"LogInSegue" sender:self];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
            return self.titleLabelArray.count; //나중에 교체 필요
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
        SBBookData *item = [[[SBDataCenter sharedBookData] myBookDatas] objectAtIndex:indexPath.row];
        SBMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBMainTableViewCell" forIndexPath:indexPath];
        [cell setCellDataWithImageName:item.imageURL
                                 title:item.title
                              subtitle:item.author];
        cell.bookPrimaryKey = item.bookPrimaryKey;
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
            return 172.0;
            break;
            
        default:
            return 192.0;
            break;
    }
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sizeForItemAtIndexPath");
    CGFloat heightByWidthRatio = [SBBookCoverFlowCell getImageRatioWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg",indexPath.item+1]]];
    if (heightByWidthRatio <= (172.0/96.0)) {
        return CGSizeMake(96.0, 172.0);
    } else {
        CGFloat newWidth = 172.0 / heightByWidthRatio;
        return CGSizeMake(newWidth, 172.0);
    }
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
