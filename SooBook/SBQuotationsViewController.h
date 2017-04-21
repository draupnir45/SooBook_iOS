//
//  SBQuotationsViewController.h
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 15..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBCommentaryViewController.h"

@interface SBQuotationsViewController : SBCommentaryViewController

@property NSArray <SBQuotation *> *originalDataArray;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@end
