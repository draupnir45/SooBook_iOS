//
//  SBCommentaryViewController.h
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 21..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBCommentaryViewController;
@protocol SBCommentaryViewControllerDelegate

//- (void)commentViewController:(SBCommentViewController *)commentVC didSelectedSaveButton:(UIBarButtonItem *)sender;
- (void)commentaryViewController:(SBCommentaryViewController *)commentVC didUpdateCommentAtItem:(SBBookData *)item;

@end

@interface SBCommentaryViewController : UIViewController

@property NSInteger bookPrimaryKey;
@property id <SBCommentaryViewControllerDelegate> delegate;
- (void)updateItemWithCompletion:(SBDataCompletion)completion;

@end
