//
//  Municipios.h
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Departamentos.h"
@interface Municipios : NSObject
@property(nonatomic,retain)NSString *idMunicipio;
@property(nonatomic,retain)NSString *municipio;
@property(nonatomic,retain)Departamentos *departamento;
-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
