//
//  FirstSectionHeaderCell.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "FirstSectionHeaderCell.h"
#import "UIColor+SBAdditions.h"

@implementation FirstSectionHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [UIColor sb_brownBlackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
