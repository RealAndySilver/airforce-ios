//
//  Armamentos.h
//  FuerzaAerea
//
//  Created by Andres Abril on 31/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Armamentos : NSObject
@property(nonatomic,retain)NSString *idArmamento;
@property(nonatomic,retain)NSString *armamento;
-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
