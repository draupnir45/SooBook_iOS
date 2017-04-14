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
#pragma mark - Button
- (IBAction)addOrRemoveButtonSelected:(UIButton *)sender //addOrRemoveButtonSelected
{
    if (!sender.selected)
    {
        [sender setSelected:YES];
        
        [self requestAddBookWithBookID:self.bookData.bookPrimaryKey];
//        //내 책장에 추가
//        [self.dataCenter addBook:self.bookData completion:^(BOOL sucess, id data) {
//            if (sucess)
//            {
//                //책장에 책이 들어온다
//            } else {
//                //책장에 책이 들어오지 못했다는 알럿창
//            }
//        }];
//    } else {
//        [sender setSelected:NO];
//        //내 책장에서 없애
//        [self.dataCenter deleteBook:self.bookData completion:^(BOOL sucess, id data) {
//            if (sucess)
//            {
//                //책장에서 책이 빠져나간다
//            } else {
//               //책장에서 책이 빠져나가지 못했다는 알럿창
//            }
//        }];
    }
}

- (void)requestAddBookWithBookID:(NSInteger)bookId
{
    [self.dataCenter addBook:self.bookData completion:^(BOOL sucess, id data) {
        if (sucess)
        {
            //책장에 책이 들어온다
        } else {
            //책장에 책이 들어오지 못했다는 알럿창
        }
    }];
}

@end
