//
//  SBCommentViewController.h
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 13..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBCommentViewController;
@protocol SBCommentViewControllerDelegate

//- (void)commentViewController:(SBCommentViewController *)commentVC didSelectedSaveButton:(UIBarButtonItem *)sender;
- (void)commentViewController:(SBCommentViewController *)commentVC didUpdateCommentAtItem:(SBBookData *)item;

@end

@interface SBCommentViewController : UIViewController
@property NSInteger bookPrimaryKey;
@property id <SBCommentViewControllerDelegate> delegate;
@end
