//
//  NSData+AES256.h
//  SH_AES加密
//
//  Created by HarrySun on 2017/2/23.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@interface NSData (AES256)

-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;

@end
