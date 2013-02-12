//
//  TipoOperacion.h
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TipoOperacion : NSObject
@property(nonatomic,retain)NSString *codigoNumerico;
@property(nonatomic,retain)NSString *tipoOperacion;
-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
