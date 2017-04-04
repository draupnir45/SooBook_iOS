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

+ (void)logOutWithToken:(NSString *)token;

@end
