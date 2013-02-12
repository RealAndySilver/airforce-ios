//
//  TipoOperacion.m
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "TipoOperacion.h"

@implementation TipoOperacion
@synthesize codigoNumerico,tipoOperacion;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        codigoNumerico=[dictionary objectForKey:@"codigoNumerico"];
        tipoOperacion=[dictionary objectForKey:@"tipoOperacion"];
    }
    return self;
}
@end
