//
//  SecondCell.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDataWithImagename:(NSString*)imgUrlstr
                   mainText:(NSString*)main
                   asubText:(NSString*)asub{
    self.sceondCellImage.image = [UIImage imageNamed:imgUrlstr];
    self.secondCellTitleLabel.text = main;
    self.secondCellsSubLabel.text = asub;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
