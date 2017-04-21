//
//  FirstTableViewCell.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "SBBookCoverFlowContainerCell.h"

@interface SBBookCoverFlowContainerCell ()

@property CAGradientLayer *gradient;

@end


@implementation SBBookCoverFlowContainerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CAGradientLayer *gradient = [CAGradientLayer layer];

    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor sb_grayForCollectionCellGradColor]CGColor], nil];
    [self.contentView.layer insertSublayer:gradient atIndex:0];
    [self.collectionView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    
    self.gradient = gradient;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradient.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
