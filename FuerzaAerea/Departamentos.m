//
//  Municipios.m
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Departamentos.h"

@implementation Departamentos
@synthesize departamento,idDepartamento;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idDepartamento=[dictionary objectForKey:@"idDepartamento"];
        departamento=[dictionary objectForKey:@"departamento"];
    }
    return self;
}
@end
