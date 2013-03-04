//
//  Objetivo.m
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Objetivo.h"

@implementation Objetivo
@synthesize idBlanco,objetivo,departamento,coordenadas;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idBlanco=[dictionary objectForKey:@"idBlanco"];
        objetivo=[dictionary objectForKey:@"objetivo"];
        if ([objetivo rangeOfString:@"null"].location!=NSNotFound) {
            objetivo=@"Sin Nombre";
        }
        departamento=[dictionary objectForKey:@"departamento"];
        coordenadas=[[[[dictionary objectForKey:@"coordenadas"]stringByReplacingOccurrencesOfString:@"g" withString:@"º"] stringByReplacingOccurrencesOfString:@"m" withString:@"'"] stringByReplacingOccurrencesOfString:@"s" withString:@"\""];

    }
    return self;
}

@end
