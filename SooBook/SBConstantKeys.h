//
//  SBConstantKeys.h
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#ifndef SBConstantKeys_h
#define SBConstantKeys_h

//API 주소 상수
static NSString * const BASE_URL = @"https://soobook.devlim.net/api/";
static NSString * const USER_SIGNUP = @"user/signup/";
static NSString * const USER_LOGIN = @"user/login/";
static NSString * const USER_LOGOUT = @"user/logout/";

//인증용 상수 키값
static NSString * const USERNAME = @"username";
static NSString * const PASSWORD = @"password";
static NSString * const NICKNAME = @"nickname";
static NSString * const PRIMARY_KEY = @"pk";

//유저 토큰 키
static NSString * const USERTOKEN_KEY = @"key";


//데이터 모델 용 상수 키값
static NSString * const BOOK_PRIMARY_KEY = @"primary_key";
static NSString * const TITLE_KEY = @"title";
static NSString * const IMAGE_URL_KEY = @"imageURL";
static NSString * const AUTHOR_KEY = @"author";
static NSString * const PUBLISHER_KEY = @"publisher";
static NSString * const SHORT_DESCRIPTION_KEY = @"shortDescription";
static NSString * const RATING_KEY = @"rating";
static NSString * const COMMENT_KEY = @"comment";
static NSString * const QUOTATIONS_KEY = @"quotations";

#endif /* SBConstantKeys_h */
