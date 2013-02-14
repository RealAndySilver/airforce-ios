//
//  Tripulacion.h
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tripulacion : NSObject
@property(nonatomic,retain)NSString *cargo;
@property(nonatomic,retain)NSString *codigo;
@property(nonatomic,retain)NSString *grado;
@property(nonatomic,retain)NSString *idRegistro;
@property(nonatomic,retain)NSString *persona;
@property(nonatomic,retain)NSString *idPersona;

-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
