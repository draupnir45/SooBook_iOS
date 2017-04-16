//
//  SBDataCenter.h
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBBookData;



//책 등록 및 삭제를 위한 ENUM
typedef NS_ENUM(NSUInteger, SBNetworkBookRegisterResponse)
{
    SBNetworkBookRegisterResponseOK,
    SBNetworkBookRegisterResponseUnknownError
};

typedef NS_ENUM(NSUInteger, SBNetworkBookRemoveResponse)
{
    SBNetworkBookRemoveResponseOK,
    SBNetworkBookRemoveResponseUnknownError
};

@interface SBDataCenter : NSObject


@property (readonly) NSArray *myBookDatas;

//+ (instancetype)sharedBookData;
+ (instancetype)defaultCenter;

//책 추가 및 삭제
- (void)addBook:(NSInteger)bookID
     completion:(SBDataCompletion)completion;

- (void)deleteBook:(NSInteger)bookID
        completion:(SBDataCompletion)completion;

- (SBBookData *)bookDataWithPrimaryKey:(NSInteger)primaryKey;

//내 책 불러오기
- (void)loadMyBookListWithPage:(NSInteger)page
                    completion:(SBDataCompletion)completion;

///검색용 메서드
- (void)searchWithQuery:(NSString *)query
             completion:(SBDataCompletion)completion;

///다음 페이지를 가져오기 위한 메서드
- (void)nextSearchResultWithURLString:(NSString *)urlString
                           completion:(SBDataCompletion)completion;


@end
