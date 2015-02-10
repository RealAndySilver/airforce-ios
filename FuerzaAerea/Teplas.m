//
//  Teplas.m
//  FuerzaAerea
//
//  Created by Andres Abril on 9/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import "Teplas.h"

@implementation Teplas
@synthesize persona_id,orden_vuelo_id,tipo,grado,teplas_orden_id,nombre_tipo,notificado;
-(id)initWithDictionary:(NSDictionary *)dictionary{
    if (self=[super init]) {
        persona_id = [dictionary objectForKey:@"persona_id"];
        orden_vuelo_id = [dictionary objectForKey:@"orden_vuelo_id"];
        tipo = [dictionary objectForKey:@"tipo"];
        grado = [dictionary objectForKey:@"grado"];
        teplas_orden_id = [dictionary objectForKey:@"teplas_orden_id"];
        nombre_tipo = [dictionary objectForKey:@"nombre_tipo"];
        notificado = [dictionary objectForKey:@"notificado"];
    }
    return self;
}
@end
