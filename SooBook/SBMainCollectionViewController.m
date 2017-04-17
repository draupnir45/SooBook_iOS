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

@interface SBMainCollectionViewController ()
<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property BookCoverCollectionViewDataSource *dataSource;

@end

@implementation SBMainCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SBBookCoverFlowCell" bundle:nil] forCellWithReuseIdentifier:@"SBBookCoverFlowCell"];
    
    BookCoverCollectionViewDataSource *dataSource = [[BookCoverCollectionViewDataSource alloc] initWithSbDataArray:[[SBDataCenter defaultCenter] myBookDatas]];
    self.collectionView.dataSource = dataSource;
    self.dataSource = dataSource;
    
    
    UIImage *naviBarLogo = [UIImage imageNamed: @"logoForNavigation"];
    UIImageView *titleImageview = [[UIImageView alloc] initWithImage: naviBarLogo];
    self.navigationItem.titleView = titleImageview;
    
    
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collectionViewBackgroundPattern"]];
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
