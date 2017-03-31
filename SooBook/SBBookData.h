//
//  SBBookData.h
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 28..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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


@interface SBBookData : NSObject

@property (readonly, nonatomic) NSString    *bookPrimaryKey;
@property (readonly, nonatomic) NSString    *title;
@property (readonly, nonatomic) NSString    *imageURL;
@property (readonly, nonatomic) UIImage     *bookCover;
@property (readonly, nonatomic) NSString    *author;
@property (readonly, nonatomic) NSString    *publisher;
@property (readonly, nonatomic) NSString    *shortDescription;
@property (readonly, nonatomic) CGFloat     rating;
@property (readonly, nonatomic) NSString    *comment;
@property (readonly, nonatomic) NSArray     *quotations;
@property (getter=isMyBook)     BOOL        myBook;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
