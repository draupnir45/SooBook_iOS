//
//  DetailViewController.h
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 31..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bookCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *contentsLabel;


@property (weak, nonatomic) IBOutlet UILabel *datilViewLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

//임시, 데이터모델 만든 후 교체 필요
@property NSString *secondString;
@property NSString *imageString;
@property NSString *contentsString;
@property NSString *mainNameString;

@end
