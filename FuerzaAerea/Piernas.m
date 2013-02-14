//
//  Piernas.m
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Piernas.h"

@implementation Piernas
@synthesize descripcionMision,desdeAerodromo,entidad,entidadApoyada,hastaAerodromo,idOrden,operacion,operacionTipo,piernaNumero,plan,de,a;
@synthesize idEntidad,idPlan,idOperacion,idOperacionTipo;
-(id)initWithDictionary:(NSDictionary *)dictionary{
    if (self=[super init]) {
        descripcionMision = [dictionary objectForKey:@"descripcionMision"];
        desdeAerodromo = [dictionary objectForKey:@"desdeAerodromo"];
        entidad = [dictionary objectForKey:@"entidad"];
        entidadApoyada = [dictionary objectForKey:@"entidadApoyada"];
        hastaAerodromo = [dictionary objectForKey:@"hastaAerodromo"];
        idOrden = [dictionary objectForKey:@"idOrden"];
        operacion = [dictionary objectForKey:@"operacion"];
        operacionTipo =[dictionary objectForKey:@"operacionTipo"];
        piernaNumero = [dictionary objectForKey:@"piernaNumero"];
        plan = [dictionary objectForKey:@"plan"];
        de = [dictionary objectForKey:@"de"];
        a = [dictionary objectForKey:@"a"];
        
        idEntidad= [dictionary objectForKey:@"id_entidad"];
        idPlan= [dictionary objectForKey:@"id_plan"];
        idOperacionTipo= [dictionary objectForKey:@"id_operacionTipo"];
        idOperacion= [dictionary objectForKey:@"id_operacion"];

    }
    return self;
}
@end
