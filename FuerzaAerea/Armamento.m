//
//  Armamento.m
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Armamento.h"

@implementation Armamento
@synthesize idOrden,armamento,cantidad,idArmamento;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idOrden = [dictionary objectForKey:@"idOrden"];
        armamento = [dictionary objectForKey:@"armamento"];
        cantidad = [dictionary objectForKey:@"cantidad"];
        idArmamento = [dictionary objectForKey:@"idArmamento"];
    }
    return self;
}
@end
