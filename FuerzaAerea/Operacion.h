//
//  Operacion.h
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operacion : NSObject
@property(nonatomic,retain)NSString *codigo;
@property(nonatomic,retain)NSString *descripcion;
-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
