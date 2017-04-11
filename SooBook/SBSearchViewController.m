//
//  SBSearchViewController.m
//  SooBook
//
//  Created by 박찬웅 on 2017. 4. 10..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBSearchViewController.h"
#import "SBSearchTableViewCell.h"

@interface SBSearchViewController ()
<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate,UISearchResultsUpdating>

@property NSArray *allData;
@property NSArray *resultData;


@property IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation SBSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SBSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"SBSearchTableViewCell"];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterText:(NSString *)str
{
    //self.resultData = [self.allData mutableCopy];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", str];
    
    self.resultData = [self.allData filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

#define mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if(self.searchController.isActive && (self.searchController.searchBar.text.length > 0))
//    {
//        return self.resultData.count;
//    }
//    return self.allData.count;
 
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBBookData *item = [[[SBDataCenter sharedBookData] myBookDatas] objectAtIndex:indexPath.row];
    SBSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBSearchTableViewCell" forIndexPath:indexPath];
    
    
    [cell setCellDataWithImageName:item.imageURL
                             title:item.title
                          subtitle:item.author];
    cell.bookPrimaryKey = item.bookPrimaryKey;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self filterText:searchController.searchBar.text];
}

//헤더와 풋터 1을 줌
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"서치버튼 눌렀습니다.");
}

@end
