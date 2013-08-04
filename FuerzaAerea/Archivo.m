//
//  Archivo.m
//  FuerzaAerea
//
//  Created by Andres Abril on 12/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Archivo.h"

@implementation Archivo
@synthesize activo,carpetaContenedora,fechaActualizacion,fechaCreacion,idAeronave,idGrupoAeronave,link,rutaLocal,mime,mimeOriginal,nombre,tamano,version;
-(id)initWithDictionary:(NSDictionary *)dictionary{
    if (self=[super init]) {
        activo=[dictionary objectForKey:@"activo"];
        if ([dictionary objectForKey:@"carpetaContenedora"]) {
            carpetaContenedora=[dictionary objectForKey:@"carpetaContenedora"];
        }
        else{
            carpetaContenedora=@"N/A";
        }
        
        if ([dictionary objectForKey:@"fechaActualizacion"]) {
            fechaActualizacion=[dictionary objectForKey:@"fechaActualizacion"];
        }
        else{
            fechaActualizacion=@"N/A";
        }
        
        
        fechaCreacion=[dictionary objectForKey:@"fechaCreacion"];
        //idAeronave=[dictionary objectForKey:@"idAeronave"];
        idGrupoAeronave=[dictionary objectForKey:@"idGrupoAeronave"];
        link=[[dictionary objectForKey:@"link"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        mimeOriginal=[dictionary objectForKey:@"mime"];
        
        if ([mimeOriginal rangeOfString:@".ppt"].location == NSNotFound) {}
        else{mimeOriginal=@"application/vnd.ms-powerpoint";}
        if ([mimeOriginal rangeOfString:@".doc"].location == NSNotFound) {}
        else{mimeOriginal=@"application/msword";}
        if ([mimeOriginal rangeOfString:@".pdf"].location == NSNotFound) {}
        else{mimeOriginal=@"application/pdf";}
        if ([mimeOriginal rangeOfString:@".jpg"].location == NSNotFound) {}
        else{mimeOriginal=@"image/pjpeg";}
        if ([mimeOriginal rangeOfString:@"jpeg"].location == NSNotFound) {}
        else{mime=@".jpg";}
        if ([mimeOriginal rangeOfString:@"word"].location == NSNotFound) {}
        else{mime=@".doc";}
        if ([mimeOriginal rangeOfString:@"pdf"].location == NSNotFound) {}
        else{mime=@".pdf";}
        if ([mimeOriginal rangeOfString:@"powerpoint"].location == NSNotFound) {}
        else {mime=@".ppt";}
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        rutaLocal=[NSString stringWithFormat:@"%@/%@%@",docDir,[IAmCoder encodeURL:link],mime];
        nombre=[dictionary objectForKey:@"nombre"];
        tamano=[dictionary objectForKey:@"tamaño"];
        version=[dictionary objectForKey:@"version"];
        //NSLog(@"Mime en %@ es %@",nombre,mime);
    }
    return self;
}
-(void)validarDiccionarioDeArchivos:(NSDictionary*)diccionario{
    FileSaver *file=[[FileSaver alloc]init];
    if ([[diccionario objectForKey:@"Offline"] isEqualToString:@"true"]) {
        //NSLog(@"Offline files incoming");
        NSDictionary *dic=[file getDictionary:@"ArchivosGuardados"];
        if (dic){[[NSNotificationCenter defaultCenter]postNotificationName:@"ArchivosSuccess" object:dic];}
        else{[[NSNotificationCenter defaultCenter]postNotificationName:@"ArchivosError" object:dic];}
        return;
    }
    NSMutableArray *arregloDeServidor=[[NSMutableArray alloc]init];
    for (NSDictionary *dic in [diccionario objectForKey:@"Documento "]) {
        Archivo *archivo=[[Archivo alloc]initWithDictionary:dic];
        [arregloDeServidor addObject:archivo];
    }
    
    /*for (Archivo *archivo in arregloDeServidor) {
     [arregloDic addObject:[self convertirArchivoEnDiccionario:archivo]];
     }*/
    NSMutableArray *arregloParaGuardarLocal=[[NSMutableArray alloc]init];
    
    //Si el archivo de referencia no existe en el sistema se va a intentar crearlo de acuerdo a las descargas exitosas
    if (![file getDictionary:@"ArchivosGuardados"]) {
        //NSLog(@"Resultado no existe %@ creando archivo",[file getDictionary:@"ArchivosGuardados"]);
        for (Archivo *archivo in arregloDeServidor) {
            if ([FileDownloader descargarArchivoRetornarPathDesde:archivo.link nombre:archivo.rutaLocal]) {
                
                //El archivo fue descargado exitosamente y se puede proceder a ingresarlo al arreglo para posteriormente ser guardado
                [arregloParaGuardarLocal addObject:[self convertirArchivoEnDiccionario:archivo]];
            }
            else{
                //El archivo no descargó, por lo tanto esta referencia no se agrega el arreglo
                //NSLog(@"No descargó");
            }
        }
        
        //Acá guardamos el arreglo dentro de un diccionario llamado ArchivosGuardados
        [self guardarArreglo:arregloParaGuardarLocal enFilesaver:file];
    }
    
    //El archivo ya existe, y procedemos a comparar el archivo local con el del servidor
    else{
        NSDictionary *dictionaryFromFile=[file getDictionary:@"ArchivosGuardados"];
        NSArray *array=[dictionaryFromFile objectForKey:@"ArregloDeArchivos"];
        NSMutableArray *arregloLocal=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in array) {
            Archivo *archivo=[[Archivo alloc]initWithDictionary:dic];
            [arregloLocal addObject:archivo];
        }
        
        //Esta función se encargará de comparar uno a uno los archivos del servidor y los archivos locales
        //Si el archivo está actualizado, este entrará al arregloParaGuardarLocal, de lo contrario entrará
        //al arregloDeFaltantes y se procederá a la descarga
        NSMutableArray *arregloDeFaltantes=[self regresarArregloDeFaltantesComparandoArregloLocal:arregloLocal
                                                                             conArregloDeServidor:arregloDeServidor
                                                                          guardarExisotoEnArreglo:arregloParaGuardarLocal];
        //NSLog(@"Arreglo de faltantes %@",arregloDeFaltantes);
        
        //A continuación se intenta descargar el archivo, si es descargado sin problemas se agregará al arregloParaGuardarLocal
        for (Archivo *archivo in arregloDeFaltantes) {
            //NSLog(@"Link del archivo %@",archivo.link);
            if ([FileDownloader descargarArchivoRetornarPathDesde:archivo.link nombre:archivo.rutaLocal]) {
                //El archivo fue descargado exitosamente y se puede proceder a ingresarlo al arreglo para posteriormente ser guardado
                [arregloParaGuardarLocal addObject:[self convertirArchivoEnDiccionario:archivo]];
            }
            else{
                //El archivo no descargó, por lo tanto esta referencia no se agrega el arreglo
                //NSLog(@"No descargó");
            }
        }
        //Guardamos el archivo final de referencia para ser enviado al viewcontroller y ser mostrado
        [self guardarArreglo:arregloParaGuardarLocal enFilesaver:file];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ArchivosSuccess" object:[file getDictionary:@"ArchivosGuardados"]];
    
}
-(NSMutableDictionary*)convertirArchivoEnDiccionario:(Archivo*)archivo{
    //Transforma el modelo de archivo en un diccionario nativo
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:archivo.activo forKey:@"activo"];
    [dic setObject:archivo.carpetaContenedora forKey:@"carpetaContenedora"];
    [dic setObject:archivo.fechaActualizacion forKey:@"fechaActualizacion"];
    [dic setObject:archivo.fechaCreacion forKey:@"fechaCreacion"];
    //[dic setObject:archivo.idAeronave forKey:@"idAeronave"];
    [dic setObject:archivo.idGrupoAeronave forKey:@"idGrupoAeronave"];
    [dic setObject:archivo.link forKey:@"link"];
    [dic setObject:archivo.mimeOriginal forKey:@"mimeOriginal"];
    if (archivo.mime) {
        [dic setObject:archivo.mime forKey:@"mime"];
    }
    
    [dic setObject:archivo.rutaLocal forKey:@"rutaLocal"];
    [dic setObject:archivo.nombre forKey:@"nombre"];
    [dic setObject:archivo.tamano forKey:@"tamaño"];
    [dic setObject:archivo.version forKey:@"version"];
    return dic;
}
-(NSMutableArray*)regresarArregloDeFaltantesComparandoArregloLocal:(NSMutableArray*)arregloLocal conArregloDeServidor:(NSMutableArray*)arregloDeServidor
                                           guardarExisotoEnArreglo:(NSMutableArray*)arregloExitoso{
    
    NSMutableArray *arregloDeFaltantes=[[NSMutableArray alloc]init];
    for (Archivo *archivoServer in arregloDeServidor) {
        if (![arregloDeFaltantes containsObject:archivoServer]) {
            [arregloDeFaltantes addObject:archivoServer];
        }
        for (Archivo *archivoLocal in arregloLocal) {
            if (![self compararArchivoInterno:archivoLocal conArchivoDelServer:archivoServer]) {
            }
            else{
                [arregloExitoso addObject:[self convertirArchivoEnDiccionario:archivoLocal]];
                [arregloDeFaltantes removeObject:archivoServer];
                break;
            }
        }
    }
    return arregloDeFaltantes;
}
-(BOOL)compararArchivoInterno:(Archivo*)archivoInterno conArchivoDelServer:(Archivo*)archivoDelServer{
    if ([archivoInterno.nombre isEqualToString:archivoDelServer.nombre]) {
        if ([archivoInterno.version isEqualToString:archivoDelServer.version]) {
            return YES;
        }
        else{
            return NO;
        }
    }
    else{
        return NO;
    }
}
-(void)guardarArreglo:(NSMutableArray*)arreglo enFilesaver:(FileSaver*)file{
    NSMutableDictionary *final=[[NSMutableDictionary alloc]init];
    [final setObject:arreglo forKey:@"ArregloDeArchivos"];
    [file setDictionary:final withName:@"ArchivosGuardados"];
}
#pragma mark - class methods
#pragma mark - truncate string ext
+(NSString*)getTruncatedString:(NSString*)string{
    NSString *tempStringTruncated=[[[[[string stringByReplacingOccurrencesOfString:@".doc" withString:@""]stringByReplacingOccurrencesOfString:@".pptx" withString:@""]stringByReplacingOccurrencesOfString:@".ppt" withString:@""]stringByReplacingOccurrencesOfString:@".pdf" withString:@""]stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
    return tempStringTruncated;
    
}
#pragma mark - get icon from mime
+(UIImage*)getIconFromMime:(NSString*)string{
    if ([string isEqualToString:@".ppt"]) {
        return [UIImage imageNamed:@"ppticon.png"];
    }
    else if ([string isEqualToString:@".jpg"]){
        return [UIImage imageNamed:@"jpg.png"];
    }
    else if ([string isEqualToString:@".pptx"]){
        return [UIImage imageNamed:@"ppticon.png"];
    }
    else if ([string isEqualToString:@".doc"]){
        return [UIImage imageNamed:@"docicon.png"];
    }
    else if ([string isEqualToString:@".pdf"]){
        return [UIImage imageNamed:@"pdficon.png"];
    }
    else return nil;
}
@end
