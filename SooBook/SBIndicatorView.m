//
//  SBIndicatorViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBIndicatorView.h"

@interface SBIndicatorView ()

@property UIView *grayView;
@property UIView *blackView;
@property UIActivityIndicatorView *activityIndicator;
@property UILabel *messageLabel;

@end

@implementation SBIndicatorView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.grayView = [[UIView alloc]init];
        [self addSubview:self.grayView];
        
        self.blackView = [[UIView alloc]init];
        [self.grayView addSubview:self.blackView];
        
        self.messageLabel = [[UILabel alloc]init];
        [self.blackView addSubview:self.messageLabel];
        [self.messageLabel setTextColor:[UIColor whiteColor]];
        [self.messageLabel setFont:[UIFont systemFontOfSize:20]];
        [self.messageLabel setTextAlignment:NSTextAlignmentCenter];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.grayView addSubview:self.activityIndicator];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.grayView setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    CGFloat centerX = self.grayView.frame.size.width / 2;
    CGFloat centerY = self.grayView.frame.size.height / 2;
    self.grayView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    if (self.haveMessage) {
        [self.blackView setFrame:CGRectMake(0, 0, 120, 120)];
        [self.blackView.layer setCornerRadius:10.0f];
        self.blackView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self.blackView setCenter:CGPointMake(centerX, centerY)];
        
        [self.messageLabel setFrame:CGRectMake(0, 60, 120, 60)];
        
        
        [self.activityIndicator setCenter:CGPointMake(centerX, centerY-16)];
    } else {
        [self.blackView setFrame:CGRectMake(0, 0, 60, 60)];
        [self.blackView.layer setCornerRadius:10.0f];
        self.blackView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self.blackView setCenter:CGPointMake(centerX, centerY)];
        
        [self.activityIndicator setCenter:CGPointMake(centerX, centerY)];
        
    }
    


}

- (void)startIndicatorOnView:(UIView *)targetView
{
    [targetView addSubview:self];
    [self setFrame:targetView.frame];
    [self layoutSubviews];
    
    [self.activityIndicator startAnimating];
}

- (void)startIndicatorOnView:(UIView *)targetView withMessage:(NSString *)message
{
    [targetView addSubview:self];
    [self setFrame:targetView.frame];
    self.haveMessage = YES;
    self.messageLabel.text = message;
    [self layoutSubviews];
    
    [self.activityIndicator startAnimating];
}

- (void)stopIndicator
{
    [self removeFromSuperview];
    [self.activityIndicator stopAnimating];
    self.haveMessage = NO;
    self.messageLabel.text = @"";
}

@end
