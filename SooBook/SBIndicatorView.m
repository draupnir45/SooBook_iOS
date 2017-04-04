//
//  SBIndicatorViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBIndicatorView.h"

@interface SBIndicatorView ()

@end

@implementation SBIndicatorView

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self setIndicator];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setIndicator];
    }
    return self;
}

- (void)setIndicator
{
       
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    CGFloat centerX = grayView.frame.size.width / 2;
    CGFloat centerY = grayView.frame.size.height / 2;
    grayView.backgroundColor = [UIColor colorWithRed:169 / 255.0 green:169 / 255.0 blue:169 / 255.0 alpha:0.7];
    [self addSubview:grayView];
    
    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [blackView.layer setCornerRadius:20.0f];
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
