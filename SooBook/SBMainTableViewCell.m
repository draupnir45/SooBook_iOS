//
//  SecondCell.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "SBMainTableViewCell.h"
#import "RateView.h"

@interface SBMainTableViewCell ()

@property CAGradientLayer *gradient;

@end

@implementation SBMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor sb_grayForGradColor]CGColor], nil];
    [self.contentView.layer insertSublayer:gradient atIndex:0];
    [self.backgroundView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    
    self.gradient = gradient;
  
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradient.frame = self.bounds;
}


- (void)setCellDataWithImageName:(NSString*)imageName
                           title:(NSString*)title
                        subtitle:(NSString*)subtitle
{
    self.bookCoverImageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = title;
    self.subtitleLabel.text = subtitle;
}

@end
