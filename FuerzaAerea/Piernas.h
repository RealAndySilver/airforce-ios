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

-(id)initWithDictionary:(NSDictionary*)dictionary;
@end