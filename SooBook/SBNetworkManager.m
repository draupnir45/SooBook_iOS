//
//  SBNetworkManager.m
//  SooBook
//
//  Created by 박종찬 on 2017. 4. 1..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SBNetworkManager.h"




@implementation SBNetworkManager


#pragma mark - Authentification (SBAuthCenter 사용)

+ (void)signUpWithUserID:(NSString *)userID
                password:(NSString *)password
                nickName:(NSString *)nickName
              completion:(SBDataCompletion)completion
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:USER_SIGNUP]];
    request.HTTPMethod = @"POST";
    
    //BODY 준비
    NSString *dataString = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@", USERNAME, userID, PASSWORD, password, NICKNAME, nickName];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
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
}

+ (void)logInWithUserID:(NSString *)userID
               password:(NSString *)password
             completion:(SBDataCompletion)completion
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:USER_LOGIN]];
    request.HTTPMethod = @"POST";
    
    //BODY 준비
    NSString *dataString = [NSString stringWithFormat:@"%@=%@&%@=%@", USERNAME, userID, PASSWORD, password];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //Task
    NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:request fromData:nil progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            
            if (statusCode == 200) {
                completion(YES, responseObject);
            } else {
                completion(NO, responseObject);
            }
        } else {
            NSLog(@"Error : %@",error);
        }
    }];
    [task resume];
}

+ (void)logOutWithToken:(NSString *)token
{
    //매니저와 리퀘스트 준비
    AFURLSessionManager *manager = [SBNetworkManager sessionManager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[SBNetworkManager urlWithApiPath:USER_LOGOUT]];
    request.HTTPMethod = @"POST";
    NSString *headerStr = [NSString stringWithFormat:@"Token %@",token];
    [request setValue:headerStr forHTTPHeaderField:@"Authorization"];
    
    //Task
    NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:request fromData:nil progress:nil completionHandler:nil];
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
