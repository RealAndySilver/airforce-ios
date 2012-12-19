//
//  FileDownloader.h
//  FuerzaAerea
//
//  Created by Andres Abril on 13/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownloader : NSObject
+(BOOL)descargarArchivoRetornarPathDesde:(NSString *)url nombre:(NSString*)nombre;

@end
