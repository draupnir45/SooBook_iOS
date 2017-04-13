//
//  NibFirstCollectionViewCell.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "BookCoverCollectionViewCell.h"

@implementation BookCoverCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews {
    //get ratio and layout bookcover
    CGFloat heightByWidthRatio = [BookCoverCollectionViewCell getImageRatioWithImage:self.firstCollectionImage.image];
    
    if (heightByWidthRatio <= (172.0f/96.0f)) {
        CGFloat newHeight = heightByWidthRatio * 96.0f;
        self.firstCollectionImage.frame = CGRectMake(0, self.frame.size.height - newHeight, 96.0f, newHeight);
    } else {
        CGFloat newWidth = 172.0f / heightByWidthRatio;
        self.firstCollectionImage.frame = CGRectMake(0, 0,newWidth, 172.0f);
    }
    
//    NSLog(@"layoutSubviews");
}

+ (CGFloat)getImageRatioWithImage:(UIImage *)image
{
    return image.size.height/image.size.width;
}

@end
