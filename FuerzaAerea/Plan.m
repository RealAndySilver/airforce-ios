//
//  Plan.m
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Plan.h"

@implementation Plan
@synthesize descripcion,idReferencia;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idReferencia=[dictionary objectForKey:@"idReferencia"];
        descripcion=[dictionary objectForKey:@"descripcion"];
    }
    return self;
}
@end
