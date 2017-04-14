//
//  NibFirstCollectionViewCell.h
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBBookCoverFlowCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *firstCollectionImage;

@property CGFloat heightByWidthRatio;
@property NSInteger bookPrimaryKey;

+ (CGFloat)getImageRatioWithImage:(UIImage *)image;

@end
