//
//  Municipios.h
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Departamentos : NSObject
@property(nonatomic,retain)NSString *idDepartamento;
@property(nonatomic,retain)NSString *departamento;
-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
