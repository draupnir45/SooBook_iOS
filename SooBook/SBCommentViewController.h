//
//  SBCommentViewController.h
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 13..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBCommentaryViewController.h"

@class SBCommentViewController;
@protocol SBCommentViewControllerDelegate

//- (void)commentViewController:(SBCommentViewController *)commentVC didSelectedSaveButton:(UIBarButtonItem *)sender;
- (void)commentViewController:(SBCommentViewController *)commentVC didUpdateCommentAtItem:(SBBookData *)item;

@end

@interface SBCommentViewController : SBCommentaryViewController

@end
