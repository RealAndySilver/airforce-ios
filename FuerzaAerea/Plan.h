//
//  Plan.h
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plan : NSObject
@property(nonatomic,retain)NSString *idReferencia;
@property(nonatomic,retain)NSString *descripcion;
-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
