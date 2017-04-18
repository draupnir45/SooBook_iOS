//
//  NibFirstCollectionViewCell.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "SBBookCoverFlowCell.h"

@implementation SBBookCoverFlowCell

static CGFloat const HEIGHT = 172.0;
static CGFloat const WIDTH = 96.0;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews {
    //get ratio and layout bookcover
    if (self.firstCollectionImage.image) {
        CGFloat heightByWidthRatio = [SBBookCoverFlowCell getImageRatioWithImage:self.firstCollectionImage.image];
        
        if (heightByWidthRatio <= (HEIGHT/WIDTH)) {
            CGFloat newHeight = heightByWidthRatio * WIDTH;
            self.firstCollectionImage.frame = CGRectMake(0, self.frame.size.height - newHeight, WIDTH, newHeight);
        } else {
            CGFloat newWidth = HEIGHT / heightByWidthRatio;
            self.firstCollectionImage.frame = CGRectMake(0, 0,newWidth, HEIGHT);
        }
        
        NSLog(@"layoutSubviews");
    }

}

+ (CGFloat)getImageRatioWithImage:(UIImage *)image
{
    return image.size.height/image.size.width;
}

+ (CGFloat)cellHeight {
    return HEIGHT;
}

@end
