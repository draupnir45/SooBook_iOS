//
//  SBDataCenter.m
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBDataCenter.h"
@interface SBDataCenter ()

@property (readwrite) NSArray *myBookDatas;
@property NSFileManager *fileManager;
@property NSString *documentDirPath;

@end

@implementation SBDataCenter

//***************************테스트를 위해 plist로 작성하였습니다.

+ (instancetype)sharedBookData
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
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *item in dataArray) {
            SBBookData *book = [[SBBookData alloc] initWithDictionary:item];
            [tempArray addObject:book];
        }
        
        self.myBookDatas = [NSArray arrayWithArray:tempArray];
        
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
    NSString *docuPath = [(NSString *)([paths objectAtIndex:0]) stringByAppendingString:@"/TempBookData.plist"];
    
    return docuPath;
}

#pragma mark - 책 등록/삭제 Add or Remove Book

- (void)addBook:(SBBookData *)book completion:(SBDataCompletion)completion
{
    
    NSMutableArray *mutableCopy = [self.myBookDatas mutableCopy];
    
    [mutableCopy addObject:book];
    
    self.myBookDatas = mutableCopy;
    
    [self saveData];
    
    completion(YES, book);
    
}

- (void)removeBook:(SBBookData *)book completion:(SBDataCompletion)completion
{
    
    NSMutableArray *mutableCopy = [self.myBookDatas mutableCopy];
    
    [mutableCopy removeObject:book];
    
    self.myBookDatas = mutableCopy;
    
    [self saveData];
    
    completion(YES, book);
}

@end
