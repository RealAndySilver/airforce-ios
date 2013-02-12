//
//  Unidades.m
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Unidades.h"

@implementation Unidades
@synthesize idOrganizacion,sigla;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idOrganizacion=[dictionary objectForKey:@"idOrganizacion"];
        sigla=[dictionary objectForKey:@"sigla"];
    }
    return self;
}
@end
