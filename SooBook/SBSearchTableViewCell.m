//
//  SBSearchTableViewCell.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 10..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBSearchTableViewCell.h"

@interface SBSearchTableViewCell ()
@property SBBookData *bookData;
@property SBDataCenter *dataCenter;

@end

@implementation SBSearchTableViewCell
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.dataCenter = [SBDataCenter sharedBookData];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor sb_grayForGradColor]CGColor], nil];
    [self.contentView.layer insertSublayer:gradient atIndex:0];
    self.gradient = gradient;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gradient.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setCellDataWithImageName:(NSString*)imageName
//                           title:(NSString*)title
//                        subtitle:(NSString*)subtitle
//{
//    self.bookCoverImageView.image = [UIImage imageNamed:imageName];
//    self.titleLabel.text = title;
//    self.subtitleLabel.text = subtitle;
//}
- (IBAction)addOrRemoveFromMyBook:(UIButton *)sender
{
    if (!sender.selected)
    {
        [sender setSelected:YES];
      //셀렉티드면 추가해야하지
//            [self.dataCenter addBook:self.bookData completion:^(BOOL sucess, id data) {
//                
//
//            }];
    } else {
      //없애
        [sender setSelected:NO];
    }
    
}

@end
