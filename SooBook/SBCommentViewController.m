//
//  SBCommentViewController.m
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 13..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBCommentViewController.h"
#import "SZTextView.h"
#import "RateView.h"



@interface SBCommentViewController ()
<UINavigationBarDelegate, RateViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewBottom;
@property (weak, nonatomic) IBOutlet SZTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet RateView *starRateView;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;



@end

@implementation SBCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self observeKeyboard];
    
    SBBookData *item = [[SBDataCenter sharedBookData] bookDataWithPrimaryKey:self.bookPrimaryKey];
    

    
    self.starRateView.delegate = self;
    self.starRateView.editable = YES;
    self.textView.textContainerInset = UIEdgeInsetsMake(16, 16, 16, 16);
    
    
    self.starRateView.rating = item.rating;
//    
//    UINavigationItem *titleItem = [[UINavigationItem alloc] initWithTitle:item.title];
    _navigationBar.topItem.title = item.title;
//    self.titleItem = titleItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationBarDelegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}
- (IBAction)cancelButtonSelected:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    //THIS WILL MAKE SURE KEYBOARD DOESNT JUMP WHEN OPENING QUICKTYPE/EMOJI OR OTHER KEYBOARDS.
    NSInteger kbHeight = 0;
    NSInteger height = 0;
    self.stackViewBottom.constant = height;
    self.stackViewBottom.constant = height;
    
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGRect finalKeyboardFrame = [self.view convertRect:keyboardFrame fromView:self.view.window];
    
    kbHeight = finalKeyboardFrame.size.height;
    
    height = kbHeight + self.stackViewBottom.constant;
    
    self.stackViewBottom.constant = height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.stackViewBottom.constant = 10;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)rateView:(RateView *)rateView ratingDidChange:(CGFloat)rating {
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f",rating];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
