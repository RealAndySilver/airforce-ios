//
//  Cipher.h
//  FuerzaAerea
//
//  Created by Andres Abril on 25/11/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface Cipher : NSObject {
    NSString* cipherKey;
}

@property (retain) NSString* cipherKey;

- (Cipher *) initWithKey:(NSString *) key;



+ (NSData *) transform:(CCOperation) encryptOrDecrypt data:(NSData *) inputData andKey:(NSString*)key;

+ (NSString*) encryptAndBase64:(NSString*)message withKey:(NSString*)key;
+ (NSString*) base64AndDecrypt:(NSString*)message withKey:(NSString*)key;

+ (NSData *) md5:(NSString *) stringToHash;
@end