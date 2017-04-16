//
//  SBNetworkManager.h
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 1..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>


//데이터 요청용 블록
typedef void (^SBDataCompletion)(BOOL sucess, id data);

@interface SBNetworkManager : NSObject

+ (void)signUpWithUserID:(NSString *)userID
                password:(NSString *)password
                nickName:(NSString *)nickName
              completion:(SBDataCompletion)completion;

+ (void)logInWithUserID:(NSString *)userID
               password:(NSString *)password
             completion:(SBDataCompletion)completion;

+ (void)logOut;

///검색용 메서드
+ (void)searchWithQuery:(NSString *)query
             completion:(SBDataCompletion)completion;
+ (void)nextSearchResultWithURLString:(NSString *)urlString
                           completion:(SBDataCompletion)completion;


///책 추가
+ (void)addBookWith:(NSInteger)bookID completion:(SBDataCompletion)completion;

///책 삭제
+ (void)deleteBookWith:(NSInteger)bookID completion:(SBDataCompletion)completion;

///검색시 다음 페이지를 가져오기 위한 메서드

///내 책 목록 가져오기
+ (void)loadMyBookListWithPage:(NSInteger)page completion:(SBDataCompletion)completion;

@end
