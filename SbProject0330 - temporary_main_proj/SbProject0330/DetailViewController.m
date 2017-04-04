//
//  DetailViewController.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 31..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "DetailViewController.h"
#import "RateView.h"


@interface DetailViewController ()
<RateViewDelegate>
@property (weak, nonatomic) IBOutlet RateView *starRateView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.secondLabel.text    = self.secondString;
    self.datailViewImage.image = [UIImage imageNamed:self.imageString];
    self.datilViewLabel.text    = self.contentsString;
    self.backImageView.image = [UIImage imageNamed:self.imageString];
    self.navigationItem.title = self.mainNameString;
 
    self.starRateView.rating = 2;
    self.starRateView.delegate = self;
    self.starRateView.editable = YES;
    self.starRateView.maxRating = 5;
    
//    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(100,100, 70, 40)];
//    [back setTitle:@"내 책장" forState:UIControlStateNormal];
//
//    [back setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [back addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:back];
//    self.navigationItem.leftBarButtonItem = item;
  //  오른쪽버튼
    UIButton *back1 = [[UIButton alloc]initWithFrame:CGRectMake(100,100, 50, 40)];
   // [back1 setBackgroundImage:[UIImage imageNamed:@"검색"] forState:UIControlStateNormal];
    [back1 setTitle:@"검색" forState:UIControlStateNormal];
    [back1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
 
    [back1 addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:back1];
    self.navigationItem.rightBarButtonItem = item1;

    
}
- (void)backBtnClick:(UIButton *)sender{
    NSLog(@"back log");
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    //기록
}

@end
