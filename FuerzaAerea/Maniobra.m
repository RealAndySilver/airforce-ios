//
//  Maniobra.m
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Maniobra.h"

@implementation Maniobra
@synthesize idManiobra,maniobra;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        idManiobra=[dictionary objectForKey:@"idManiobra"];
        maniobra=[dictionary objectForKey:@"maniobra"];
    }
    return self;
}
@end
