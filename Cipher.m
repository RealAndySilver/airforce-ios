//
//  Cipher.m
//  FuerzaAerea
//
//  Created by Andres Abril on 25/11/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Cipher.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
@implementation Cipher

@synthesize cipherKey;

- (Cipher *) initWithKey:(NSString *) key {
    self = [super init];
    if (self) {
        [self setCipherKey:key];
    }
    return self;
}

//- (NSData *) encrypt:(NSData *) plainText {
//    return [self transform:kCCEncrypt data:plainText];
//}
//
//- (NSData *) decrypt:(NSData *) cipherText {
//    return [self transform:kCCDecrypt data:cipherText];
//}

+ (NSData *) transform:(CCOperation) encryptOrDecrypt data:(NSData *) inputData andKey:(NSString*)key{
    
    // kCCKeySizeAES128 = 16 bytes
    // CC_MD5_DIGEST_LENGTH = 16 bytes
    NSData* secretKey = [Cipher md5:key];
    
    CCCryptorRef cryptor = NULL;
    CCCryptorStatus status = kCCSuccess;
    
    uint8_t iv[kCCBlockSizeAES128];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    status = CCCryptorCreate(encryptOrDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                             [secretKey bytes], kCCKeySizeAES128, iv, &cryptor);
    
    if (status != kCCSuccess) {
        return nil;
    }
    
    size_t bufsize = CCCryptorGetOutputLength(cryptor, (size_t)[inputData length], true);
    
    void * buf = malloc(bufsize * sizeof(uint8_t));
    memset(buf, 0x0, bufsize);
    
    size_t bufused = 0;
    size_t bytesTotal = 0;
    
    status = CCCryptorUpdate(cryptor, [inputData bytes], (size_t)[inputData length],
                             buf, bufsize, &bufused);
    
    if (status != kCCSuccess) {
        free(buf);
        CCCryptorRelease(cryptor);
        return nil;
    }
    
    bytesTotal += bufused;
    
    status = CCCryptorFinal(cryptor, buf + bufused, bufsize - bufused, &bufused);
    
    if (status != kCCSuccess) {
        free(buf);
        CCCryptorRelease(cryptor);
        return nil;
    }
    
    bytesTotal += bufused;
    
    CCCryptorRelease(cryptor);
    
    return [NSData dataWithBytesNoCopy:buf length:bytesTotal];
}

+ (NSData *) md5:(NSString *) stringToHash {
    
    const char *src = [stringToHash UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(src, strlen(src), result);
    
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    //return [stringToHash dataUsingEncoding:NSUTF8StringEncoding];
}

+(NSString*)encryptAndBase64:(NSString *)message withKey:(NSString*)key{
    NSData *encrypted = [self transform:kCCEncrypt data:[message dataUsingEncoding:NSUTF8StringEncoding] andKey:key];
    //NSLog(@"Encriptado Hexa: %@",encrypted);
    return [NSString base64StringFromData:encrypted length:[encrypted length]];
}
+(NSString *)base64AndDecrypt:(NSString *)message withKey:(NSString*)key{
    NSData *decrypted = [self transform:kCCDecrypt data:[NSData base64DataFromString:message] andKey:key];
    //NSLog(@"Desencriptado Hexa: %@",decrypted);
    return [[NSString alloc]initWithData:decrypted encoding:NSUTF8StringEncoding];
}
@end
