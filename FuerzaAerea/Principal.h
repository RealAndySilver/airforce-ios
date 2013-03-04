//
//  Principal.h
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Principal : NSObject
@property(nonatomic,retain)NSString *combustible;
@property(nonatomic,retain)NSString *equipo;
@property(nonatomic,retain)NSString *fecha;
@property(nonatomic,retain)NSString *horaDespegue;
@property(nonatomic,retain)NSString *idConsecutivoUnidad;
@property(nonatomic,retain)NSString *idOrdenVuelo;
@property(nonatomic,retain)NSString *imprimirCola;
@property(nonatomic,retain)NSString *instrucciones;
@property(nonatomic,retain)NSString *itinerario;
@property(nonatomic,retain)NSString *matricula;
@property(nonatomic,retain)NSString *unidad;
@property(nonatomic,retain)NSString *unidadAsume;
@property(nonatomic,retain)NSString *idUnidad;
@property(nonatomic,retain)NSString *idUnidadAsume;
-(id)initWithDictionary:(NSDictionary*)dictionary;
//aprobado, cumplido, imprimircola, registrada

@end