//
//  SBMainCollectionViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 6..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBMainCollectionViewController.h"
#import "SBMainCollectionViewCell.h"
#import "SBDetailViewController.h"
#import "BookCoverCollectionViewDataSource.h"
#import "SBIndicatorView.h"

@interface SBMainCollectionViewController ()
<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property BookCoverCollectionViewDataSource *dataSource;
@property UIRefreshControl *collectionViewRefreshControl;
@property NSInteger nextPage;
@property SBIndicatorView *indicator;

@end

@implementation SBMainCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.indicator = [SBIndicatorView new];
    self.collectionViewRefreshControl = [UIRefreshControl new];
    [self.collectionViewRefreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    self.collectionViewRefreshControl.tintColor = [UIColor whiteColor];
    self.collectionView.refreshControl = self.collectionViewRefreshControl;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SBBookCoverFlowCell" bundle:nil] forCellWithReuseIdentifier:@"SBBookCoverFlowCell"];
    
    
    UIImage *naviBarLogo = [UIImage imageNamed: @"logoForNavigation"];
    UIImageView *titleImageview = [[UIImageView alloc] initWithImage: naviBarLogo];
    self.navigationItem.titleView = titleImageview;
    
    [self updateDataSource];
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collectionViewBackgroundPattern"]];
}

- (void)refreshData:(id)sender
{
    [self.indicator startIndicatorOnView:self.view withMessage:@"책 로딩..."];
    [[SBDataCenter defaultCenter] loadMyBookListWithPage:1 completion:^(BOOL sucess, id data) {
        [self updateDataSource];
        [self.collectionViewRefreshControl endRefreshing];
        [self.indicator stopIndicator];
    }];
    
}

- (void)updateDataSource
{
    
    
    BookCoverCollectionViewDataSource *dataSource = [[BookCoverCollectionViewDataSource alloc] initWithSbDataArray:[[SBDataCenter defaultCenter] dataArray]];
    self.collectionView.dataSource = dataSource;
    self.dataSource = dataSource;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)dealloc
{
    NSLog(@"collection dealloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{   //스토리보드 지정?
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //스토리보드에 있는 뷰컨트롤러 지정
    SBDetailViewController *detailViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    //cell 받아오기
    SBMainCollectionViewCell *cell = (SBMainCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    detailViewController.bookPrimaryKey = cell.bookPrimaryKey;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Button & Navigation
- (IBAction)changeMainViewAction:(UIBarButtonItem *)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 8.0;
//}

@end
