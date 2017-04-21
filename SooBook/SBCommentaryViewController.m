//
//  SBCommentaryViewController.m
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 21..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBCommentaryViewController.h"

@interface SBCommentaryViewController ()

@end

@implementation SBCommentaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateItemWithCompletion:(SBDataCompletion)completion {
    __weak SBCommentaryViewController *weakSelf = self;
    [[SBDataCenter defaultCenter] loadMyBookWithBookID:weakSelf.bookPrimaryKey completion:^(BOOL sucess, id data) {
        if (sucess) {
            [weakSelf.delegate commentaryViewController:self didUpdateCommentAtItem:data];
            completion(sucess, data);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
