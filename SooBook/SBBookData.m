//
//  SBBookData.m
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 28..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBBookData.h"
@interface SBBookData()

@property (readwrite) NSInteger bookPrimaryKey;
@property (readwrite) NSString  *title;
@property (readwrite) NSString  *imageURL;
@property (readwrite) UIImage   *bookCover;
@property (readwrite) NSString  *author;
@property (readwrite) NSString  *publisher;
@property (readwrite) NSString  *shortDescription;
@property (readwrite) CGFloat   rating;
@property (readwrite) NSString  *comment;
@property (readwrite) NSArray   *quotations;

@end


@implementation SBBookData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _bookPrimaryKey = [dictionary[BOOK_ID] integerValue];
        _title = dictionary[TITLE_KEY];
        _imageURL = dictionary[IMAGE_URL_KEY];
        _author = dictionary[AUTHOR_KEY];
        _publisher = dictionary[PUBLISHER_KEY];
        _shortDescription = dictionary[SHORT_DESCRIPTION_KEY];
        _rating = [dictionary[RATING_KEY] floatValue];
        _comment = dictionary[COMMENT_KEY];
        _quotations = dictionary[QUOTATIONS_KEY];
    }
    return self;
}

@end
