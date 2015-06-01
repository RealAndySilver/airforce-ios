//
//  Lista.h
//  FuerzaAerea
//
//  Created by Andres Abril on 7/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Armamentos.h"
#import "ArmamentosImpactados.h"
#import "Departamentos.h"
#import "TipoOperacion.h"
#import "Plan.h"
#import "Unidades.h"
#import "Maniobra.h"
#import "FaseVuelo.h"
#import "Grupo.h"
#import "Enemigo.h"
#import "Objetivo.h"
#import "Operacion.h"
#import "Entidad.h"
#import "Municipios.h"
@interface Lista : NSObject
@property(nonatomic,readonly)NSMutableArray *arregloDeArmamentos;
@property(nonatomic,readonly)NSMutableArray *arregloDeArmamentosImpactados;
@property(nonatomic,readonly)NSMutableArray *arregloDeDepartamentos;
@property(nonatomic,readonly)NSMutableArray *arregloDeTipoOperacion;
@property(nonatomic,readonly)NSMutableArray *arregloDePlan;
@property(nonatomic,readonly)NSMutableArray *arregloDeUnidades;
@property(nonatomic,readonly)NSMutableArray *arregloDeManiobra;
@property(nonatomic,readonly)NSMutableArray *arregloDeMunicipios;
@property(nonatomic,readonly)NSMutableArray *arregloDeGrupo;
@property(nonatomic,readonly)NSMutableArray *arregloDeFaseDeVuelo;
@property(nonatomic,readonly)NSMutableArray *arregloDeEntidades;


@property(nonatomic,readonly)NSMutableArray *arregloDeEnemigo;
@property(nonatomic,readonly)NSMutableArray *arregloDeOperacion;
@property(nonatomic,readonly)NSMutableArray *arregloDeObjetivo;

@property(nonatomic,readonly)NSMutableArray *arregloDeConvenios;
@property(nonatomic,readonly)NSMutableArray *arregloEntidadesPaxCarga;
@property(nonatomic,readonly)NSMutableArray *arregloMotivosIncumplimiento;
@property(nonatomic,readonly)NSMutableArray *arregloResultadosInmediatos;
@property(nonatomic,readonly)NSMutableArray *arregloRetardos;
@property(nonatomic,readonly)NSMutableArray *arregloTipoOperacionMision;
@property(nonatomic,readonly)NSMutableArray *arregloTipoPax;

-(id)initWithDictionary:(NSDictionary*)dictionary;
-(id)initWithMisionDictionary:(NSDictionary*)dictionary;
-(void)agregarAlArregloRespectivo:(NSDictionary*)dictionary;
@end
