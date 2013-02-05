//
//  FaseVuelo.m
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "FaseVuelo.h"

@implementation FaseVuelo
@synthesize idFaseVuelo,faseVuelo;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idFaseVuelo=[dictionary objectForKey:@"idFaseVuelo"];
        faseVuelo=[dictionary objectForKey:@"faseVuelo"];
    }
    return self;
}
@end
