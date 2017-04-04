//
//  FirstTableViewCell.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self.firstCollectionViewCell registerNib:[UINib nibWithNibName:@"NibFirstCollectionViewCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:@"nibFirstCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
