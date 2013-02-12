//
//  Enemigo.m
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Enemigo.h"

@implementation Enemigo
@synthesize idOrganizacion,nombreOrganizacion;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idOrganizacion=[dictionary objectForKey:@"idOrganizacion"];
        nombreOrganizacion=[dictionary objectForKey:@"nombreOrganizacion"];
    }
    return self;
}
@end
