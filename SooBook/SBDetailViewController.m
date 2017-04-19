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
#import "SBCommentViewController.h"
#import "NSMutableAttributedString+JCAdditions.h"

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
@property (weak, nonatomic) IBOutlet UIButton *addButton;


@end

@implementation SBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    SBBookData *item = [[SBDataCenter defaultCenter] bookDataWithPrimaryKey:self.bookPrimaryKey];
    
    NSString *encodedStr = [item.imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *encodedImageURL = [NSURL URLWithString:encodedStr];
    
    [self.bookCoverImageView sd_setImageWithURL:encodedImageURL];
    [self.backImageView sd_setImageWithURL:encodedImageURL];
    
    self.subtitleLabel.text = item.author;
//    self.decriptionLabel.text = item.shortDescription;
    self.decriptionLabel.attributedText = [NSMutableAttributedString attrStringWithString:item.shortDescription lineSpacing:8.0 paragraphSpacing:20.0];
    self.mainTitleLabel.text = item.title;
    
    if ([item.comment.content length] > 0) {
        self.detailViewCommentLabel.attributedText = [NSMutableAttributedString attrStringWithString:item.comment.content lineSpacing:8.0 paragraphSpacing:20.0];
    } else {
        self.detailViewCommentLabel.attributedText = [NSMutableAttributedString attrStringWithString:@"아직 책 소개가 없습니다." lineSpacing:8.0 paragraphSpacing:20.0];
    }
    

    
    //별점뷰 설정하기
    self.starRateView.rating = item.rating.score;
    self.starRateView.delegate = self;
    self.starRateView.editable = NO;
    
    //배경에 블러 먹이기
    UIBlurEffect *blurrEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurrEffect];
    visualEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.backImageView.frame.size.height);
    [self.backImageView addSubview:visualEffectView];
    
    //책 등록 버튼 설정
    self.addButton.selected = item.isMyBook;
    
    
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
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    
//}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CommentViewSegue"]) {
        SBCommentViewController *commentViewContoroller = segue.destinationViewController;
        commentViewContoroller.bookPrimaryKey = self.bookPrimaryKey;
    }
}

- (IBAction)requestAddBook:(UIButton *)sender
{
    NSLog(@"requestAddBook");
    
//    [self.indicator startIndicatorOnView:self.view];
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
//    SBSearchTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
//    __weak SBIndicatorView *indicator = self.indicator;
    
    if (!sender.selected)
    {
        
        [[SBDataCenter defaultCenter] addBook:[self bookPrimaryKey] completion:^(BOOL sucess, id data) {
            if (sucess)
            {
                NSLog(@"YES");
                sender.selected = YES;
            } else {
                //책장에 책이 들어오지 못했다는 알럿창
            }
            
//            [indicator stopIndicator];
        }];
    } else {
        
        [[SBDataCenter defaultCenter] deleteBook:[self bookPrimaryKey] completion:^(BOOL sucess, id data) {
            if (sucess)
            {
                NSLog(@"NO");
                sender.selected = NO;
            } else {
                //책장에 책이 들어오지 못했다는 알럿창
            }
            
//            [indicator stopIndicator];
        }];
    }
}

@end
