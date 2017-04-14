//
//  DetailViewController.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 31..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "SBDetailViewController.h"
#import "RateView.h"
#import "SBDataCenter.h"
#import "SBBookData.h"

@interface SBDetailViewController ()
<RateViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet RateView *starRateView;
@property (weak, nonatomic) IBOutlet UIButton *starRateButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *descriptionButton;
@property (weak, nonatomic) IBOutlet UIImageView *starRateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *descriptionImageView;
@property (weak, nonatomic) IBOutlet UILabel *starRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commenButtontLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@end

@implementation SBDetailViewController

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
    
    //별점뷰 설정하기
    self.starRateView.rating = item.rating;
    self.starRateView.delegate = self;
    self.starRateView.editable = NO;
    
    UIBlurEffect *blurrEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurrEffect];
    visualEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.backImageView.frame.size.height);
    [self.backImageView addSubview:visualEffectView];
    
    
    //스와이프 투 백 제스처 먹이기
    if (self.navigationController != nil) {
      self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    [self updateStarRatingButton];
    [self updateCommentButton];
    [self updateQuotationButton];
    
    [self.view layoutIfNeeded];
    
}

- (void)updateStarRatingButton
{
    if (self.starRateView.rating == 0) {
        
        self.starRateLabel.text = @"평가하기";
        [self.starRateLabel setTextColor:[UIColor grayColor]];
        self.starRateImageView.image =[UIImage imageNamed:@"detailIcon1RatingOff"];
        
    } else {
        self.starRateLabel.text = @"평가함";
        self.starRateImageView.image =[UIImage imageNamed:@"detailIcon1RatingOn"];
        
    }
}

- (void)updateCommentButton
{
    if (self.detailViewCommentLabel.text.length == 11) {
        
        self.commenButtontLabel.text = @"코멘트";
        [self.commenButtontLabel setTextColor:[UIColor grayColor]];
        self.commentImageView.image =[UIImage imageNamed:@"detailIcon2CommentOff"];
        
    } else {
        self.commenButtontLabel.text = @"코멘트";
        self.commentImageView.image =[UIImage imageNamed:@"detailIcon2CommentOn"];
        
    }
}

- (void)updateQuotationButton
{
    if (self.decriptionLabel.text.length == 11) {
        
        self.descriptionLabel.text = @"기억에 남는 구절";
        [self.descriptionLabel setTextColor:[UIColor grayColor]];
        self.descriptionImageView.image =[UIImage imageNamed:@"detailIcon3QuoteOff"];
        
    }else{
        self.descriptionLabel.text = @"기억에 남는 구절";
        // [self.descriptionLabel setTextColor:[UIColor redColor]];
        self.descriptionImageView.image =[UIImage imageNamed:@"detailIcon3QuoteOn"];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    



    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rateView:(RateView *)rateView ratingDidChange:(CGFloat)rating {
    //기록
    
    NSLog(@"%f", rating);
   
    self.starInteger.text = [NSString stringWithFormat:@"%.1f",rating];
    
}
- (IBAction)backButtonSelected:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
