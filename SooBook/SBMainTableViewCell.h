//
//  SecondCell.h
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface SBMainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet RateView *starRateView;
@property (weak, nonatomic) IBOutlet UILabel *starRateLabel;

@property NSInteger bookPrimaryKey;

- (void)setCellDataWithImageName:(NSString*)imageName
                           title:(NSString*)title
                        subtitle:(NSString*)subtitle;
@end
