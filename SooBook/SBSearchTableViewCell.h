//
//  SBSearchTableViewCell.h
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 10..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBSearchTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;


@property NSInteger bookPrimaryKey;

- (void)setCellDataWithImageName:(NSString*)imageName
                           title:(NSString*)title
                        subtitle:(NSString*)subtitle;

@end
