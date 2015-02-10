//
//  Sanidad.m
//  FuerzaAerea
//
//  Created by Andres Abril on 9/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import "Sanidad.h"

@implementation Sanidad
@synthesize persona_id,orden_vuelo_id,grado,cargo,sanidad_orden_id,notificado;
-(id)initWithDictionary:(NSDictionary *)dictionary{
    if (self=[super init]) {
        persona_id = [dictionary objectForKey:@"persona_id"];
        orden_vuelo_id = [dictionary objectForKey:@"orden_vuelo_id"];
        grado = [dictionary objectForKey:@"grado"];
        cargo = [dictionary objectForKey:@"cargo"];
        sanidad_orden_id = [dictionary objectForKey:@"sanidad_orden_id"];
        notificado = [dictionary objectForKey:@"notificado"];
    }
    return self;
}
@end
