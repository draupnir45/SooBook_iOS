//
//  AuthCenter.m
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBAuthCenter.h"

@implementation SBAuthCenter

+ (instancetype)sharedInstance
{
    static SBAuthCenter *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SBAuthCenter alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadUserToken];
    }
    return self;
}


#pragma mark - User Token Control Methods

///NSUserDefaults에서 토큰 불러와 프로퍼티에 저장.
- (void)loadUserToken
{
    self.userToken = @"adsfhlf3h4lk25ig34j2k5gh4k5jhg34kj52hg3";
//    self.userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USERTOKEN_KEY];
}

///더이상 사용하지 않는 토큰을 삭제하고 NSUserDefaults에서도 삭제.
- (void)removeUserToken
{
    self.userToken = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERTOKEN_KEY];
}

///유저 토큰을 저장합니다.
- (void)saveUserToken:(NSString *)token
{
    self.userToken = token;
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:USERTOKEN_KEY];
}


#pragma mark - Login Methods

- (void)loginWithUserID:(NSString *)userID
               password:(NSString *)password
             completion:(SBDataCompletion)completion
{
    NSLog(@"  ID : %@ \n  PW : %@ \n  로그인 요청됨",userID, password);
    [self saveUserToken:@"adsfhlf3h4lk25ig34j2k5gh4k5jhg34kj52hg3"];
    completion(YES, SBNetworkLogInResponseOK, userID);
    
}

- (void)signUpWithUserID:(NSString *)userID
                password:(NSString *)password
                nickName:(NSString *)nickName
              completion:(SBDataCompletion)completion
{
    NSLog(@"  ID : %@ \n  PW : %@ \n  사인업 요청됨", userID, password);
    [self saveUserToken:@"adsfhlf3h4lk25ig34j2k5gh4k5jhg34kj52hg3"];
    completion(YES, SBNetworkSignUpResponseOK, userID);
}

- (void)logOut
{
    [self removeUserToken];
}

@end
