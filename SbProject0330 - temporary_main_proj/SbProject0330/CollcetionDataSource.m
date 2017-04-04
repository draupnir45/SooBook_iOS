//
//  CollcetionDataSource.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "CollcetionDataSource.h"
//#import "FirstCollectionViewCell.h"
#import "NibFirstCollectionViewCell.h"

@implementation CollcetionDataSource

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
    
    NibFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nibFirstCollectionViewCell" forIndexPath:indexPath];
    cell.firstCollectionImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg",indexPath.item+1]];
    
    cell.tag = indexPath.row;
    return cell;
}


@end
