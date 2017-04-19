//
//  SBDataCenter.m
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBDataCenter.h"
@interface SBDataCenter ()


@property (readwrite) NSArray *dataArray;
@property NSInteger nextPageNumb;
@property BOOL haveNextPage;


//-------------------테스트용
@property (readwrite) NSArray *myBookDatas;
@property NSFileManager *fileManager;
@property NSString *documentDirPath;

@end

@implementation SBDataCenter

//***************************테스트를 위해 plist로 작성하였습니다.

+ (instancetype)defaultCenter
{
    static SBDataCenter *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SBDataCenter alloc] init];
    });
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.documentDirPath = [SBDataCenter documentDiretoryPath];
        self.fileManager = [NSFileManager defaultManager];
        
        NSArray *dataArray;
        
        if ([self.fileManager fileExistsAtPath:self.documentDirPath]) {
            //저장했던 내용 로드
            dataArray = [NSArray arrayWithContentsOfFile:self.documentDirPath];
            
            
        } else  {
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"TempBookData" ofType:@"plist"];
            
            //데이터용 프로퍼티에 번들 내용을 넣음
            dataArray = [NSArray arrayWithContentsOfFile:bundlePath];
        }
        
        self.myBookDatas = [self fetchSearchResultsWithArray:dataArray];
        
    }
    return self;
}

#pragma mark - 데이터 저장

- (void)saveData
{
    if (![self.fileManager fileExistsAtPath:self.documentDirPath]) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"TempBookData" ofType:@"plist"];
        [self.fileManager copyItemAtPath:bundlePath toPath:self.documentDirPath error:nil];
    }
    [self.myBookDatas writeToFile:self.documentDirPath atomically:NO];
}

#pragma mark - 플리스트 관리 Plist Utilities

+ (NSString *)documentDiretoryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docuPath = [(NSString *)[paths objectAtIndex:0] stringByAppendingString:@"/TempBookData.plist"];
    
    return docuPath;
}

#pragma mark - List

- (void)loadMyBookListWithPage:(NSInteger)page completion:(SBDataCompletion)completion
{
    __weak SBDataCenter *weakSelf = self;
    [SBNetworkManager loadMyBookListWithPage:page completion:^(BOOL sucess, id data) {
        if (sucess) { //넘겨주기 전에 fetch합니다.
            if (page == 1) {            //만약에 첫페이지를 부르는 거라면(첫 요청) 기존 데이터를 지우고 넣을 것.
                self.dataArray = [weakSelf fetchMyBooksWithArray:data[@"results"]];
            } else {
                NSMutableArray *newBookDatas = [weakSelf.myBookDatas mutableCopy];
                [newBookDatas addObjectsFromArray:[weakSelf fetchMyBooksWithArray:data[@"results"]]];
                self.myBookDatas = newBookDatas;
            }

            //만약에 첫 페이지가 아닌데, 책 번호가 다르다면 첫 페이지로 재요청.......을 추후에 예외처리하는 것으로 하고
            
            
            if (data[@"next"] != [NSNull null]) {
                self.nextPageNumb = page + 1;
                self.haveNextPage = YES;
            } else {
                self.haveNextPage = NO;
            }
            
        }
        completion(sucess, data);
    }];
    
}

- (void)loadNextMyBookListWithCompletion:(SBDataCompletion)completion {
    if (self.haveNextPage) {
        [self loadMyBookListWithPage:self.nextPageNumb completion:completion];
    } else {
        completion(NO, nil);
    }
}

- (void)loadMyBookWithBookID:(NSInteger)bookID completion:(SBDataCompletion)completion
{
    __weak SBDataCenter *weakSelf = self;
    [SBNetworkManager loadMyBookWithBookID:bookID completion:^(BOOL sucess, id data) {
        if (sucess) {
            SBBookData *book = [weakSelf fetchMyBookWithDictionary:[(NSArray *)data firstObject]];
            completion(sucess, book);
        } else {
            completion(sucess, data);
        }
    }];
}

#pragma mark - 책 검색, 등록, 삭제 (Search, Add or Remove Book)
- (void)searchWithQuery:(NSString *)query
             completion:(SBDataCompletion)completion
{
    __weak SBDataCenter *weakSelf = self;
    [SBNetworkManager searchWithQuery:query completion:^(BOOL sucess, id data) {
        if (sucess) { //넘겨주기 전에 fetch합니다.
            NSMutableDictionary *mutableData = [(NSDictionary *)data mutableCopy];
            NSArray *fetchedResult = [weakSelf fetchSearchResultsWithArray:[mutableData objectForKey:@"results"]];
            [mutableData setObject:fetchedResult forKey:@"results"];
            data = mutableData;
        }
        
        completion(sucess, data);

    }];
}

- (void)nextSearchResultWithURLString:(NSString *)urlString
                           completion:(SBDataCompletion)completion
{
    __weak SBDataCenter *weakSelf = self;
    [SBNetworkManager nextSearchResultWithURLString:urlString completion:^(BOOL sucess, id data) {
        if (sucess) { //넘겨주기 전에 fetch합니다.
            NSMutableDictionary *mutableData = [(NSDictionary *)data mutableCopy];
            NSArray *fetchedResult = [weakSelf fetchSearchResultsWithArray:[mutableData objectForKey:@"results"]];
            [mutableData setObject:fetchedResult forKey:@"results"];
            data = mutableData;
        }
        
        completion(sucess, data);
        
    }];
}

- (void)addBook:(NSInteger)bookID
     completion:(SBDataCompletion)completion
{
    [SBNetworkManager addBookWith:bookID completion:^(BOOL sucess, id data) {
        if (sucess) {
            //리스트 다시패치!
//            [self saveData];//나중에 뺄것!
        }
        completion(sucess, data);
    }];
}

- (void)deleteBook:(NSInteger)bookID
        completion:(SBDataCompletion)completion
{
    [SBNetworkManager deleteBookWith:bookID completion:^(BOOL sucess, id data) {
        if (sucess) {
            
            NSMutableArray *arrayForRemove = [[self dataArray] mutableCopy];
            [arrayForRemove removeObject:[self bookDataWithPrimaryKey:bookID]];
            //리스트 다시패치!
//            [self saveData];//나중에 뺄것!
        }
        completion(sucess, data);
    }];
}

#pragma mark - Model

///내 책장 안에 있는 책을 PK로 요구하면 반환해 줍니다.
- (SBBookData *)bookDataWithPrimaryKey:(NSInteger)primaryKey
{
    SBBookData *resultItem;
    
//    for (SBBookData *item in self.myBookDatas) {
//        if (item.bookPrimaryKey == primaryKey) {
//            resultItem = item;
//        }
//    }
    
    for (SBBookData *item in self.dataArray) {
        if (item.bookPrimaryKey == primaryKey) {
            resultItem = item;
        }
    }
    
    return resultItem;
}

///딕셔너리가 담긴 어레이를 이용해 북데이터를 페치합니다.
- (NSArray *)fetchSearchResultsWithArray:(NSArray <NSDictionary *> *)array
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary *item in array) {
        SBBookData *book = [[SBBookData alloc] initWithDictionary:item];
        [tempArray addObject:book];
    }
    return tempArray;
}

- (NSArray *)fetchMyBooksWithArray:(NSArray <NSDictionary *> *)array
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary *item in array) {
        SBBookData *book = [self fetchMyBookWithDictionary:item];
        [tempArray addObject:book];
    }
    return tempArray;
}

- (SBBookData *)fetchMyBookWithDictionary:(NSDictionary *)dictionary
{
    SBBookData *book = [[SBBookData alloc] initWithDictionary:dictionary[@"book"]];
    book.rating = [[SBBookStarRating alloc] initWithDictionary:[dictionary[@"star"] firstObject]];
    book.comment = [[SBBookComment alloc] initWithDictionary:[dictionary[@"comment"] firstObject]];
    book.mybookID = [dictionary[@"mybook_id"] integerValue];
    
    //dataArray도 바꾸어 줍니다.
    SBBookData *targetItem = [self bookDataWithPrimaryKey:book.bookPrimaryKey];
    NSMutableArray *mutableData = [[self dataArray] mutableCopy];
    NSInteger index = [mutableData indexOfObject:targetItem];
    [mutableData replaceObjectAtIndex:index withObject:book];
    
    return book;
}

- (void)addCommentWithBookID:(NSInteger)bookID content:(NSString *)content completion:(SBDataCompletion)completion {
    SBBookData *targetItem = [self bookDataWithPrimaryKey:bookID];
    [SBNetworkManager addCommentWithMyBookID:targetItem.mybookID content:content completion:completion];
}

- (void)addRateWithBookID:(NSInteger)bookID score:(CGFloat)score completion:(SBDataCompletion)completion {
    SBBookData *targetItem = [self bookDataWithPrimaryKey:bookID];
    [SBNetworkManager addRateWithMyBookID:targetItem.mybookID score:score completion:completion];
}

@end
