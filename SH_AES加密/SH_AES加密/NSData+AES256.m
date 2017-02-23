//
//  NSData+AES256.m
//  SH_AES加密
//
//  Created by HarrySun on 2017/2/23.
//  Copyright © 2017年 Mobby. All rights reserved.
//


/*
 
 高级加密标准（Advanced Encryption Standard，AES），又称Rijndael加密法。 以下实现代码中为NSData增加了一个Category。使用时直接调用即可。
 
 需要注意的是，AES并不能作为HASH算法，加密并解密后的结果，并不一定与原文相同，使用时请注意进行结果验算。例如解密原文的长度，格式规则等。
 
 */

#import "NSData+AES256.h"

@implementation NSData (AES256)

// 加密
- (NSData *)aes256_encrypt:(NSString *)key{
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    //    CCCryptorStatus cryptStatus1 = CCCrypt(<#CCOperation op#>, <#CCAlgorithm alg#>, <#CCOptions options#>, <#const void *key#>, <#size_t keyLength#>, <#const void *iv#>, <#const void *dataIn#>, <#size_t dataInLength#>, <#void *dataOut#>, <#size_t dataOutAvailable#>, <#size_t *dataOutMoved#>)
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [self bytes], dataLength, buffer, bufferSize, &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}


// 解密
- (NSData *)aes256_decrypt:(NSString *)key{
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    free(buffer);
    return nil;
}



@end
