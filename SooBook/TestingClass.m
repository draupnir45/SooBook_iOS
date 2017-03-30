//
//  TestingClass.m
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 30..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "TestingClass.h"
#import "SBBookData.h"
#import "SBAuthCenter.h"

@implementation TestingClass

- (void)startTesting {
    
    NSLog(@"\n*****************테스트를 시작합니다.*****************");
    //*********************SBBookData*********************
    NSDictionary *bookDataDict =
  @{
    BOOK_PRIMARY_KEY : @"123846198237",
    TITLE_KEY : @"나미야",
    IMAGE_URL_KEY : @"https://t1.daumcdn.net/thumb/R1280x0/?fname=http://t1.daumcdn.net/brunch/service/user/mlX/image/uj_gIWveH1N_j3ok9BP5t_0ds9M.jpg",
    AUTHOR_KEY : @"Higasihno Geigo",
    PUBLISHER_KEY : @"Penguin",
    SHORT_DESCRIPTION_KEY : @"다작을 하면서 매너리즘에 빠져 있었던 게이고의 작품에서 간만에 나온 수작이다. 여러모로 읽을만한 작품. 한국에서도 수년동안 베스트셀러를 차지하며 수십만부 팔려나갈 정도로 인기있는 작품이다.",
    RATING_KEY : @"3.5",
    COMMENT_KEY : @"ㅊ",
    QUOTATIONS_KEY : @[@"좋다", @"나쁘다", @"으떠냐"]
    };
    
    SBBookData *sbBookData = [[SBBookData alloc] initWithDictionary:bookDataDict];
    
    NSLog(@"\n%@\n%@\n%@\n%@\n%@\n%f\n%@\n%@",sbBookData.title,sbBookData.imageURL, sbBookData.author, sbBookData.publisher, sbBookData.shortDescription, sbBookData.rating, sbBookData.comment, sbBookData.quotations);
    
    //*********************TestCompletionBlock*********************
    SBDataCompletion testingBlock = ^(BOOL sucess, NSUInteger result, id data) {
        NSLog(@"%ld, %lu, %@", (long)sucess, (unsigned long)result, data);
    };
    

    //*********************SBAuthCenter*********************
    [[SBAuthCenter sharedInstance] loginWithUserID:@"Tester" password:@"TesterPW" completion:testingBlock];
    [[SBAuthCenter sharedInstance] signUpWithUserID:@"Tester" password:@"TesterPW" nickName:@"챈웅이" completion:testingBlock];
    
    //*********************SBDataCenter*********************

}


@end
