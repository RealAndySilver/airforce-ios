//
//  Unidades.h
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Unidades : NSObject
@property(nonatomic,retain)NSString *idOrganizacion;
@property(nonatomic,retain)NSString *sigla;
-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
