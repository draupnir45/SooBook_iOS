//
//  AuthCenter.h
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>

//회원가입을 위한 리스폰스 타입
typedef NS_ENUM(NSUInteger, SBNetworkSignUpResponse)
{
    SBNetworkSignUpResponseFailed = 0, //회원가입 성공
    SBNetworkSignUpResponseOK
};

//로그인을 위한 리스폰스 타입
typedef NS_ENUM(NSUInteger, SBNetworkLogInResponse)
{
    SBNetworkLogInResponseOK = 0, //로그인 성공
    SBNetworkLogInResponseFailWrongPassword, //비밀번호 틀림
    SBNetworkLogInResponseFailNoSuchUserID, //없는 이메일
    SBNetworkLogInResponseUnknownError
};





@interface SBAuthCenter : NSObject


@property NSString *userToken;

+ (instancetype)sharedInstance;
- (void)loginWithUserID:(NSString *)userID
               password:(NSString *)password
             completion:(SBDataCompletion)completion;
- (void)signUpWithUserID:(NSString *)userID
                password:(NSString *)password
                nickName:(NSString *)nickName
              completion:(SBDataCompletion)completion;
- (void)logOut;

@end
