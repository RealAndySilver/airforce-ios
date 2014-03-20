//
//  AppDelegate.m
//  FuerzaAerea
//
//  Created by Andres Abril on 18/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "AppDelegate.h"
#import "IAmCoder.h"
#import "NSData+AES.h"
#import "NSString+Base64.h"
#import "NSData+Base64.h"
#import "NSData+CommonCrypto.h"
#import "AESCrypt.h"
#import "Cipher.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
//    NSString *str=[IAmCoder encryptAndBase64:@"20:C9:D0:43:3F:C3" withKey:@"WVRJjNZ2Ml5yE0sC"];
//    
    //NSLog(@"dec %@,",[IAmCoder base64AndDecrypt:@"Xf3C390eq9Q1ZxBGBKwb57cMfHjRkr84cA7ZrvIPNG8hONCkvbHazLf4CBTzS3oOT5/WmPh4+poNFlkbVf7deC28gwUz5TJMkKJD4eq38x3SeOTVEkwcJ7UnChy0RAsS" withKey:@"WVRJjNZ2Ml5yE0sC"]);
    
    //NSLog(@"Encodeando %@ la llave es: %@",[IAmCoder encryptAndBase64:@"prueba" withKey:[IAmCoder dateKey]], [IAmCoder dateKey]);
//    NSString *json_string=@"nL3VuVHOWc3Wyqz5q5yJRXlIbFSVDYtQzirvRMcsQEjsTxuqla6yRkwyXN8EAlJLXonLrsF+6bocvrZ6Ui2x1uEqLxFAttLxbfTBco5I9oHOk7oDgBrAyaZR2atHqqtb";
//    NSLog(@"DESEncodeando %@ ",[IAmCoder base64AndDecrypt:json_string withKey:[IAmCoder dateKey]]);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
