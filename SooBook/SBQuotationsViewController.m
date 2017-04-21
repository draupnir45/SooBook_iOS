//
//  SBQuotationsViewController.m
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 15..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBQuotationsViewController.h"
#import "SBTextViewCell.h"
#import "SZTextView.h"

@interface SBQuotationsViewController ()
<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *dataArray;
@property NSArray *originalStringArray;
@property SBIndicatorView *indicator;


@end

@implementation SBQuotationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray new];
    self.indicator = [SBIndicatorView new];
    
    if (self.originalDataArray.count) {
        for (SBQuotation *item in self.originalDataArray) {
            [self.dataArray addObject:item.content];
            if ([self.dataArray count] == 0 ) {
                [self.dataArray addObject:@""];
            }
        }
        self.originalStringArray = self.dataArray;
    } else {
        self.originalStringArray = @[];
        [self.dataArray addObject:@""];
    }
    
    _navigationBar.title = self.title;
    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count + 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataArray.count) {
        return 80;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArray.count) {
        SBTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBTextViewCell" forIndexPath:indexPath];

        cell.textView.delegate = self;
        cell.textView.text = self.dataArray[indexPath.row];
        
        cell.textView.tag = indexPath.row;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddQuotationCell" forIndexPath:indexPath];
        return cell;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.dataArray[textView.tag] = textView.text;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataArray.count) {
        [self.dataArray addObject:@""];
        [tableView reloadData];
    }
}


- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (IBAction)cancelButtonSelected:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonSelected:(UIBarButtonItem*)sender {
    __weak SBQuotationsViewController *weakSelf = self;
    for (NSInteger i=0; i<self.dataArray.count; i++) {
        NSString *currentString = self.dataArray[i];
//        __block BOOL shouldReSave = NO;
        
        [self.indicator startIndicatorOnView:self.view];
        if (self.originalStringArray.count && ![currentString isEqualToString:self.originalStringArray[i]]) {
            [[SBDataCenter defaultCenter] editQuotationWithQuotationPk:[self.originalDataArray[i] pk] content:currentString completion:^(BOOL sucess, id data) {
                if (sucess) {
                    NSLog(@"edited");
                } else {
//                    shouldReSave = YES;
                }
                
                if (i == weakSelf.dataArray.count - 1) {
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    [self.indicator stopIndicator];
                }
            }];
        } else if (i >= self.originalStringArray.count) {
            [[SBDataCenter defaultCenter] addQuotationWithBookID:self.bookPrimaryKey content:currentString completion:^(BOOL sucess, id data) {
                if (sucess) {
                    NSLog(@"Added");
                } else {
                    NSLog(@"Failed");
//                    shouldReSave = YES;
                }
                
                if (i == weakSelf.dataArray.count - 1) {
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    [self.indicator stopIndicator];
                }
            }];
        }
        
    }
}


@end
