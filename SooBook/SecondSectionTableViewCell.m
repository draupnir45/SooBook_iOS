//
//  SecondCell.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "SecondSectionTableViewCell.h"

@implementation SecondSectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
