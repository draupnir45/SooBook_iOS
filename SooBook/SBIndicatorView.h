//
//  SBIndicatorViewController.h
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBIndicatorView : UIView

@property BOOL haveMessage;
//@property NSString *messageString;

- (void)startIndicatorOnView:(UIView *)targetView;
- (void)startIndicatorOnView:(UIView *)targetView withMessage:(NSString *)message;
- (void)stopIndicator;

@end
