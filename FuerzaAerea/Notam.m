//
//  Notam.m
//  FuerzaAerea
//
//  Created by Andres Abril on 26/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Notam.h"

@implementation Notam
@synthesize aerodromo,calificativo,codigo,descripcionE,dinavNotamId,estado,fechaB,fechaC,horaFin,horaInicio,idNotams,limiteInfF,limiteSupG,permanente,solicitud;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
                
        if ([dictionary objectForKey:@"aerodromo"]) {
            aerodromo=[dictionary objectForKey:@"aerodromo"];
        }
        else{
            aerodromo=@"";
        }
        if ([dictionary objectForKey:@"calificativo"]) {
            calificativo=[dictionary objectForKey:@"calificativo"];
        }
        else{
            calificativo=@"";
        }
        if ([dictionary objectForKey:@"codigo"]) {
            codigo=[dictionary objectForKey:@"codigo"];
        }
        else{
            codigo=@"";
        }
        if ([dictionary objectForKey:@"descripcionE"]) {
            descripcionE=[dictionary objectForKey:@"descripcionE"];
        }
        else{
            descripcionE=@"";
        }
        if ([dictionary objectForKey:@"dinavNotamId"]) {
            dinavNotamId=[dictionary objectForKey:@"dinavNotamId"];
        }
        else{
            dinavNotamId=@"";
        }
        if ([dictionary objectForKey:@"estado"]) {
            estado=[dictionary objectForKey:@"estado"];
        }
        else{
            estado=@"";
        }
        if ([dictionary objectForKey:@"fechaB"]) {
            fechaB=[dictionary objectForKey:@"fechaB"];
        }
        else{
            fechaB=@"";
        }
        if ([dictionary objectForKey:@"fechaC"]) {
            fechaC=[dictionary objectForKey:@"fechaC"];
        }
        else{
            fechaC=@"";
        }
        
        if ([dictionary objectForKey:@"horaFin"]) {
            horaFin=[dictionary objectForKey:@"horaFin"];
        }
        else{
            horaFin=@"";
        }
        
        if ([dictionary objectForKey:@"horaInicio"]) {
            horaInicio=[dictionary objectForKey:@"horaInicio"];
        }
        else{
            horaInicio=@"";
        }
        
        if ([dictionary objectForKey:@"idNotams"]) {
            idNotams=[dictionary objectForKey:@"idNotams"];
        }
        else{
            idNotams=@"";
        }
        
        if ([dictionary objectForKey:@"limiteInfF"]) {
            limiteInfF=[dictionary objectForKey:@"limiteInfF"];
        }
        else{
            limiteInfF=@"";
        }
        
        if ([dictionary objectForKey:@"limiteSupG"]) {
            limiteSupG=[dictionary objectForKey:@"limiteSupG"];
        }
        else{
            limiteSupG=@"";
        }
        
        if ([dictionary objectForKey:@"permanente"]) {
            permanente=[dictionary objectForKey:@"permanente"];
        }
        else{
            permanente=@"";
        }
        
        if ([dictionary objectForKey:@"solicitud"]) {
            solicitud=[dictionary objectForKey:@"solicitud"];
        }
        else{
            solicitud=@"";
        }
    }
    return self;
}
-(NSString *)buildChain{
    NSString *res=[NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@",aerodromo,calificativo,codigo,descripcionE,dinavNotamId,estado,fechaB,fechaC,horaFin,horaInicio,idNotams,limiteInfF,limiteSupG,permanente,solicitud];
    return res;
}
@end
