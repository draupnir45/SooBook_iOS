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
        self.autoLoginEnabled = [[NSUserDefaults standardUserDefaults] objectForKey:@"Auto-login Disabled"];
    }
    return self;
}

#pragma mark - User Token Control Methods

///NSUserD efaults에서 토큰 불러와 프로퍼티에 저장.
- (void)loadUserToken
{
    self.userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USERTOKEN_KEY];
    self.userID = [[NSUserDefaults standardUserDefaults] objectForKey:USERNAME];
    self.userNickName = [[NSUserDefaults standardUserDefaults] objectForKey:NICKNAME];
}

///더이상 사용하지 않는 토큰을 삭제하고 NSUserDefaults에서도 삭제.
- (void)removeUserInfo
{
    self.userToken = @"";
    self.userID = @"";
    self.userNickName = @"";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERTOKEN_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERNAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NICKNAME];
}

///유저 토큰을 저장합니다.
- (void)saveUserInfo:(NSDictionary *)dictionary
{
    NSDictionary *userDict = [dictionary objectForKey:@"user"];
    [self setUserToken:[dictionary objectForKey:USERTOKEN_KEY]];
    [self setUserNickName:[userDict objectForKey:NICKNAME]];
    [self setUserID:[userDict objectForKey:USERNAME]];
    
    [[NSUserDefaults standardUserDefaults] setObject:[userDict objectForKey:NICKNAME] forKey:NICKNAME];
    [[NSUserDefaults standardUserDefaults] setObject:[userDict objectForKey:USERNAME] forKey:USERNAME];
    [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:USERTOKEN_KEY] forKey:USERTOKEN_KEY];
}

#pragma mark - Authentification

- (void)logInWithUserID:(NSString *)userID
               password:(NSString *)password
             completion:(SBDataCompletion)completion
{
    [SBNetworkManager logInWithUserID:userID password:password completion:^(BOOL sucess, id data) {
        if (sucess) {
            if (self.autoLoginEnabled) {
                [self saveUserInfo:data];
            }
        }
        completion(sucess, data);
    }];
}

- (void)signUpWithUserID:(NSString *)userID
                password:(NSString *)password
                nickName:(NSString *)nickName
              completion:(SBDataCompletion)completion
{
    [SBNetworkManager signUpWithUserID:userID password:password nickName:nickName completion:completion];
}

- (void)logOut
{
    [SBNetworkManager logOut];
    [self removeUserInfo];
}

- (void)setAutoLoginEnabled:(BOOL)autoLoginEnabled {
    _autoLoginEnabled = autoLoginEnabled;
    [[NSUserDefaults standardUserDefaults] setBool:autoLoginEnabled forKey:@"Auto-login Disabled"];
}

@end
