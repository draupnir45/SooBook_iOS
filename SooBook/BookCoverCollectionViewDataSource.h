//
//  CollcetionDataSource.h
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BookCoverCollectionViewDataSource : NSObject
<UICollectionViewDataSource>

@property NSArray *dataArray;

- (instancetype)initWithSbDataArray:(NSArray *)dataArray;

@end
