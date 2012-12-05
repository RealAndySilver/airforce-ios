//
//  Armamento.h
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Armamento : NSObject
@property(nonatomic,retain)NSString *armamento;
@property(nonatomic,retain)NSString *cantidad;
@property(nonatomic,retain)NSString *idArmamento;
@property(nonatomic,retain)NSString *idOrden;
-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
