//
//  Objetivo.h
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Objetivo : NSObject
@property(nonatomic,retain)NSString *idBlanco;
@property(nonatomic,retain)NSString *objetivo;
@property(nonatomic,retain)NSString *departamento;
@property(nonatomic,retain)NSString *coordenadas;

-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
