//
//  Municipios.m
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Municipios.h"

@implementation Municipios
@synthesize departamento,idMunicipio,municipio;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idMunicipio=[dictionary objectForKey:@"idMunicipio"];
        municipio=[dictionary objectForKey:@"municipio"];
        departamento=[[Departamentos alloc]init];
        departamento.idDepartamento=[dictionary objectForKey:@"idDepartamento"];
        departamento.departamento=[dictionary objectForKey:@"departamento"];
    }
    return self;
}
@end
