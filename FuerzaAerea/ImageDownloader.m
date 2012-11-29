//
//  ImageDownloader.m
//  FuerzaAerea
//
//  Created by Andres Abril on 13/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader
+(NSString *)descargarImagenRetornarPathDesde:(NSString *)url yTipo:(NSString*)tipo{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *jpegFilePath = [NSString stringWithFormat:@"%@/%@.jpg",docDir,tipo];
    //BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:jpegFilePath];
    //if (!fileExists) {
        NSLog(@"no existe %@",jpegFilePath);
        NSURL *urlImagen=[NSURL URLWithString:url];
        NSData *data=[NSData dataWithContentsOfURL:urlImagen];
        UIImageView *proyectoImage = [[UIImageView alloc]init];
        proyectoImage.image = [UIImage imageWithData:data];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(proyectoImage.image, 1.0f)];
        if (proyectoImage.image) {
            NSLog(@"Guardando");
            [data2 writeToFile:jpegFilePath atomically:YES];
        }
        return jpegFilePath;
    /*}
    else {
        return jpegFilePath;
    }*/
}
@end
