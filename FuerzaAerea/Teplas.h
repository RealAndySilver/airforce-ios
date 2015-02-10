//
//  Teplas.h
//  FuerzaAerea
//
//  Created by Andres Abril on 9/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Teplas : NSObject

@property(nonatomic,retain)NSString *persona_id;
@property(nonatomic,retain)NSString *orden_vuelo_id;
@property(nonatomic,retain)NSString *tipo;
@property(nonatomic,retain)NSString *grado;
@property(nonatomic,retain)NSString *teplas_orden_id;
@property(nonatomic,retain)NSString *nombre_tipo;
@property(nonatomic,retain)NSString *notificado;

-(id)initWithDictionary:(NSDictionary*)dictionary;
@end