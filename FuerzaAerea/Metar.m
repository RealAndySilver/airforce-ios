//
//  Metar.m
//  FuerzaAerea
//
//  Created by Andres Abril on 26/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Metar.h"
@implementation Metar
@synthesize aerodromo,estacion,fechaReporte,horaReporte,textoReporte,tipoReporte;
-(id)initWithDictionary:(NSDictionary *)dictionary{
    if (self=[super init]) {
        estacion=[dictionary objectForKey:@"estacion"];
        fechaReporte=[dictionary objectForKey:@"fechaReporte"];
        horaReporte=[dictionary objectForKey:@"horaReporte"];
        NSString *fullString=[dictionary objectForKey:@"textoReporte"];
        if ([fullString rangeOfString:@"CACOM"].location == NSNotFound) {
            textoReporte=[fullString substringFromIndex:4];
            tipoReporte=@"";//[dictionary objectForKey:@"tipoReporte"];
            aerodromo=[fullString substringToIndex:4];
        }
        else{
            textoReporte=[fullString substringFromIndex:6];
            tipoReporte=@"";
            aerodromo=[fullString substringToIndex:6];
        }
    }
    return self;
}
-(NSString *)buildChain{
    NSString *res=[NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",aerodromo,textoReporte,estacion,fechaReporte,horaReporte,tipoReporte];
    return res;
}
@end
