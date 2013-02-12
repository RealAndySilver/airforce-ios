//
//  Operacion.m
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Operacion.h"

@implementation Operacion
@synthesize descripcion,codigo;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        descripcion=[dictionary objectForKey:@"descripcion"];
        codigo=[dictionary objectForKey:@"codigo"];
    }
    return self;
}
@end
