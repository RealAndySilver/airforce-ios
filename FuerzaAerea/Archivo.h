//
//  Archivo.h
//  FuerzaAerea
//
//  Created by Andres Abril on 12/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileSaver.h"
#import "IAmCoder.h"
#import "FileDownloader.h"
@interface Archivo : NSObject{
    //NSMutableArray *arregloDeServidor;
}
@property(nonatomic,retain)NSString *activo;
@property(nonatomic,retain)NSString *carpetaContenedora;
@property(nonatomic,retain)NSString *fechaActualizacion;
@property(nonatomic,retain)NSString *fechaCreacion;
@property(nonatomic,retain)NSString *idAeronave;
@property(nonatomic,retain)NSString *idGrupoAeronave;
@property(nonatomic,retain)NSString *link;
@property(nonatomic,retain)NSString *rutaLocal;
@property(nonatomic,retain)NSString *mime;
@property(nonatomic,retain)NSString *mimeOriginal;
@property(nonatomic,retain)NSString *nombre;
@property(nonatomic,retain)NSString *tamano;
@property(nonatomic,retain)NSString *version;
-(id)initWithDictionary:(NSDictionary *)dictionary;
-(void)validarDiccionarioDeArchivos:(NSDictionary*)diccionario;
+(NSString*)getTruncatedString:(NSString*)string;
+(UIImage*)getIconFromMime:(NSString*)string;
@end