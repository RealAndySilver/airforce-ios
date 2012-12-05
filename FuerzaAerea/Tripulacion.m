//
//  Tripulacion.m
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Tripulacion.h"

@implementation Tripulacion
@synthesize cargo,codigo,grado,idRegistro,persona;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        cargo = [dictionary objectForKey:@"cargo"];
        codigo = [dictionary objectForKey:@"codigo"];
        grado = [dictionary objectForKey:@"grado"];
        idRegistro = [dictionary objectForKey:@"idRegistro"];
        persona = [dictionary objectForKey:@"persona"];
    }
    return self;
}
@end
