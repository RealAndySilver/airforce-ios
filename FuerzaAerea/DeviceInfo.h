//
//  DeviceInfo.h
//  FuerzaAerea
//
//  Created by Andres Abril on 30/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/sysctl.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

@interface DeviceInfo : NSObject
+ (NSString *)getModel;
+ (NSString *)getMacAddress;
+ (NSString *)getUUDID;


@end
