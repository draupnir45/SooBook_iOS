//
//  SBIndicatorViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBIndicatorViewController.h"

@interface SBIndicatorViewController ()

@end

@implementation SBIndicatorViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)setIndicator
{
    
    
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
    CGFloat centerX = grayView.frame.size.width / 2;
    CGFloat centerY = grayView.frame.size.height / 2;
    grayView.backgroundColor = [UIColor colorWithRed:169 / 255.0 green:169 / 255.0 blue:169 / 255.0 alpha:0.3];
    [self.view addSubview:grayView];
    
    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    blackView.backgroundColor = [UIColor blackColor];
    [blackView setCenter:CGPointMake(centerX, centerY)];
    [grayView addSubview:blackView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [grayView addSubview:activityIndicator];
    //    activityIndicator.center = CGPointMake(centerX, centerY);
    [activityIndicator setCenter:CGPointMake(centerX, centerY)];
    
    [activityIndicator startAnimating];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
