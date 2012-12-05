//
//  SerializadorOV.h
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SerializadorOV : NSObject
+(NSMutableDictionary*)getDiccionarioFronJsonString:(NSString*)json_string;
@end
