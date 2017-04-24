//
//  CollcetionDataSource.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "BookCoverCollectionViewDataSource.h"
#import "SBBookCoverFlowCell.h"

@implementation BookCoverCollectionViewDataSource

- (instancetype)initWithSbDataArray:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        self.dataArray = dataArray;
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.dataArray.count;
       //return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SBBookCoverFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SBBookCoverFlowCell" forIndexPath:indexPath];
    
    SBBookData *item = [self.dataArray objectAtIndex:indexPath.row];
    NSString *encodedStr = [item.imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [cell.firstCollectionImage setShowActivityIndicatorView:YES];
    [cell.firstCollectionImage setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.firstCollectionImage sd_setImageWithURL:[NSURL URLWithString:encodedStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error == nil && image != nil) {
                [cell layoutSubviews];
        }
    }];
//    cell.firstCollectionImage.image = [UIImage imageNamed:item.imageURL];

    cell.bookPrimaryKey = item.bookPrimaryKey;
   
   
    return cell;
}


@end
