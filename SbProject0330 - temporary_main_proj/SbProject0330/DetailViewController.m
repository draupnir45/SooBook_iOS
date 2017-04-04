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


@interface DetailViewController ()
<RateViewDelegate>
@property (weak, nonatomic) IBOutlet RateView *starRateView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.subtitleLabel.text    = self.secondString;
    self.bookCoverImageView.image = [UIImage imageNamed:self.imageString];
    
    self.datilViewLabel.text    = self.contentsString;
    
    
    
    self.backImageView.image = [UIImage imageNamed:self.imageString];
    
    [JCBlurrManager blurrView:self.backImageView withEffectStyle:UIBlurEffectStyleDark];
    
    self.title = self.mainNameString;
 
    self.starRateView.rating = 2;
    self.starRateView.delegate = self;
    self.starRateView.editable = YES;
    self.starRateView.maxRating = 5;
    

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    //기록
}

@end
