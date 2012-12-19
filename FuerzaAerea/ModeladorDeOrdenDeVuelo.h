//
//  ModeladorDeOrdenDeVuelo.h
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Principal.h"
#import "Tripulacion.h"
#import "Piernas.h"
#import "Armamento.h"
@interface ModeladorDeOrdenDeVuelo : NSObject
@property(nonatomic,readonly)Principal *principal;
@property(nonatomic,readonly)NSMutableArray *arregloDePiernas;
@property(nonatomic,readonly)NSMutableArray *arregloDeTripulacion;
@property(nonatomic,readonly)NSMutableArray *arregloDeArmamento;
-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
