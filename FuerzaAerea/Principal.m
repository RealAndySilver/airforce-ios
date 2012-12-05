//
//  Principal.m
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Principal.h"

@implementation Principal
@synthesize combustible,equipo,fecha,horaDespegue,idConsecutivoUnidad,idOrdenVuelo,imprimirCola,instrucciones,itinerario,matricula,unidad,unidadAsume;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        combustible = [dictionary objectForKey:@"combustible"];
        equipo = [dictionary objectForKey:@"equipo"];
        fecha = [dictionary objectForKey:@"fecha"];
        horaDespegue = [dictionary objectForKey:@"horaDespegue"];
        idConsecutivoUnidad = [dictionary objectForKey:@"idConsecutivoUnidad"];
        idOrdenVuelo = [dictionary objectForKey:@"idOrdenVuelo"];
        imprimirCola = [dictionary objectForKey:@"imprimirCola"];
        instrucciones=[dictionary objectForKey:@"instrucciones"];
        itinerario = [dictionary objectForKey:@"itinerario"];
        matricula = [dictionary objectForKey:@"matricula"];
        unidad = [dictionary objectForKey:@"unidad"];
        unidadAsume = [dictionary objectForKey:@"unidadAsume"];
    }
    return self;
}
@end
