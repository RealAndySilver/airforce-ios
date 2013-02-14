//
//  Tripulacion.m
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Tripulacion.h"

@implementation Tripulacion
@synthesize cargo,codigo,grado,idRegistro,persona,idPersona;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        cargo = [dictionary objectForKey:@"cargo"];
        codigo = [dictionary objectForKey:@"codigo"];
        grado = [dictionary objectForKey:@"grado"];
        idRegistro = [dictionary objectForKey:@"idRegistro"];
        idPersona = [dictionary objectForKey:@"id_persona"];
        persona = [dictionary objectForKey:@"persona"];
        //NSLog(@"Persona %@",persona);
    }
    return self;
}
@end
