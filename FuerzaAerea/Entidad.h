//
//  Entidad.h
//  FuerzaAerea
//
//  Created by Andres Abril on 8/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entidad : NSObject
@property(nonatomic,retain)NSString *idOrganizacion;
@property(nonatomic,retain)NSString *nombreOrganizacion;
-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
