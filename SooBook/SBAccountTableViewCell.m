//
//  CustomTableViewCell.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 3. 29..
//  Copyright © 2017년 Parkchanwoong. All rights reserved.
//

#import "SBAccountTableViewCell.h"

@implementation SBAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
