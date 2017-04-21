//
//  SBBookData.h
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 28..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



//Comment 클래스
@interface SBBookComment : NSObject

@property NSInteger pk;
@property NSString *content;
@property NSDate *updated_date;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface SBBookStarRating : NSObject

@property NSInteger pk;
@property CGFloat score;
@property NSDate *created_date;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface SBQuotation : NSObject

@property NSInteger pk;
@property NSString *content;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


@interface SBBookData : NSObject

@property (readonly, nonatomic) NSInteger           bookPrimaryKey;
@property (readonly, nonatomic) NSString            *title;
@property (readonly, nonatomic) NSString            *imageURL;
@property (readonly, nonatomic) NSString            *author;
@property (readonly, nonatomic) NSString            *publisher;
@property (readonly, nonatomic) NSString            *shortDescription;
@property (nonatomic)           SBBookStarRating    *rating;
@property (nonatomic)           SBBookComment       *comment;
@property (nonatomic)  NSArray <SBQuotation *>       *quotations;
@property (getter=isMyBook)     BOOL                myBook;
@property (nonatomic)           NSInteger           mybookID;
@property                       BOOL                hasRating;
@property                       BOOL                hasComment;
@property                       BOOL                hasQuotations;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
