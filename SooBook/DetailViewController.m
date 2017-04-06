//
//  DetailViewController.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 31..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "DetailViewController.h"
#import "RateView.h"
#import "JCBlurrManager.h"
#import "SBDataCenter.h"
#import "SBBookData.h"

@interface DetailViewController ()
<RateViewDelegate>
@property (weak, nonatomic) IBOutlet RateView *starRateView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    SBBookData *item = [[SBDataCenter sharedBookData] bookDataWithPrimaryKey:self.bookPrimaryKey];
    self.bookCoverImageView.image = [UIImage imageNamed:
                                     [NSString stringWithFormat:@"%@.jpg",item.imageURL]];
    self.backImageView.image = [UIImage imageNamed:
                                     [NSString stringWithFormat:@"%@.jpg",item.imageURL]];
    self.subtitleLabel.text = item.author;
    self.decriptionLabel.text = item.shortDescription;
    self.mainTitleLabel.text = item.title;
    
    //self.navigationItem.title = item.title;
    
 
    self.starRateView.rating = 2;
    self.starRateView.delegate = self;
    self.starRateView.editable = YES;
    self.starRateView.maxRating = 5;
    

    
}

- (void)viewDidLayoutSubviews {
    [JCBlurrManager blurrView:self.backImageView withEffectStyle:UIBlurEffectStyleDark];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    //기록
}
- (IBAction)backButtonSelected:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
