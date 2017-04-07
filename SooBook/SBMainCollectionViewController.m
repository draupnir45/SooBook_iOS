//
//  SBMainCollectionViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 6..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBMainCollectionViewController.h"
#import "BookCoverCollectionViewCell.h"
#import "DetailViewController.h"
#import "CollectionViewDataSource.h"

@interface SBMainCollectionViewController ()
<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property CollectionViewDataSource *dataSource;
@end

@implementation SBMainCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCoverCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BookCoverCollectionViewCell"];
    
    CollectionViewDataSource *dataSource = [[CollectionViewDataSource alloc] initWithSbDataArray:[[SBDataCenter sharedBookData] myBookDatas]];
    self.collectionView.dataSource = dataSource;
    self.dataSource = dataSource;
    
    
    UIImage *naviBarLogo = [UIImage imageNamed: @"logoForNavigation"];
    UIImageView *titleImageview = [[UIImageView alloc] initWithImage: naviBarLogo];
    self.navigationItem.titleView = titleImageview;
    
    
//     CAGradientLayer *gradient = [CAGradientLayer layer];
//     gradient.frame = self.view.bounds;
//     gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor redColor]CGColor], nil];
//     [self.contentView.layer insertSublayer:gradient atIndex:0];
//     [self.collectionView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    
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

#pragma mark - Button & Navigation
- (IBAction)changeMainViewAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{   //스토리보드 지정?
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //스토리보드에 있는 뷰컨트롤러 지정
    DetailViewController *detailViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    //cell 받아오기
    BookCoverCollectionViewCell *cell = (BookCoverCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    detailViewController.bookPrimaryKey = cell.bookPrimaryKey;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
