//
//  ImageDownloader.h
//  FuerzaAerea
//
//  Created by Andres Abril on 13/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject
+(NSString *)descargarImagenRetornarPathDesde:(NSString *)url yTipo:(NSString*)tipo;
@end
