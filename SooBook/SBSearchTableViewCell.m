//
//  SBSearchTableViewCell.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 10..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBSearchTableViewCell.h"

@implementation SBSearchTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataWithImageName:(NSString*)imageName
                           title:(NSString*)title
                        subtitle:(NSString*)subtitle
{
    self.bookCover.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = title;
    self.authorLabel.text = subtitle;
}
- (IBAction)zzz:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
}

@end
