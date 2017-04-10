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
<RateViewDelegate, UIGestureRecognizerDelegate>
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
    
    if (self.navigationController != nil)
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    
    
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
-(void)rateView:(RateView *)rateView ratingDidChange:(CGFloat)rating {
    //기록
    
    NSLog(@"%f", rating);
   
    self.starInteger.text = [NSString stringWithFormat:@"%f",rating];
   
}
- (IBAction)backButtonSelected:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)rightButtonSelected:(id)sender {
   
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@" 등록 " message:@" 나의 책장에 등록 하시겠습니까 ? " preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@" 아니요 " style:UIAlertActionStyleCancel handler:nil];
    [sender setImage:[UIImage imageNamed:@"mybookHeartOff"] forState:UIControlStateSelected];

    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@" 네 " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setImage:[UIImage imageNamed:@"mybookHeartOn"] forState:UIControlStateNormal];
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)ratingactionButton:(id)sender {
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
