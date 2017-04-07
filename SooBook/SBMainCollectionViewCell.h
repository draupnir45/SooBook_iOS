//
//  SBMainCollectionViewCell.h
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 7..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBMainCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property CGFloat heightByWidthRatio;
@property NSInteger bookPrimaryKey;
+ (CGFloat)getImageRatioWithImage:(UIImage *)image;
@end
