//
//  CustomTableViewCell.h
//  SooBook
//
//  Created by 박찬웅 on 2017. 3. 29..
//  Copyright © 2017년 Parkchanwoong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBCustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *tableViewCellLabel;
@property (strong, nonatomic) IBOutlet UITextField *tableViewCellTextField;

@end