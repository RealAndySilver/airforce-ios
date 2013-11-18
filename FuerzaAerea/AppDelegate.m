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
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
//    NSString *pass=@"password";
//    NSString *message=@"Soy el mensaje";
//    
//    NSData *data1 = [message dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *cipher = [data1 AES256EncryptWithKey:pass];
//    FileSaver *file=[[FileSaver alloc]init];
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//    [dic setObject:message forKey:@"data"];
//    [file setDictionary:dic withName:@"cdata"];
//    NSString *str = [IAmCoder base64EncodeData:cipher];
//    NSData *dcipher = [cipher AES256DecryptWithKey:pass];
//    NSString *mm = [[NSString alloc]initWithData:dcipher encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"%@, %@, %@, %@, %@",dcipher,cipher,data1,mm,str);
//    NSLog(@"saved: %@",[file getDictionary:@"cdata"]);
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
