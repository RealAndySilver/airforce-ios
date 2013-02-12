//
//  ArmamentosImpactados.h
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArmamentosImpactados : NSObject
@property(nonatomic,retain)NSString *idArmamentoImpactado;
@property(nonatomic,retain)NSString *nombre;
-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
