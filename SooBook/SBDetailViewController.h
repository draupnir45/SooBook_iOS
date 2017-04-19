//
//  DetailViewController.h
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 31..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bookCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *decriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *starInteger;
@property (weak, nonatomic) IBOutlet UILabel *detailViewCommentLabel;

@property NSInteger bookPrimaryKey;
@property SBBookData *item;

@end
