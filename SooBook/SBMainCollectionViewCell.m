//
//  SBMainCollectionViewCell.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 7..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBMainCollectionViewCell.h"

@implementation SBMainCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    //get ratio and layout bookcover
    CGFloat heightByWidthRatio = [SBMainCollectionViewCell getImageRatioWithImage:self.coverImageView.image];
    
    if (heightByWidthRatio <= (172.0f/96.0f))
    {
        CGFloat newHeight = heightByWidthRatio * 96.0f;
        self.coverImageView.frame = CGRectMake(0, self.frame.size.height - newHeight, 96.0f, newHeight);
    } else {
        CGFloat newWidth = 172.0f / heightByWidthRatio;
        self.coverImageView.frame = CGRectMake((self.bounds.size.width - newWidth) / 2, 0, newWidth, 172.0f);
    }
    
    
    NSLog(@"%@",[UIDevice currentDevice].model);
    NSLog(@"layoutSubviews");
}

+ (CGFloat)getImageRatioWithImage:(UIImage *)image
{
    return image.size.height/image.size.width;
}
@end
