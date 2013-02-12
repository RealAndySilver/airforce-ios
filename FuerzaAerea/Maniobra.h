//
//  Maniobra.h
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Maniobra : NSObject
@property(nonatomic,retain)NSString *idManiobra;
@property(nonatomic,retain)NSString *maniobra;
-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
