//
//  SBNetworkManager.m
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 1..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBNetworkManager.h"
#import "AFNetworking.h"

@implementation SBNetworkManager


#pragma mark - Authentification (SBAuthCenter 사용)

+ (void)signUpWithUserID:(NSString *)userID
                password:(NSString *)password
                nickName:(NSString *)nickName
              completion:(SBDataCompletion)completion
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
//    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:USER_SIGNUP]];
//    request.HTTPMethod = POST;
    
    //Data Params
    
    NSDictionary *parameters = @{ USERNAME : userID, PASSWORD: password, NICKNAME: nickName};
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[BASE_URL stringByAppendingString:USER_SIGNUP] parameters:parameters error:nil];
    
//    NSString *dataString = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@", USERNAME, userID, PASSWORD, password, NICKNAME, nickName];
//    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPBody = data;
    
    //Task
    NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:request fromData:nil progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            
            if (statusCode == 201) {
                completion(YES, responseObject);
            } else {
                completion(NO, responseObject);
            }
        } else {
            NSLog(@"Error : %@",error);
        }
    }];
    [task resume];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    NSString *url = [NSString stringWithFormat:@“%@%@“, BASIC_URL, LOGIN_URL];
//    NSDictionary *parameters = @{@“email” : userID, @“password” : password};
//    
//    
//    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        completion(YES,responseObject);
//        NSLog(@“LOGIN RESPONSE:%@“, responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@“LOGIN ERROR:%@“, error);
//    }];

}

+ (void)logInWithUserID:(NSString *)userID
               password:(NSString *)password
             completion:(SBDataCompletion)completion
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:USER_LOGIN]];
    request.HTTPMethod = POST;
    
    //Data Params
    NSString *dataString = [NSString stringWithFormat:@"%@=%@&%@=%@", USERNAME, userID, PASSWORD, password];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //Task
    NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:request fromData:nil progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    [task resume];
    
}

+ (void)logOut
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:USER_LOGOUT]];
    request.HTTPMethod = POST;
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    
    //Task
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:nil];
    [task resume];
}


#pragma mark - Search / Add / Delete

+ (void)searchWithQuery:(NSString *)query completion:(SBDataCompletion)completion
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    //한글 검색을 위한 쿼리 인코딩
    NSString *encodedQuery = [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:@"%@keyword=%@",SEARCH,encodedQuery];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:urlString]];
    request.HTTPMethod = GET;
    
    //Task
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    
    [task resume];
    
}

+ (void)nextSearchResultWithURLString:(NSString *)urlString completion:(SBDataCompletion)completion
{
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = GET;
    
    //Task
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    
    [task resume];
}

+ (void)addBookWith:(NSInteger)bookID completion:(SBDataCompletion)completion
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:REGISTER_BOOK]];
    request.HTTPMethod = POST;
    
    //Data Params
    NSString *dataString = [NSString stringWithFormat:@"%@=%ld", BOOK_PRIMARY_KEY, (long)bookID];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //HEADER 준비
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 201) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    
    [task resume];
    
}

+ (void)deleteBookWith:(NSInteger)bookID completion:(SBDataCompletion)completion
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:REGISTER_BOOK]];
    request.HTTPMethod = DELETE;
    
    //DATA
    NSString *dataString = [NSString stringWithFormat:@"{\"%@\":\"%ld\"}", BOOK_PRIMARY_KEY, (long)bookID];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //HEADER 준비
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    
    [task resume];
    
}


#pragma mark - List

+ (void)loadMyBookListWithPage:(NSInteger)page completion:(SBDataCompletion)completion
{
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@page=%ld",MY_BOOK_LIST,(long)page];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:urlString]];
    request.HTTPMethod = GET;
    
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    [task resume];
    
}

+ (void)loadMyBookWithBookID:(NSInteger)bookID completion:(SBDataCompletion)completion
{
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    
    NSString *urlString = [NSString stringWithFormat:@"%@bookid=%ld",GET_BOOK ,(long)bookID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:urlString]];
    request.HTTPMethod = GET;
    
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    [task resume];

}

+ (void)loadRatingListWithCompletion:(SBDataCompletion)completion
{
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:RATING]];
    request.HTTPMethod = GET;
    
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    [task resume];
}

#pragma mark - Comment
+ (void)addCommentWithMyBookID:(NSInteger)myBookID content:(NSString *)content completion:(SBDataCompletion)completion
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:ADD_COMMENT]];
    request.HTTPMethod = POST;
    
    //DATA
    NSString *dataString = [NSString stringWithFormat:@"%@=%ld&%@=%@", MYBOOK_PRIMARY_KEY, (long)myBookID, CONTENT_KEY, content];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //HEADER
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    
    //RESPONSE
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 201 || statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    
    [task resume];
}

#pragma mark - Rate
+ (void)addRateWithMyBookID:(NSInteger)myBookID score:(CGFloat)score completion:(SBDataCompletion)completion
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:RATING]];
    request.HTTPMethod = POST;
    
    //HEADER
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    
    //DATA
    NSString *dataString = [NSString stringWithFormat:@"%@=%ld&%@=%f", MYBOOK_PRIMARY_KEY, (long)myBookID, CONTENT_KEY, score];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //RESPONSE
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    
    [task resume];
}
#pragma mark - Mark
+ (void)addQuotationWithMyBookID:(NSInteger)myBookID content:(NSString *)content completion:(SBDataCompletion)completion
{
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:QUOTATION]];
    request.HTTPMethod = POST;
    
    //HEADER
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //DATA
    NSString *dataString = [NSString stringWithFormat:@"{\"mybook_id\":\"%ld\",\"content\":\"%@\"}", (long)myBookID, content];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //RESPONSE
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 201) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    
    [task resume];
}

+ (void)editQuotationWithQuotationPk:(NSInteger)pk content:(NSString *)content completion:(SBDataCompletion)completion
{
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:QUOTATION]];
    request.HTTPMethod = @"PUT";
    
    //HEADER
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //DATA
    NSString *dataString = [NSString stringWithFormat:@"{\"mark_id\":\"%ld\",\"content\":\"%@\"}", (long)pk, content];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //RESPONSE
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    
    [task resume];
}

+ (void)deleteQuotationWithQuotationPk:(NSInteger)pk completion:(SBDataCompletion)completion
{
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:QUOTATION]];
    request.HTTPMethod = DELETE;
    
    //HEADER
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",[[SBAuthCenter sharedInstance] userToken]];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //DATA
    NSString *dataString = [NSString stringWithFormat:@"{\"mark_id\":\"%ld\"}", (long)pk];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //RESPONSE
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            completion(YES, responseObject);
        } else {
            completion(NO, responseObject);
        }
    }];
    
    [task resume];
}

#pragma mark - Network Utilities

//매니저 불러오기
+ (AFURLSessionManager *)sessionManager
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    return manager;
}

//URL가져오기
+ (NSURL *)urlWithApiPath:(NSString *)path
{
    NSString *urlString = [BASE_URL stringByAppendingString:path];
    return [NSURL URLWithString:urlString];
}


@end
