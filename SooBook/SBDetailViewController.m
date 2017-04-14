//
//  DetailViewController.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 31..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "SBDetailViewController.h"
#import "RateView.h"
#import "JCBlurrManager.h"
#import "SBDataCenter.h"
#import "SBBookData.h"

@interface SBDetailViewController ()
<RateViewDelegate>
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
   
    //self.navigationItem.title = item.title;
    
 
    self.starRateView.rating = 1;
    self.starRateView.delegate = self;
    self.starRateView.editable = YES;
    self.starRateView.maxRating = 5;
    
//   if (self.navigationController != nil)
//    {
//      self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
    if (self.starRateView.rating == 0) {
        
        self.starRateLabel.text = @"평가하기";
        [self.starRateLabel setTextColor:[UIColor grayColor]];
        self.starRateImageView.image =[UIImage imageNamed:@"detailIcon1RatingOff"];
                
    }else{
        self.starRateLabel.text = @"평가함";
        self.starRateImageView.image =[UIImage imageNamed:@"detailIcon1RatingOn"];
        
    }
    
    if (self.detailViewCommentLabel.text.length == 11) {
        
        self.commenButtontLabel.text = @"코멘트";
        [self.commenButtontLabel setTextColor:[UIColor grayColor]];
        self.commentImageView.image =[UIImage imageNamed:@"detailIcon2CommentOff"];
        
    }else{
        self.commenButtontLabel.text = @"코멘트";
        self.commentImageView.image =[UIImage imageNamed:@"detailIcon2CommentOn"];
        
    }
    
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
