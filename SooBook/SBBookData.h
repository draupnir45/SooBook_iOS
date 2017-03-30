//
//  SBBookData.h
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 28..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
