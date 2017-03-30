//
//  NSData+AES.h
//  SooBook
//
//  Created by 박종찬 on 2017. 3. 28..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES)

- (NSData *) encryptAES: (NSString *) key;
- (NSData *) decryptAES: (NSString *) key;

@end
