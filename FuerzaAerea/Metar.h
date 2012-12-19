//
//  Metar.h
//  FuerzaAerea
//
//  Created by Andres Abril on 26/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Metar : NSObject
@property(nonatomic,readonly)NSString *aerodromo;
@property(nonatomic,readonly)NSString *estacion;
@property(nonatomic,readonly)NSString *fechaReporte;
@property(nonatomic,readonly)NSString *horaReporte;
@property(nonatomic,readonly)NSString *textoReporte;
@property(nonatomic,readonly)NSString *tipoReporte;
-(id)initWithDictionary:(NSDictionary*)dictionary;
-(NSString*)buildChain;
@end
