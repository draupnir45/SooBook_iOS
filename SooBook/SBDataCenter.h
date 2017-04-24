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
@property (readonly) NSArray *dataArray;


+ (instancetype)defaultCenter;

//책 추가 및 삭제
- (void)addBook:(NSInteger)bookID
     completion:(SBDataCompletion)completion;

- (void)deleteBook:(NSInteger)bookID
        completion:(SBDataCompletion)completion;

- (SBBookData *)bookDataWithPrimaryKey:(NSInteger)primaryKey;

///내 책들 불러오기
- (void)loadMyBookListWithPage:(NSInteger)page
                    completion:(SBDataCompletion)completion;

///내 책 불러오기
- (void)loadMyBookWithBookID:(NSInteger)bookID
                  completion:(SBDataCompletion)completion;


///레이팅 리스트 불러오기
- (void)loadRatingListWithCompletion:(SBDataCompletion)completion;

///검색용 메서드
- (void)searchWithQuery:(NSString *)query
             completion:(SBDataCompletion)completion;

///다음 페이지를 가져오기 위한 메서드
- (void)nextSearchResultWithURLString:(NSString *)urlString
                           completion:(SBDataCompletion)completion;


///코멘트 추가하기. 있는 거에 추가하면 교체됨.
- (void)addCommentWithBookID:(NSInteger)bookID
                     content:(NSString *)content
                  completion:(SBDataCompletion)completion;

///별점 추가하기. 있는 거에 추가하면 교체됨.
- (void)addRateWithBookID:(NSInteger)bookID
                    score:(CGFloat)score
               completion:(SBDataCompletion)completion;

- (void)addQuotationWithBookID:(NSInteger)bookID content:(NSString *)content completion:(SBDataCompletion)completion;
- (void)editQuotationWithQuotationPk:(NSInteger)pk content:(NSString *)content completion:(SBDataCompletion)completion;
- (void)deleteQuotationWithQuotationPk:(NSInteger)pk completion:(SBDataCompletion)completion;


//- (void)loadAllMyBookListWithPage:(NSInteger)page completion:(SBDataCompletion)completion;\


@end
