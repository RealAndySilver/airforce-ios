//
//  Armamentos.m
//  FuerzaAerea
//
//  Created by Andres Abril on 31/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Armamentos.h"

@implementation Armamentos
@synthesize idArmamento,armamento;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idArmamento=[dictionary objectForKey:@"idArmamento"];
        armamento=[dictionary objectForKey:@"armamento"];
    }
    return self;
}
@end
