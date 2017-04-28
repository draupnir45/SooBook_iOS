//
//  SBBookData.m
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 28..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBBookData.h"
@interface SBBookData()

@property (readwrite) NSInteger         bookPrimaryKey;
@property (readwrite) NSString          *title;
@property (readwrite) NSString          *imageURL;
@property (readwrite) NSString          *author;
@property (readwrite) NSString          *publisher;
@property (readwrite) NSString          *shortDescription;


@end


@implementation SBBookComment

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (dictionary[CONTENT_KEY]) {
            _pk = [dictionary[@"id"] integerValue];
            _content = dictionary[CONTENT_KEY];
            _updated_date = dictionary[@"updated_date"];
        }
    }
    return self;
}
@end


@implementation SBBookStarRating
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (dictionary[CONTENT_KEY]) {
            _pk = [dictionary[@"id"] integerValue];
            _score = [dictionary[CONTENT_KEY] floatValue];
            _created_date = dictionary[@"created_date"];
        }
    }
    return self;
}
@end

@implementation SBQuotation

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self) {
        _pk = [dictionary[@"id"] integerValue];
        _content = dictionary[CONTENT_KEY];
    }
    return self;
}

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
        
    }
    return self;
}

- (void)setMybookID:(NSInteger)mybookID {
    _mybookID = mybookID;
    _myBook = YES;
}

- (void)setQuotations:(NSArray *)quotations {
    NSMutableArray *resultArray = [NSMutableArray new];
    for (NSDictionary *item in quotations) {
        [resultArray addObject:[[SBQuotation alloc] initWithDictionary:item]];
    }
    _quotations = resultArray;
}



@end
