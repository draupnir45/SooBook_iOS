//
//  SBSearchTableViewCell.h
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 10..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBSearchTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bookCoverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;
@property CAGradientLayer *gradient;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;


@property NSInteger bookPrimaryKey;


@end
