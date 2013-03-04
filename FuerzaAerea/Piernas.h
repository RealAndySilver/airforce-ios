//
//  Piernas.h
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Piernas : NSObject
@property(nonatomic,retain)NSString *descripcionMision;
@property(nonatomic,retain)NSString *desdeAerodromo;
@property(nonatomic,retain)NSString *entidad;
@property(nonatomic,retain)NSString *entidadApoyada;
@property(nonatomic,retain)NSString *hastaAerodromo;
@property(nonatomic,retain)NSString *idOrden;
@property(nonatomic,retain)NSString *operacion;
@property(nonatomic,retain)NSString *operacionTipo;
@property(nonatomic,retain)NSString *piernaNumero;
@property(nonatomic,retain)NSString *plan;

@property(nonatomic,retain)NSString *idDe;
@property(nonatomic,retain)NSString *idA;

@property(nonatomic,retain)NSString *de;
@property(nonatomic,retain)NSString *a;

@property(nonatomic,retain)NSString *idOperacion;
@property(nonatomic,retain)NSString *idOperacionTipo;
@property(nonatomic,retain)NSString *idPlan;
@property(nonatomic,retain)NSString *idEntidad;


-(id)initWithDictionary:(NSDictionary*)dictionary;
@end