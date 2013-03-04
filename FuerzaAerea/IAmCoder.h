//
//  IAmCoder.h
//  
//
//  Created by Andrés Abril on 26/07/12.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>


@interface IAmCoder : NSObject

+(NSString*)encodeURL:(NSString*)url;
+(NSString*)encodeCoordinate:(NSString*)coordinate;

+(NSString*)decodeURL:(NSString*)url;
+(NSString*)hash256:(NSString*)parameters;
+(NSString*)base64EncodeString:(NSString *)strData;
+ (NSString *) base64EncodeData: (NSData *) objData;
@end
