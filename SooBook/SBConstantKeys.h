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
static NSString * const SEARCH = @"book/search/?";
static NSString * const MY_BOOK_LIST = @"book/mybook/?";
static NSString * const ADD_BOOK = @"book/mybook/";
static NSString * const BOOK_PRIMARY_KEY = @"book_id";

//HTTPMethod 상수
static NSString * const POST = @"POST";
static NSString * const GET = @"GET";
static NSString * const DELETE = @"DELETE";

//인증용 상수 키값
static NSString * const USERNAME = @"username";
static NSString * const PASSWORD = @"password";
static NSString * const NICKNAME = @"nickname";
static NSString * const PRIMARY_KEY = @"pk";

//유저 토큰 키
static NSString * const USERTOKEN_KEY = @"key";


//데이터 모델 용 상수 키값
static NSString * const BOOK_ID = @"id";
static NSString * const TITLE_KEY = @"title";
static NSString * const IMAGE_URL_KEY = @"cover_thumbnail";
static NSString * const AUTHOR_KEY = @"author";
static NSString * const PUBLISHER_KEY = @"publisher";
static NSString * const SHORT_DESCRIPTION_KEY = @"description";
static NSString * const RATING_KEY = @"rating";
static NSString * const COMMENT_KEY = @"comment";
static NSString * const QUOTATIONS_KEY = @"mark";

#endif /* SBConstantKeys_h */
