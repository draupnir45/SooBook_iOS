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
    
    self.dataCenter = [SBDataCenter defaultCenter];
    
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
#pragma mark - Button
//- (IBAction)addOrRemoveButtonSelected:(UIButton *)sender //addOrRemoveButtonSelected
//{
//    if (!sender.selected)
//    {
//        [self requestAddBook];
//    }
//}
//
//- (void)requestAddBook
//{
//
//    [self.dataCenter addBook:self.bookPrimaryKey completion:^(BOOL sucess, id data) {
//            if (sucess)
//            {
//                NSLog(@"YES");
//            } else {
//                //책장에 책이 들어오지 못했다는 알럿창
//            }
//        
////        [self updateFavoriteButton];
//    }];
//
//}
//
//- (void)updateFavoriteButton {
//    self.favoriteButton.selected = self.isMyBook;
//}

@end
