//
//  Metar.m
//  FuerzaAerea
//
//  Created by Andres Abril on 26/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Metar.h"
@implementation Metar
@synthesize estacion,fechaReporte,horaReporte,textoReporte,tipoReporte;
-(id)initWithDictionary:(NSDictionary *)dictionary{
    if (self=[super init]) {
        estacion=[dictionary objectForKey:@"estacion"];
        fechaReporte=[dictionary objectForKey:@"fechaReporte"];
        horaReporte=[dictionary objectForKey:@"horaReporte"];
        textoReporte=[dictionary objectForKey:@"textoReporte"];
        tipoReporte=@"";//[dictionary objectForKey:@"tipoReporte"];
    }
    return self;
}
-(NSString *)buildChain{
    NSString *res=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",estacion,fechaReporte,horaReporte,textoReporte,tipoReporte];
    return res;
}
@end
