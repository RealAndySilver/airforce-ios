//
//  Notam.h
//  FuerzaAerea
//
//  Created by Andres Abril on 26/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notam : NSObject
@property(nonatomic,readonly)NSString *aerodromo;
@property(nonatomic,readonly)NSString *calificativo;
@property(nonatomic,readonly)NSString *codigo;
@property(nonatomic,readonly)NSString *descripcionE;
@property(nonatomic,readonly)NSString *dinavNotamId;
@property(nonatomic,readonly)NSString *estado;
@property(nonatomic,readonly)NSString *fechaB;
@property(nonatomic,readonly)NSString *fechaC;
@property(nonatomic,readonly)NSString *horaFin;
@property(nonatomic,readonly)NSString *horaInicio;
@property(nonatomic,readonly)NSString *idNotams;
@property(nonatomic,readonly)NSString *limiteInfF;
@property(nonatomic,readonly)NSString *limiteSupG;
@property(nonatomic,readonly)NSString *permanente;
@property(nonatomic,readonly)NSString *solicitud;
-(id)initWithDictionary:(NSDictionary*)dictionary;
-(NSString*)buildChain;
@end
