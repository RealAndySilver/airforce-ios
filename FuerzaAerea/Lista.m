//
//  Lista.m
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "Lista.h"

@implementation Lista

@synthesize arregloDeArmamentos,arregloDeArmamentosImpactados,arregloDeDepartamentos,arregloDeManiobra,arregloDePlan,arregloDeTipoOperacion,arregloDeUnidades,arregloDeFaseDeVuelo,arregloDeGrupo,arregloDeEnemigo,arregloDeObjetivo,arregloDeOperacion,arregloDeEntidades,arregloDeMunicipios;
@synthesize arregloDeConvenios,arregloEntidadesPaxCarga,arregloMotivosIncumplimiento,arregloResultadosInmediatos,arregloRetardos,arregloTipoOperacionMision,arregloTipoPax, arregloDeEmpresasCombustible;
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self =[super init]) {
        
        dictionary=[dictionary objectForKey:@"listas"];
        NSArray *tempArmamentos=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"armamentos"]];
        if (tempArmamentos.count) {
            arregloDeArmamentos=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArmamentos.count; i++) {
                Armamentos *arm=[[Armamentos alloc]initWithDictionary:[tempArmamentos objectAtIndex:i]];
                [arregloDeArmamentos addObject:arm];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"armamento" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeArmamentos sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArmamentosImpactados=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"armamentosImpactados"]];
        if (tempArmamentosImpactados.count) {
            arregloDeArmamentosImpactados=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArmamentosImpactados.count; i++) {
                ArmamentosImpactados *armImp=[[ArmamentosImpactados alloc]initWithDictionary:[tempArmamentosImpactados objectAtIndex:i]];
                [arregloDeArmamentosImpactados addObject:armImp];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"nombre" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeArmamentosImpactados sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArregloDeDepartamentos=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"departamentos"]];
        if (tempArregloDeDepartamentos.count) {
            arregloDeDepartamentos=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeDepartamentos.count; i++) {
                Departamentos *dep=[[Departamentos alloc]initWithDictionary:[tempArregloDeDepartamentos objectAtIndex:i]];
                [arregloDeDepartamentos addObject:dep];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"departamento" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeDepartamentos sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArregloDeManiobra=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"maniobra"]];
        if (tempArregloDeManiobra.count) {
            arregloDeManiobra=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeManiobra.count; i++) {
                Maniobra *man=[[Maniobra alloc]initWithDictionary:[tempArregloDeManiobra objectAtIndex:i]];
                [arregloDeManiobra addObject:man];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"maniobra" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeManiobra sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArregloDePlan=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"planes"]];
        if (tempArregloDePlan.count) {
            arregloDePlan=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDePlan.count; i++) {
                Plan *plan=[[Plan alloc]initWithDictionary:[tempArregloDePlan objectAtIndex:i]];
                [arregloDePlan addObject:plan];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"descripcion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDePlan sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArregloDeTipoOperacion=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"tipoOperaciones"]];
        if (tempArregloDeTipoOperacion.count) {
            arregloDeTipoOperacion=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeTipoOperacion.count; i++) {
                TipoOperacion *tipoOp=[[TipoOperacion alloc]initWithDictionary:[tempArregloDeTipoOperacion objectAtIndex:i]];
                [arregloDeTipoOperacion addObject:tipoOp];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"tipoOperacion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeTipoOperacion sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArregloDeUnidades=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"unidades"]];
        if (tempArregloDeUnidades.count) {
            arregloDeUnidades=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeUnidades.count; i++) {
                Unidades *unidades=[[Unidades alloc]initWithDictionary:[tempArregloDeUnidades objectAtIndex:i]];
                [arregloDeUnidades addObject:unidades];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"sigla" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeUnidades sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArregloDeFaseDeVuelo=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"faseVuelo"]];
        if (tempArregloDeFaseDeVuelo.count) {
            arregloDeFaseDeVuelo=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeFaseDeVuelo.count; i++) {
                FaseVuelo *fase=[[FaseVuelo alloc]initWithDictionary:[tempArregloDeFaseDeVuelo objectAtIndex:i]];
                [arregloDeFaseDeVuelo addObject:fase];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"faseVuelo" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeFaseDeVuelo sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArregloDeGrupo=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"grupos"]];
        if (tempArregloDeGrupo.count) {
            arregloDeGrupo=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeGrupo.count; i++) {
                Grupo *grupo=[[Grupo alloc]initWithDictionary:[tempArregloDeGrupo objectAtIndex:i]];
                [arregloDeGrupo addObject:grupo];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"nombreOrganizacion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeGrupo sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArregloDeEntidad=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"entidades"]];
        if (tempArregloDeEntidad.count) {
            arregloDeEntidades=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeEntidad.count; i++) {
                Entidad *entidad=[[Entidad alloc]initWithDictionary:[tempArregloDeEntidad objectAtIndex:i]];
                [arregloDeEntidades addObject:entidad];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"nombreOrganizacion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeEntidades sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
        NSArray *tempArregloEmpresasCombustible=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"ListaEmpresasCombustibe"]];
        if (tempArregloEmpresasCombustible.count) {
            arregloDeEmpresasCombustible=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloEmpresasCombustible.count; i++) {
                NSDictionary *dic = tempArregloEmpresasCombustible[i];
                [arregloDeEmpresasCombustible addObject:dic];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"Empresa" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeEmpresasCombustible sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
        
    }
    return self;
}
-(void)addMisionDictionary:(NSDictionary*)dictionary{
    if (self) {
        
        NSArray *arrayLista = [dictionary objectForKey:@"listasMision"];
        
        if (arrayLista.count) {
            if (arrayLista[0]) {
                NSDictionary *dic = arrayLista[0];
                
                arregloDeConvenios= (NSMutableArray*)[dic objectForKey:@"ListaConvenio"];
                NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"Descripcion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
                [arregloDeConvenios sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
            }
            if (arrayLista[1]) {
                NSDictionary *dic = arrayLista[1];
                arregloEntidadesPaxCarga= (NSMutableArray*)[dic objectForKey:@"ListaEntidadesPaxCarga"];
                NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"Descripcion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
                [arregloEntidadesPaxCarga sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
            }
            if (arrayLista[2]) {
                NSDictionary *dic = arrayLista[2];
                
                arregloMotivosIncumplimiento= (NSMutableArray*)[dic objectForKey:@"ListaMotivosIncumplimientos"];
                NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"Descripcion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
                [arregloMotivosIncumplimiento sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
            }
            if (arrayLista[3]) {
                NSDictionary *dic = arrayLista[3];
                
                arregloResultadosInmediatos= (NSMutableArray*)[dic objectForKey:@"ListaResultadosInmediatos"];
                NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"Descripcion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
                [arregloResultadosInmediatos sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
            }
            if (arrayLista[4]) {
                NSDictionary *dic = arrayLista[4];
                
                arregloRetardos= (NSMutableArray*)[dic objectForKey:@"ListaRetardos"];
                NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"Descripcion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
                [arregloRetardos sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
            }
            if (arrayLista[5]) {
                NSDictionary *dic = arrayLista[5];
                arregloTipoOperacionMision= (NSMutableArray*)[dic objectForKey:@"ListaTipoOperacion"];
                NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"Descripcion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
                [arregloTipoOperacionMision sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
            }
            if (arrayLista[6]) {
                NSDictionary *dic = arrayLista[6];
                
                arregloTipoPax= (NSMutableArray*)[dic objectForKey:@"ListaTipoPax"];
                NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"Descripcion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
                [arregloTipoPax sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
            }
            
        }
    }
}
-(void)agregarAlArregloRespectivo:(NSDictionary*)dictionary{
    if ([dictionary objectForKey:@"enemigos"]) {
        NSArray *tempArregloDeEnemigos=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"enemigos"]];
        if (tempArregloDeEnemigos.count) {
            arregloDeEnemigo=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeEnemigos.count; i++) {
                Enemigo *enemigo=[[Enemigo alloc]initWithDictionary:[tempArregloDeEnemigos objectAtIndex:i]];
                [arregloDeEnemigo addObject:enemigo];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"nombreOrganizacion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeEnemigo sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
    }
    else if ([dictionary objectForKey:@"objetivos"]) {
        NSArray *tempArregloDeObjetivos=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"objetivos"]];
        if (tempArregloDeObjetivos.count) {
            arregloDeObjetivo=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeObjetivos.count; i++) {
                Objetivo *obj=[[Objetivo alloc]initWithDictionary:[tempArregloDeObjetivos objectAtIndex:i]];
                if ([obj.objetivo isKindOfClass:[NSNull class]] ||[obj.coordenadas isKindOfClass:[NSNull class]]||[obj.departamento isKindOfClass:[NSNull class]]||[obj.idBlanco isKindOfClass:[NSNull class]] ) {
                    //obj.objetivo=@"N/A";
                }
                else{
                    if (![obj isKindOfClass:[NSNull class]]) {
                        if (arregloDeObjetivo.count<5000) {
                            [arregloDeObjetivo addObject:obj];
                        }
                    }
                }
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"objetivo" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeObjetivo sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
            //NSLog(@"Objetivos count %i",arregloDeObjetivo.count);
            /*for (Objetivo *o in arregloDeObjetivo) {
                NSLog(@"Objetivos {%@}",o.objetivo);
            }*/

        }
    }
    else if ([dictionary objectForKey:@"joaOperaciones"]) {
        NSArray *tempArregloDeOperaciones=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"joaOperaciones"]];
        if (tempArregloDeOperaciones.count) {
            arregloDeOperacion=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeOperaciones.count; i++) {
                Operacion *op=[[Operacion alloc] initWithDictionary:[tempArregloDeOperaciones objectAtIndex:i]];
                [arregloDeOperacion addObject:op];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"descripcion" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeOperacion sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
    }
    else if ([dictionary objectForKey:@"municipios"]) {
        NSArray *tempArregloDeMunicipios=[[NSArray alloc]initWithArray:[dictionary objectForKey:@"municipios"]];
        if (tempArregloDeMunicipios.count) {
            arregloDeMunicipios=[[NSMutableArray alloc]init];
            for (int i=0; i<tempArregloDeMunicipios.count; i++) {
                Municipios *op=[[Municipios alloc]initWithDictionary:[tempArregloDeMunicipios objectAtIndex:i]];
                [arregloDeMunicipios addObject:op];
            }
            NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"municipio" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            [arregloDeMunicipios sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
        }
    }
}
@end
