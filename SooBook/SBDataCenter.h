//
//  SBDataCenter.h
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBBookData;



//책 등록 및 삭제를 위한 ENUM
typedef NS_ENUM(NSUInteger, SBNetworkBookRegisterResponse)
{
    SBNetworkBookRegisterResponseOK,
    SBNetworkBookRegisterResponseUnknownError
};

typedef NS_ENUM(NSUInteger, SBNetworkBookRemoveResponse)
{
    SBNetworkBookRemoveResponseOK,
    SBNetworkBookRemoveResponseUnknownError
};

@interface SBDataCenter : NSObject

@property (readonly) NSArray *myBookDatas;
+ (instancetype)sharedBookData;
- (void)addBook:(SBBookData *)book completion:(SBDataCompletion)completion;
- (void)removeBook:(SBBookData *)book completion:(SBDataCompletion)completion;

@end
