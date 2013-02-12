//
//  ArmamentosImpactados.m
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "ArmamentosImpactados.h"

@implementation ArmamentosImpactados
@synthesize nombre,idArmamentoImpactado;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idArmamentoImpactado=[dictionary objectForKey:@"idArmamentoImpactado"];
        nombre=[dictionary objectForKey:@"nombre"];
    }
    return self;
}
@end