//
//  AuthCenter.h
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>


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
