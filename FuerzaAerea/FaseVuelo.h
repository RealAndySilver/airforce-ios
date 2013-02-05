//
//  FaseVuelo.h
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaseVuelo : NSObject
@property(nonatomic,retain)NSString *idFaseVuelo;
@property(nonatomic,retain)NSString *faseVuelo;
-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
