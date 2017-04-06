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

@interface SBMainCollectionViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation SBMainCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCoverCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BookCoverCollectionViewCell"];
    
    
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    

    BookCoverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCoverCollectionViewCell" forIndexPath:indexPath];
    
     cell.firstCollectionImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg",indexPath.item+1]];

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = cell.backgroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor redColor]CGColor], nil];
    [cell.contentView. layer insertSublayer:gradient atIndex:0];
    [self.collectionView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    
    return cell;
}

#pragma mark - Button & Navigation
- (IBAction)changeMainViewAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{   //스토리보드 지정?
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //스토리보드에 있는 뷰컨트롤러 지정
    UIViewController *vc = [st instantiateViewControllerWithIdentifier:@"DetailViewController"];
    

    
    [self.navigationController pushViewController:vc animated:YES];
//
////    [self presentViewController:detailViewController animated:YES completion:^{
////        [collectionView cellForItemAtIndexPath:indexPath];
////    }];
}


@end
