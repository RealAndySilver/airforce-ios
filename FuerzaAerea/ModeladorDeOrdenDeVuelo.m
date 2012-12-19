//
//  ModeladorDeOrdenDeVuelo.m
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "ModeladorDeOrdenDeVuelo.h"
@implementation ModeladorDeOrdenDeVuelo
@synthesize principal,arregloDeArmamento,arregloDePiernas,arregloDeTripulacion;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self =[super init]) {
        principal = [[Principal alloc]initWithDictionary:[[dictionary objectForKey:@"Principal"]objectAtIndex:0]];
        //piernas = [[Piernas alloc]initWithDictionary:[[dictionary objectForKey:@"Piernas"]objectAtIndex:0]];
        NSArray *tempPiernas=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"Piernas"]];
        if (tempPiernas.count) {
            arregloDePiernas=[[NSMutableArray alloc]init];
            for (int i=0; i<tempPiernas.count; i++) {
                Piernas *piernas=[[Piernas alloc]initWithDictionary:[tempPiernas objectAtIndex:i]];
                [arregloDePiernas addObject:piernas];
            }
        }
        
        NSArray *tempArmamento=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"Armamento"]];
        if (tempArmamento.count) {
            arregloDeArmamento=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArmamento.count; i++) {
                Armamento *armamento=[[Armamento alloc]initWithDictionary:[tempArmamento objectAtIndex:i]];
                [arregloDeArmamento addObject:armamento];
            }
        }
        NSArray *tempTripulacion=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"Tripulacion"]];
        if (tempTripulacion.count) {
            arregloDeTripulacion=[[NSMutableArray alloc]init];
            for (int i=0; i<tempTripulacion.count; i++) {
                Tripulacion *tripulacion=[[Tripulacion alloc]initWithDictionary:[tempTripulacion objectAtIndex:i]];
                [arregloDeTripulacion addObject:tripulacion];
            }
        }
    }
    return self;
}
@end
