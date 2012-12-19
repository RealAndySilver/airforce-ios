//
//  FileDownloader.m
//  FuerzaAerea
//
//  Created by Andres Abril on 13/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "FileDownloader.h"

@implementation FileDownloader
+(BOOL)descargarArchivoRetornarPathDesde:(NSString *)url nombre:(NSString*)nombre{
    //url=@"http://www.uspto.gov/patents/init_events/rce_outreach_data.pptx";
    url=@"http://www.nasa.gov/pdf/55388main_05%20Space%20Science.pdf";
    NSString *filePath = [NSString stringWithFormat:@"%@",nombre];
    NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if (data2) {
        NSLog(@"Guardando data desde %@",url);
        [data2 writeToFile:filePath atomically:YES];
        return YES;
    }
    else{
        NSLog(@"No guardó %@",url);
        return NO;
    }
}
@end
