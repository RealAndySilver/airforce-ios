//
//  RegistroDeVueloViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 21/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "RegistroDeVueloViewController.h"

@interface RegistroDeVueloViewController ()

@end

@implementation RegistroDeVueloViewController{
    NSMutableArray *numbersArray;
    int sumaCombustibleInicial;
    int sumaTanqueo;
    int sumaCombustibleFinal;
}
@synthesize ordenDeVuelo,arrayFaseVuelo,arrayDepartamentos,arrayMunicipios,arrayArmamentos,arrayLatitud,arrayLongitud,lista;
-(void)viewDidLoad{
    [super viewDidLoad];
    numbersArray = [[NSMutableArray alloc]init];
    for (int i=0; i<101; i++) {
        [numbersArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    
    [self inicializarContadoresCombustible];
    
    arregloParaSumarItinerario=[[NSMutableArray alloc]init];
    arregloParaSumarCondiciones=[[NSMutableArray alloc]init];
    arregloPaginasArmamento=[[NSMutableArray alloc]init];
    arregloTripulacion=[[NSMutableArray alloc]init];
    arregloEntrenamiento=[[NSMutableArray alloc]init];
    arregloTeplas=[[NSMutableArray alloc]init];
    arregloSanidad=[[NSMutableArray alloc]init];
    arrayCombustible=[[NSMutableArray alloc]init];
    [self setAllPickers];
    [self crearPaginas];
    [self seleccionarBoton:1];
    //NSLog(@"Fecha fase %@",ordenDeVuelo.principal.fecha);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sumarColumnasItinerario) name:@"validado" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sumarColumnasCondiciones) name:@"updateCondiciones" object:nil];
    
    [self integrarInfoDeOrdenDeVueloEnLosTextfields];
    
    [self checkIfSaved];
    

}
-(void)viewWillAppear:(BOOL)animated{
    [self.view setBounds: CGRectMake(0, -20, 1024, 748)];
}
-(void)integrarInfoDeOrdenDeVueloEnLosTextfields{
    ordenDeVueloTextfield.text=ordenDeVuelo.principal.idConsecutivoUnidad;
    fechaTextfield.text=ordenDeVuelo.principal.fecha;
    noRegistroTextfield.text=@"";
    unidadAsumeTextfield.text=ordenDeVuelo.principal.unidadAsume;
    aeronaveUnoTextfield.text=ordenDeVuelo.principal.matricula;
    aeronaveDosTextfield.text=ordenDeVuelo.principal.equipo;
    grupoTextfield.text=@"";
    unidadQueCreaTextfield.text=@"";
}
-(void)inicializarContadoresCombustible{
    sumaCombustibleFinal = 0;
    sumaCombustibleInicial = 0;
    sumaTanqueo = 0;
    dicTotalesCombustible = [[NSMutableDictionary alloc]init];
}
-(void)setAllPickers{
    pickerFaseVuelo=[[UIPickerView alloc]init];
    pickerFaseVuelo.dataSource=self;
    pickerFaseVuelo.delegate=self;
    pickerFaseVuelo.showsSelectionIndicator = YES;
    pickerFaseVuelo.tag=2000;
    impactadaFaseTextField.inputView=pickerFaseVuelo;
    
    pickerDepto=[[UIPickerView alloc]init];
    pickerDepto.dataSource=self;
    pickerDepto.delegate=self;
    pickerDepto.showsSelectionIndicator = YES;
    pickerDepto.tag=2001;
    if (lista.arregloDeDepartamentos.count) {
        impactadaDeptoTextField.inputView=pickerDepto;
    }
    
    pickerMunicipio=[[UIPickerView alloc]init];
    pickerMunicipio.dataSource=self;
    pickerMunicipio.delegate=self;
    pickerMunicipio.showsSelectionIndicator = YES;
    pickerMunicipio.tag=2002;
    if (lista.arregloDeMunicipios.count) {
        impactadaMunicipioTextField.inputView=pickerMunicipio;
    }
    pickerArmamentos=[[UIPickerView alloc]init];
    pickerArmamentos.dataSource=self;
    pickerArmamentos.delegate=self;
    pickerArmamentos.showsSelectionIndicator = YES;
    pickerArmamentos.tag=2003;
    if (lista.arregloDeArmamentosImpactados.count) {
        impactadaArmamentoTextField.inputView=pickerArmamentos;
    }
    
    pickerLatitud=[[UIPickerView alloc]init];
    pickerLatitud.dataSource=self;
    pickerLatitud.delegate=self;
    pickerLatitud.showsSelectionIndicator = YES;
    pickerLatitud.tag=2004;
    arrayLatitud=[[NSMutableArray alloc]init];
    [arrayLatitud addObject:@"N"];
    [arrayLatitud addObject:@"S"];
    impactadaLatitud1TextField.inputView=pickerLatitud;
    
    pickerLongitud=[[UIPickerView alloc]init];
    pickerLongitud.dataSource=self;
    pickerLongitud.delegate=self;
    pickerLongitud.showsSelectionIndicator = YES;
    pickerLongitud.tag=2005;
    arrayLongitud=[[NSMutableArray alloc]init];
    [arrayLongitud addObject:@"W"];
    [arrayLongitud addObject:@"E"];
    impactadaLongitud1TextField.inputView=pickerLongitud;
    
    pickerUnidad=[[UIPickerView alloc]init];
    pickerUnidad.dataSource=self;
    pickerUnidad.delegate=self;
    pickerUnidad.showsSelectionIndicator = YES;
    pickerUnidad.tag=2006;
    if (lista.arregloDeUnidades.count) {
        unidadQueCreaTextfield.inputView=pickerUnidad;
    }
    
    pickerGrupo=[[UIPickerView alloc]init];
    pickerGrupo.dataSource=self;
    pickerGrupo.delegate=self;
    pickerGrupo.showsSelectionIndicator = YES;
    pickerGrupo.tag=2007;
    if (lista.arregloDeGrupo.count) {
        grupoTextfield.inputView=pickerGrupo;
    }
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(displayDate:) forControlEvents:UIControlEventAllEvents];
    fechaTextfield.inputView=datePicker;
    
    pickerNumeros=[[UIPickerView alloc]init];
    pickerNumeros.dataSource=self;
    pickerNumeros.delegate=self;
    pickerNumeros.showsSelectionIndicator = YES;
    pickerNumeros.tag=2008;
}
-(void)checkIfSaved{
    FileSaver *file=[[FileSaver alloc]init];
    
    
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];

        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;
        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            masterDic=[masterDic objectForKey:@"General"];
            
            
            
            idMunicipio=[masterDic objectForKey:@"id_municipio"];
            idDepartamento=[masterDic objectForKey:@"id_departamento"];
            idArmamentoImpactado=[masterDic objectForKey:@"id_armamento_impactado"];
            idGrupo=[masterDic objectForKey:@"id_grupo"];
            idUnidadAsume=[masterDic objectForKey:@"id_unidad_asume"];
            
            
            noRegistroTextfield.text=[masterDic objectForKey:@"NoRegistro"];
            requerimientosTextfield.text=[masterDic objectForKey:@"Requerimientos"];
            observacionTextfield.text=[masterDic objectForKey:@"Observacion"];
            grupoTextfield.text=[masterDic objectForKey:@"Grupo"];
            fechaTextfield.text=[masterDic objectForKey:@"Fecha"];
            unidadQueCreaTextfield.text=[masterDic objectForKey:@"UnidadQueCrea"];
            idUnidad=[masterDic objectForKey:@"id_unidad"];

            impactadaImpactosTextField.text=[masterDic objectForKey:@"ImpactadaNoImpactos"];
            impactadaDeptoTextField.text=[masterDic objectForKey:@"ImpactadaDepto"];
            impactadaMunicipioTextField.text=[masterDic objectForKey:@"ImpactadaMunicipio"];
            impactadaArmamentoTextField.text=[masterDic objectForKey:@"ImpactadaArmamento"];
            impactadaNoVueloTextField.text=[masterDic objectForKey:@"ImpactadaNoVuelo"];
            impactadaFaseTextField.text=[masterDic objectForKey:@"ImpactadaFase"];
            idImpactadaFase=[masterDic objectForKey:@"id_impactada_fase"];
            impactadaLatitud1TextField.text=[masterDic objectForKey:@"ImpactadaLatitud"];
            impactadaLatitud2TextField.text=[masterDic objectForKey:@"ImpactadaLatitudGrados"];
            impactadaLatitud3TextField.text=[masterDic objectForKey:@"ImpactadaLatitudMinutos"];
            impactadaLatitud4TextField.text=[masterDic objectForKey:@"ImpactadaLatitudSegundos"];
            impactadaLongitud1TextField.text=[masterDic objectForKey:@"ImpactadaLongitud"];
            impactadaLongitud2TextField.text=[masterDic objectForKey:@"ImpactadaLongitudGrados"];
            impactadaLongitud3TextField.text=[masterDic objectForKey:@"ImpactadaLongitudMinutos"];
            impactadaLongitud4TextField.text=[masterDic objectForKey:@"ImpactadaLongitudSegundos"];
            if ([[masterDic objectForKey:@"VueloNacionalSwitch"] isEqualToString:@"0"]) {
                [vueloNacionalSwitch setOn:NO];
                [self tipoDeVuelo:vueloNacionalSwitch];
            }
            if ([[masterDic objectForKey:@"aeronave_impactada"] isEqualToString:@"S"]) {
                [aeronaveImpactadaSwitch setOn:YES];
                [self fadeInAeronaveImpactada:aeronaveImpactadaSwitch];
            }
        }
    }
}
-(void)checkIfItinerarioSavedWithCell:(CeldaItinerario*)cell atIndex:(int)i{
    FileSaver *file=[[FileSaver alloc]init];
    
    
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];
        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;

        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            NSArray *array=[masterDic objectForKey:@"ArregloItinerario"];
            //NSLog(@"EEll Array %@",array);
            //for (int i=0; i<array.count; i++) {
                NSDictionary *dic=[array objectAtIndex:i];
                cell.noVuelo.text=[dic objectForKey:@"NoVuelo"];
                cell.de.text=[dic objectForKey:@"De"];
                cell.a.text=[dic objectForKey:@"A"];
                
                cell.segundosEncendido=[[dic objectForKey:@"HoraEncendidoSegundos"] intValue];
                cell.segundosApagado=[[dic objectForKey:@"HoraApagadoSegundos"]intValue];
                cell.segundosDecolaje=[[dic objectForKey:@"HoraDecolajeSegundos"]intValue];
                cell.segundosAterrizaje=[[dic objectForKey:@"HoraAterrizajeSegundos"]intValue];
            
                cell.horaEncendidoFormateado=[dic objectForKey:@"HoraEncendido"];
                cell.horaApagadoFormateado=[dic objectForKey:@"HoraApagado"];
                cell.horaDecolajeFormateado=[dic objectForKey:@"HoraDecolaje"];
                cell.horaAterrizajeFormateado=[dic objectForKey:@"HoraAterrizaje"];
            
                cell.horaEncendido.text=[NSString stringWithFormat:@"%f",cell.segundosEncendido];
                cell.horaApagado.text=[NSString stringWithFormat:@"%f",cell.segundosApagado];
                cell.horaDecolaje.text=[NSString stringWithFormat:@"%f",cell.segundosDecolaje];
                cell.horaAterrizaje.text=[NSString stringWithFormat:@"%f",cell.segundosAterrizaje];
                
                cell.horaEncendidoOverlay.text=[dic objectForKey:@"HoraEncendidoOverlay"];
                cell.horaApagadoOverlay.text=[dic objectForKey:@"HoraApagadoOverlay"];
                cell.horaDecolajeOverlay.text=[dic objectForKey:@"HoraDecolajeOverlay"];
                cell.horaAterrizajeOverlay.text=[dic objectForKey:@"HoraAterrizajeOverlay"];
                cell.tipoOperacion.text=[dic objectForKey:@"TipoOperacion"];
                cell.plan.text=[dic objectForKey:@"Plan"];
                cell.operacion.text=[dic objectForKey:@"Operacion"];
            
                cell.idOperacion=[dic objectForKey:@"id_operacion"];
                cell.idPlan=[dic objectForKey:@"id_plan"];
                cell.idTipoOperacion=[dic objectForKey:@"id_operacion_tipo"];
            
                cell.idDe=[dic objectForKey:@"id_de"];
                cell.idA=[dic objectForKey:@"id_a"];

                if ([[dic objectForKey:@"CheckDefensa"]isEqualToString:@"S"]) {
                    [cell.checkDefensa changeState];
                //}
            }
        }
    }
}
-(void)checkIfCondicionesSavedWithCell:(CeldaCondiciones*)cell atIndex:(int)i{
    FileSaver *file=[[FileSaver alloc]init];
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];
        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;

        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            NSArray *array=[masterDic objectForKey:@"ArregloCondiciones"];
            //NSLog(@"EEll Array %@",array);
            //for (int i=0; i<array.count; i++) {
            NSDictionary *dic=[array objectAtIndex:i];
            
            cell.idEntidad=[dic objectForKey:@"id_entidad"];
            
            cell.vfrHhTextfield.text=[dic objectForKey:@"VfrHh"];
            cell.vfrMiTextfield.text=[dic objectForKey:@"VfrMi"];
            cell.ifrHhTextfield.text=[dic objectForKey:@"IfrHh"];
            cell.ifrMiTextfield.text=[dic objectForKey:@"IfrMi"];
            cell.nocHhTextfield.text=[dic objectForKey:@"NocHh"];
            cell.nocMiTextfield.text=[dic objectForKey:@"NocMi"];
            cell.nvgHhTextfield.text=[dic objectForKey:@"NvgHh"];
            cell.nvgMiTextfield.text=[dic objectForKey:@"NvgMi"];
            cell.aterrizajesTextfield.text=[dic objectForKey:@"Aterrizajes"];
            cell.heridosTextfield.text=[dic objectForKey:@"Heridos"];
            cell.muertosTextfield.text=[dic objectForKey:@"Muertos"];
            cell.paxSubenTextfield.text=[dic objectForKey:@"PaxSuben"];
            cell.paxBajanTextfield.text=[dic objectForKey:@"PaxBajan"];
            cell.cargaSubenTextfield.text=[dic objectForKey:@"CargaSuben"];
            cell.cargaBajanTextfield.text=[dic objectForKey:@"CargaBajan"];
            cell.entidadTextfield.text=[dic objectForKey:@"Entidad"];
        }
    }
}
-(void)checkIfArmamentoSavedWithCell:(VistaListadoArmamento*)vista atIndex:(int)i{
    FileSaver *file=[[FileSaver alloc]init];
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;

        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            NSArray *arrayPag=[masterDic objectForKey:@"ArregloArmamento"];
            NSArray *arrayCeldas=[arrayPag objectAtIndex:i];
            for (int j=0; j<arrayCeldas.count; j++) {
                NSMutableDictionary *dic=[arrayCeldas objectAtIndex:j];
                CeldaArmamento *cell=[vista.arregloDeFilasArmamento objectAtIndex:j];
                cell.armamentoTextField.text=[dic objectForKey:@"Armamento"];
                cell.cantidadTextiField.text=[dic objectForKey:@"Cantidad"];
                cell.cantidadFallidoTextField.text=[dic objectForKey:@"CantidadFallido"];
                cell.objetivoTextField.text=[dic objectForKey:@"Objetivo"];
                cell.coordenadaTextField.text=[IAmCoder encodeCoordinate:[dic objectForKey:@"Coordenada"]];
                cell.departamentoTextfield.text=[dic objectForKey:@"Departamento"];
                cell.enemigoTextField.text=[dic objectForKey:@"Enemigo"];
                
                cell.idArmamento=[dic objectForKey:@"id_armamento"];
                cell.idObjetivo=[dic objectForKey:@"id_blanco"];
                cell.idEnemigo=[dic objectForKey:@"id_enemigo"];
            }
        }
    }
}
-(void)checkIfTripulacionSavedWithCell:(CeldaTripulacion*)cell atIndex:(int)i{
    FileSaver *file=[[FileSaver alloc]init];
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];
        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;
        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            NSArray *array=[masterDic objectForKey:@"ArregloTripulacion"];
            NSDictionary *dic=[array objectAtIndex:i];
            cell.cargoTextField.text=[dic objectForKey:@"Cargo"];
            cell.nombreTextiField.text=[dic objectForKey:@"Nombre"];
            cell.codigoTextField.text=[dic objectForKey:@"Codigo"];
            cell.gradoTextField.text=[dic objectForKey:@"Grado"];
            
            cell.idPersona=[dic objectForKey:@"id_persona"];
        }
    }
}
-(void)checkIfTeplasSavedWithCell:(CeldaTeplasSanidad*)cell atIndex:(int)i{
    FileSaver *file=[[FileSaver alloc]init];
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];
        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;
        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            NSArray *array=[masterDic objectForKey:@"ArregloTeplas"];
            NSDictionary *dic=[array objectAtIndex:i];
            cell.cargoTextField.text=[dic objectForKey:@"Cargo"];
            cell.nombreTextiField.text=[dic objectForKey:@"Persona"];
            cell.codigoTextField.text=[dic objectForKey:@"Codigo"];
            cell.gradoTextField.text=[dic objectForKey:@"Grado"];
        }
    }
}
-(void)checkIfSanidadSavedWithCell:(CeldaTeplasSanidad*)cell atIndex:(int)i{
    FileSaver *file=[[FileSaver alloc]init];
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];
        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;
        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            NSArray *array=[masterDic objectForKey:@"ArregloSanidad"];
            NSDictionary *dic=[array objectAtIndex:i];
            cell.cargoTextField.text=[dic objectForKey:@"Cargo"];
            cell.nombreTextiField.text=[dic objectForKey:@"Persona"];
            cell.codigoTextField.text=[dic objectForKey:@"Codigo"];
            cell.gradoTextField.text=[dic objectForKey:@"Grado"];
        }
    }
}
-(void)checkIfEntrenamientoSavedWithCell:(CeldaTripulacion*)cell atIndex:(int)i{
    FileSaver *file=[[FileSaver alloc]init];
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;

        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            NSArray *array=[masterDic objectForKey:@"ArregloEntrenamiento"];
            NSDictionary *dic=[array objectAtIndex:i];
            cell.maniobraTextField.text=[dic objectForKey:@"Maniobra"];
            cell.cantidadTextfield.text=[dic objectForKey:@"Cantidad"];
            
            cell.idManiobra=[dic objectForKey:@"id_maniobra"];
        }
    }
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ibactions
-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    FileSaver *file=[[FileSaver alloc]init];
    NSMutableDictionary *masterDic=[[NSMutableDictionary alloc]init];
    [masterDic setObject:@"YES" forKey:@"Done"];
    [file setDictionary:masterDic withName:ordenDeVuelo.principal.idConsecutivoUnidad];
}
-(IBAction)itinerario:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 0, 0.0f) animated:YES];
    [self seleccionarBoton:1];
}
-(IBAction)condicionesDeVuelo:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 1, 0.0f) animated:YES];
    [self seleccionarBoton:2];
}
-(IBAction)armamentoPierna:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 2, 0.0f) animated:YES];
    [self seleccionarBoton:3];
}
-(IBAction)tripulacion:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 3, 0.0f) animated:YES];
    [self seleccionarBoton:4];
}
-(IBAction)teplas:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 4, 0.0f) animated:YES];
    [self seleccionarBoton:5];
}
-(IBAction)sanidad:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 5, 0.0f) animated:YES];
    [self seleccionarBoton:6];
}
-(IBAction)combustible:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 5, 0.0f) animated:YES];
    [self seleccionarBoton:6];
}
-(IBAction)fadeInAeronaveImpactada:(UISwitch*)sender{
    if (sender.on) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        containerAeronaveImpactada.alpha=1;
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        containerAeronaveImpactada.alpha=0;
        [UIView commitAnimations];
    }
    
}
-(IBAction)tipoDeVuelo:(UISwitch*)sender{
    if (sender.tag==1000) {
        if (sender.on) {
            [vueloExtranjeroSwitch setOn:NO];
        }
        else{
            [vueloExtranjeroSwitch setOn:YES];
        }
    }
    else if (sender.tag==1001){
        if (sender.on) {
            [vueloNacionalSwitch setOn:NO];
        }
        else{
            [vueloNacionalSwitch setOn:YES];
        }
    }
}
#pragma mark - hilight method
-(void)seleccionarBoton:(int)numeroDeBoton{
    UIColor *colorNormal=[UIColor grayColor];
    UIColor *colorHilight=[UIColor colorWithRed:0 green:0 blue:0.3 alpha:1];
    [self callForeignDismisser];
    switch (numeroDeBoton) {
        case 1:
            [botonItinerario setBackgroundColor:colorHilight];
            [botonCondiciones setBackgroundColor:colorNormal];
            [botonArmamento setBackgroundColor:colorNormal];
            [botonTripulacion setBackgroundColor:colorNormal];
            [botonTeplas setBackgroundColor:colorNormal];
            [botonSanidad setBackgroundColor:colorNormal];
            [botonCombustible setBackgroundColor:colorNormal];
            [botonItinerario setHighlighted:YES];
            [botonCondiciones setHighlighted:NO];
            [botonArmamento setHighlighted:NO];
            [botonTripulacion setHighlighted:NO];
            [botonTeplas setHighlighted:NO];
            [botonSanidad setHighlighted:NO];
            [botonCombustible setHighlighted:NO];
            break;
        case 2:
            [botonItinerario setBackgroundColor:colorNormal];
            [botonCondiciones setBackgroundColor:colorHilight];
            [botonArmamento setBackgroundColor:colorNormal];
            [botonTripulacion setBackgroundColor:colorNormal];
            [botonTeplas setBackgroundColor:colorNormal];
            [botonSanidad setBackgroundColor:colorNormal];
            [botonCombustible setBackgroundColor:colorNormal];
            [botonItinerario setHighlighted:NO];
            [botonCondiciones setHighlighted:YES];
            [botonArmamento setHighlighted:NO];
            [botonTripulacion setHighlighted:NO];
            [botonTeplas setHighlighted:NO];
            [botonSanidad setHighlighted:NO];
            [botonCombustible setHighlighted:NO];
            break;
        case 3:
            [botonItinerario setBackgroundColor:colorNormal];
            [botonCondiciones setBackgroundColor:colorNormal];
            [botonArmamento setBackgroundColor:colorHilight];
            [botonTripulacion setBackgroundColor:colorNormal];
            [botonTeplas setBackgroundColor:colorNormal];
            [botonSanidad setBackgroundColor:colorNormal];
            [botonCombustible setBackgroundColor:colorNormal];
            [botonItinerario setHighlighted:NO];
            [botonCondiciones setHighlighted:NO];
            [botonArmamento setHighlighted:YES];
            [botonTripulacion setHighlighted:NO];
            [botonTeplas setHighlighted:NO];
            [botonSanidad setHighlighted:NO];
            [botonCombustible setHighlighted:NO];
            break;
        case 4:
            [botonItinerario setBackgroundColor:colorNormal];
            [botonCondiciones setBackgroundColor:colorNormal];
            [botonArmamento setBackgroundColor:colorNormal];
            [botonTripulacion setBackgroundColor:colorHilight];
            [botonTeplas setBackgroundColor:colorNormal];
            [botonSanidad setBackgroundColor:colorNormal];
            [botonCombustible setBackgroundColor:colorNormal];
            [botonItinerario setHighlighted:NO];
            [botonCondiciones setHighlighted:NO];
            [botonArmamento setHighlighted:NO];
            [botonTripulacion setHighlighted:YES];
            [botonTeplas setHighlighted:NO];
            [botonSanidad setHighlighted:NO];
            [botonCombustible setHighlighted:NO];
            break;
        
        case 5:
            [botonItinerario setBackgroundColor:colorNormal];
            [botonCondiciones setBackgroundColor:colorNormal];
            [botonArmamento setBackgroundColor:colorNormal];
            [botonTripulacion setBackgroundColor:colorNormal];
            [botonTeplas setBackgroundColor:colorHilight];
            [botonSanidad setBackgroundColor:colorNormal];
            [botonCombustible setBackgroundColor:colorNormal];
            [botonItinerario setHighlighted:NO];
            [botonCondiciones setHighlighted:NO];
            [botonArmamento setHighlighted:NO];
            [botonTripulacion setHighlighted:NO];
            [botonTeplas setHighlighted:YES];
            [botonSanidad setHighlighted:NO];
            [botonCombustible setHighlighted:NO];
            break;
            
        
        case 6:
            [botonItinerario setBackgroundColor:colorNormal];
            [botonCondiciones setBackgroundColor:colorNormal];
            [botonArmamento setBackgroundColor:colorNormal];
            [botonTripulacion setBackgroundColor:colorNormal];
            [botonTeplas setBackgroundColor:colorNormal];
            [botonSanidad setBackgroundColor:colorNormal];
            [botonCombustible setBackgroundColor:colorHilight];
            [botonItinerario setHighlighted:NO];
            [botonCondiciones setHighlighted:NO];
            [botonArmamento setHighlighted:NO];
            [botonTripulacion setHighlighted:NO];
            [botonTeplas setHighlighted:NO];
            [botonSanidad setHighlighted:NO];
            [botonCombustible setHighlighted:YES];
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    currentTextField = textField;
    //overlayLabel.text = currentTextField.text;
    if (currentTextField.inputView) {
        currentPicker = (UIPickerView*)currentTextField.inputView;
        //[self animarView:overlayLabel Hasta:CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height/2)+118) conAlpha:1];
//        if([currentTextField.inputView isKindOfClass:[UIDatePicker class]]){
//            if(currentTextField.text.length>0){
//                [(UIDatePicker *)currentPicker setDate:[self returnDateWithStringDate:currentTextField.text
//                                                                      andStringFormat:[self getStringFormatFromDatePicker:(UIDatePicker *)currentPicker]] animated:YES];
//            }
//            return;
//        }
        NSInteger index = 0;
        if (currentPicker.tag == 2008) {
            index=[numbersArray indexOfObject:currentTextField.text];
        }
        
        if(index != NSNotFound ){
            [currentPicker selectRow:index inComponent:0 animated:YES];
        }
        else{
            [currentPicker selectRow:0 inComponent:0 animated:YES];
        }
        
    }
    else{
        //[self animarView:overlayLabel Hasta:CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height/2)-28) conAlpha:1];
    }
}
- (void)textFieldDidChange:(UITextField *)textField{
    //overlayLabel.text = currentTextField.text;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSArray *combInicial = [dicTotalesCombustible objectForKey:@"TFCombustibleInicial"];
    NSArray *tanqueo = [dicTotalesCombustible objectForKey:@"TFTanqueo"];
    NSArray *combFinal = [dicTotalesCombustible objectForKey:@"TFCombustibleFinal"];
    sumaCombustibleInicial = 0;
    sumaTanqueo = 0;
    sumaCombustibleFinal = 0;
    for (UITextField *tf in combInicial) {
        sumaCombustibleInicial += [tf.text intValue];
    }
    for (UITextField *tf in tanqueo) {
        sumaTanqueo += [tf.text intValue];
    }
    for (UITextField *tf in combFinal) {
        sumaCombustibleFinal += [tf.text intValue];
    }
    
    totalCombustibleInicialLabel.text = [NSString stringWithFormat:@"%i", sumaCombustibleInicial];
    totalTanqueoLabel.text = [NSString stringWithFormat:@"%i", sumaTanqueo];
    totalCombustibleFinalLabel.text = [NSString stringWithFormat:@"%i", sumaCombustibleFinal];
}
#pragma mark - creacion de paginas
-(void)crearPaginas{
    int numeroPaginas=6;
    [pageScrollView setPagingEnabled:YES];
    pageScrollView.delegate=self;
    pageScrollView.contentSize=CGSizeMake(pageScrollView.frame.size.width*numeroPaginas, pageScrollView.frame.size.height);
    [pageScrollView setShowsHorizontalScrollIndicator:NO];
    
    [self crearPaginaItinerario];
    [self crearPaginaCondiciones];
    [self crearPaginaArmamentoPiernas];
    [self crearPaginaTripulacion];
    [self crearPaginaTeplasSanidad];
    [self crearFilasDeItinerarioYCondiciones];
    [self crearPaginaCombustible];
    
    /*for (int j=0; j<5; j++) {
        CeldaItinerario *cell=[[CeldaItinerario alloc]initWithFrame:CGRectMake(0, 33+33*j, 0,0) andDelegate:cell];
        [paginaItinerario addSubview:cell];
        [arregloParaSumarItinerario addObject:cell];
        
        CeldaCondiciones *cond=[[CeldaCondiciones alloc]initWithFrame:CGRectMake(0, 33+33*j, 0,0) andDelegate:cond];
        [paginaCondicionesDeVuelo addSubview:cond];
        [arregloParaSumarCondiciones addObject:cond];
    }*/
}
-(void)crearPaginaItinerario{
    paginaItinerario=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*0, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height-50)];
    paginaItinerario.contentSize=CGSizeMake(paginaItinerario.frame.size.width, paginaItinerario.frame.size.height+1);
    paginaItinerario.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *tapDismisser=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callForeignDismisser)];
    [self.view addGestureRecognizer:tapDismisser];
    [pageScrollView addSubview:paginaItinerario];
    CeldaItinerario *header=[[CeldaItinerario alloc]initHeaderWithFrame:CGRectMake(0, 0, 0,0)];
    [paginaItinerario addSubview:header];
    UIView *containerDeResultado=[[UIView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*0, pageScrollView.frame.size.height-50, pageScrollView.frame.size.width, 50)];
    containerDeResultado.backgroundColor=[UIColor darkGrayColor];
    [pageScrollView addSubview:containerDeResultado];
    UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(320, 5, 60, 40)];
    totalLabel.text=@"Total";
    totalLabel.backgroundColor=[UIColor clearColor];
    totalLabel.font=[UIFont boldSystemFontOfSize:20];
    totalLabel.textColor=[UIColor whiteColor];
    totalLabel.textAlignment=NSTextAlignmentCenter;
    [containerDeResultado addSubview:totalLabel];
    
    totalAeronave = [[UILabel alloc]initWithFrame:CGRectMake(389, 5, 60, 40)];
    totalAeronave.text=@"0";
    totalAeronave.textAlignment=NSTextAlignmentCenter;
    [containerDeResultado addSubview:totalAeronave];
    
    totalTripulacion = [[UILabel alloc]initWithFrame:CGRectMake(456, 5, 60, 40)];
    totalTripulacion.text=@"0";
    totalTripulacion.textAlignment=NSTextAlignmentCenter;
    [containerDeResultado addSubview:totalTripulacion];
}
-(void)crearPaginaCondiciones{
    paginaCondicionesDeVuelo=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*1, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height-50)];
    paginaCondicionesDeVuelo.contentSize=CGSizeMake(paginaCondicionesDeVuelo.frame.size.width, paginaCondicionesDeVuelo.frame.size.height+1);
    paginaCondicionesDeVuelo.backgroundColor=[UIColor clearColor];
    [pageScrollView addSubview:paginaCondicionesDeVuelo];
    CeldaCondiciones *condicionesHeader=[[CeldaCondiciones alloc]initHeaderWithFrame:CGRectMake(0, 0, 0, 0)];
    [paginaCondicionesDeVuelo addSubview:condicionesHeader];
    condicionesTotal=[[CeldaCondiciones alloc]initTotalWithFrame:CGRectMake(pageScrollView.frame.size.width*1, pageScrollView.frame.size.height-50, 0, 0)];
    [pageScrollView addSubview:condicionesTotal];

}
-(void)crearPaginaArmamentoPiernas{
    paginaArmamentoPierna=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*2, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    [paginaArmamentoPierna setPagingEnabled:YES];
    [paginaArmamentoPierna setShowsVerticalScrollIndicator:NO];
    paginaArmamentoPierna.backgroundColor=[UIColor clearColor];
    paginaArmamentoPierna.contentSize=CGSizeMake(paginaArmamentoPierna.frame.size.width, paginaArmamentoPierna.frame.size.height+1);
    [pageScrollView addSubview:paginaArmamentoPierna];
    
}
-(void)crearPaginaTripulacion{
    paginaTripulacion=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*3, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    paginaTripulacion.backgroundColor=[UIColor clearColor];
    paginaTripulacion.contentSize=CGSizeMake(paginaTripulacion.frame.size.width, paginaTripulacion.frame.size.height+1);
    [pageScrollView addSubview:paginaTripulacion];
    CeldaTripulacion *tripulacionHeader=[[CeldaTripulacion alloc]initHeaderWithFrame:CGRectMake(0, 0, 0, 0)];
    [paginaTripulacion addSubview:tripulacionHeader];
    int h=0;
    float posFinalY=0;
    for (Tripulacion *tripulacion in ordenDeVuelo.arregloDeTripulacion) {
        //NSLog(@"OK %@",tripulacion.persona);
        CeldaTripulacion *tripCell=[[CeldaTripulacion alloc]initWithFrame:CGRectMake(0, 33+33*h, 0,0) andDelegate:nil];
        [self checkIfTripulacionSavedWithCell:tripCell atIndex:h];
        tripCell.cargoTextField.text=tripulacion.cargo;
        tripCell.nombreTextiField.text=tripulacion.persona;
        tripCell.codigoTextField.text=tripulacion.codigo;
        tripCell.gradoTextField.text=tripulacion.grado;
        tripCell.idPersona=tripulacion.idPersona;
        [paginaTripulacion addSubview:tripCell];
        [arregloTripulacion addObject:tripCell];
        h++;
        posFinalY=tripCell.frame.origin.y+33;
    }
    if (paginaTripulacion.frame.size.height<posFinalY) {
        paginaTripulacion.contentSize=CGSizeMake(paginaTripulacion.frame.size.width, posFinalY);
        paginaTripulacion.contentSize=CGSizeMake(paginaTripulacion.frame.size.width, posFinalY);
    }
    for (int k=0; k<9; k++) {
        CeldaTripulacion *celdaEntrenamiento=[[CeldaTripulacion alloc]initEntrenamientoWithFrame:CGRectMake(500, 33+33*k, 0, 0) andDelegate:lista];
        [paginaTripulacion addSubview:celdaEntrenamiento];
        [arregloEntrenamiento addObject:celdaEntrenamiento];
        [self checkIfEntrenamientoSavedWithCell:celdaEntrenamiento atIndex:k];
    }
}
-(void)crearPaginaTeplasSanidad{
    paginaTeplasSanidad=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*4, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    paginaTeplasSanidad.backgroundColor=[UIColor clearColor];
    paginaTeplasSanidad.contentSize=CGSizeMake(paginaTeplasSanidad.frame.size.width, paginaTeplasSanidad.frame.size.height+1);
    [pageScrollView addSubview:paginaTeplasSanidad];
    CeldaTeplasSanidad *teplasSanidadHeader=[[CeldaTeplasSanidad alloc]initHeaderWithFrame:CGRectMake(0, 0, 0, 0)];
    [paginaTeplasSanidad addSubview:teplasSanidadHeader];
    int h=0;
    float posFinalY=0;
    for (Teplas *teplas in ordenDeVuelo.arregloDeTeplas) {
        //NSLog(@"OK %@",tripulacion.persona);
        CeldaTeplasSanidad *teplasCell=[[CeldaTeplasSanidad alloc]initWithFrame:CGRectMake(0, 33+33*h, 0,0) andDelegate:nil withType:@"teplas"];
        [self checkIfTeplasSavedWithCell:teplasCell atIndex:h];
        teplasCell.cargoTextField.text=teplas.cargo;
        teplasCell.nombreTextiField.text=teplas.persona;
        teplasCell.codigoTextField.text=teplas.persona_id;
        teplasCell.gradoTextField.text=teplas.grado;
        [paginaTeplasSanidad addSubview:teplasCell];
        [arregloTeplas addObject:teplasCell];
        h++;
        posFinalY=teplasCell.frame.origin.y+33;
    }
    int sh = 0;
    for (Sanidad *sanidad in ordenDeVuelo.arregloDeSanidad) {
        //NSLog(@"La sanidad! %@",sanidad.persona_id);
        CeldaTeplasSanidad *sanidadCell=[[CeldaTeplasSanidad alloc]initWithFrame:CGRectMake(484, 33+33*sh, 0,0) andDelegate:nil withType:@"sanidad"];
        [self checkIfSanidadSavedWithCell:sanidadCell atIndex:sh];
        sanidadCell.cargoTextField.text=sanidad.cargo;
        sanidadCell.nombreTextiField.text=sanidad.persona;
        sanidadCell.codigoTextField.text=sanidad.persona_id;
        sanidadCell.gradoTextField.text=sanidad.grado;
        [paginaTeplasSanidad addSubview:sanidadCell];
        [arregloSanidad addObject:sanidadCell];
        sh++;
        posFinalY=sanidadCell.frame.origin.y+33;
    }
    
}
-(void)crearPaginaCombustible{
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];
    
    UIScrollView *paginaCombustible=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*5, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height-50)];
    paginaCombustible.backgroundColor=[UIColor clearColor];
    paginaCombustible.contentSize=CGSizeMake(paginaCombustible.frame.size.width, paginaCombustible.frame.size.height+1);
    [pageScrollView addSubview:paginaCombustible];
    
    int marginLeftForTV = 100;
    int tfHeight = 30;
    int tfWidthLarge = 160;
    int margenInicial = 40;
    
    //Cabecera Combustible
    UILabel *combustibleInicialLabel = [[UILabel alloc]initWithFrame:CGRectMake( 135, 0, 80, 40)];
    combustibleInicialLabel.numberOfLines = 2;
    combustibleInicialLabel.text = @"Combustible Inicial GLS.";
    combustibleInicialLabel.textAlignment = NSTextAlignmentCenter;
    [combustibleInicialLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *tanqueoLabel = [[UILabel alloc]initWithFrame:CGRectMake(305, 0, 80, 40)];
    tanqueoLabel.text = @"Tanqueo GLS.";
    tanqueoLabel.numberOfLines = 2;
    tanqueoLabel.textAlignment = NSTextAlignmentCenter;
    [tanqueoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *comprobanteLabel = [[UILabel alloc]initWithFrame:CGRectMake(460, 0, 80, 40)];
    comprobanteLabel.text = @"No. Comprobante ";
    comprobanteLabel.numberOfLines = 2;
    comprobanteLabel.textAlignment = NSTextAlignmentCenter;
    [comprobanteLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *empresaSuministraLabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 0, 80, 40)];
    empresaSuministraLabel.text = @"Empresa Suministra";
    empresaSuministraLabel.numberOfLines = 2;
    empresaSuministraLabel.textAlignment = NSTextAlignmentCenter;
    [empresaSuministraLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *combustibleFinalLabel = [[UILabel alloc]initWithFrame:CGRectMake(790, 0, 80, 40)];
    combustibleFinalLabel.text = @"Combustible Final GLS.";
    combustibleFinalLabel.numberOfLines = 2;
    combustibleFinalLabel.textAlignment = NSTextAlignmentCenter;
    [combustibleFinalLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    
    [paginaCombustible addSubview:combustibleInicialLabel];
    [paginaCombustible addSubview:tanqueoLabel];
    [paginaCombustible addSubview:comprobanteLabel];
    [paginaCombustible addSubview:empresaSuministraLabel];
    [paginaCombustible addSubview:combustibleFinalLabel];
    
    //combustibleArray = [[NSMutableArray alloc]init];
    NSArray *arregloCombustibleFromSave = [masterDic objectForKey:@"Combustible"];
    
    NSMutableArray *tfCombustibleInicialArray = [[NSMutableArray alloc]init];
    NSMutableArray *tfTanqueoArray = [[NSMutableArray alloc]init];
    NSMutableArray *tfCombustibleFinalArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<ordenDeVuelo.arregloDePiernas.count; i++) {
        Piernas *pierna = ordenDeVuelo.arregloDePiernas[i];
        UILabel *piernaLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, margenInicial+5+(tfHeight*i)+(2*i), 80, 20)];
        piernaLabel.text = [NSString stringWithFormat:@"#%i. %@-%@",i,pierna.de, pierna.a];
        [piernaLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:9]];
        [paginaCombustible addSubview:piernaLabel];
        
        UITextField *combustibleInicialTF = [self crearTextField:marginLeftForTV y:margenInicial+(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:paginaCombustible];
        combustibleInicialTF.inputView = pickerNumeros;
        combustibleInicialTF.textAlignment =NSTextAlignmentCenter;
        [combustibleInicialTF setUserInteractionEnabled:YES];
        
        UITextField *tanqueoTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*1)+2 y:margenInicial+(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:paginaCombustible];
        tanqueoTF.inputView = pickerNumeros;
        tanqueoTF.textAlignment =NSTextAlignmentCenter;
        [tanqueoTF setUserInteractionEnabled:YES];
        
        UITextField *comprobanteTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*2)+4 y:margenInicial+(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:paginaCombustible];
        comprobanteTF.textAlignment =NSTextAlignmentCenter;
        [comprobanteTF setUserInteractionEnabled:YES];
        
        UITextField *empresaSuministraTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*3)+6 y:margenInicial+(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:paginaCombustible];
        empresaSuministraTF.textAlignment =NSTextAlignmentCenter;
        [empresaSuministraTF setUserInteractionEnabled:YES];
                
        UITextField *combustibleFinalTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*4)+8 y:margenInicial+(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:paginaCombustible];
        combustibleFinalTF.textAlignment =NSTextAlignmentCenter;
        combustibleFinalTF.inputView = pickerNumeros;
        [combustibleFinalTF setUserInteractionEnabled:YES];
        
        [tfCombustibleInicialArray addObject:combustibleInicialTF];
        [tfTanqueoArray addObject:tanqueoTF];
        [tfCombustibleFinalArray addObject:combustibleFinalTF];
        

        if(arregloCombustibleFromSave.count >i){
            NSDictionary *tempDic =arregloCombustibleFromSave[i];
            combustibleInicialTF.text = [tempDic objectForKey:@"CombustibleInicial"] ? [tempDic objectForKey:@"CombustibleInicial"]:@"";
            tanqueoTF.text = [tempDic objectForKey:@"Tanqueo"] ? [tempDic objectForKey:@"Tanqueo"]:@"";
            comprobanteTF.text = [tempDic objectForKey:@"Comprobante"] ? [tempDic objectForKey:@"Comprobante"]:@"";
            empresaSuministraTF.text = [tempDic objectForKey:@"EmpresaSuministra"] ? [tempDic objectForKey:@"EmpresaSuministra"]:@"";
            empresaSuministraTF.tag = [tempDic objectForKey:@"IDEmpresaSuministra"] ? [[tempDic objectForKey:@"EmpresaSuministra"] doubleValue ]:0;
            combustibleFinalTF.text = [tempDic objectForKey:@"CombustibleFinal"] ? [tempDic objectForKey:@"CombustibleFinal"]:@"";
        }
        
        sumaTanqueo += [tanqueoTF.text intValue];
        sumaCombustibleInicial += [combustibleInicialTF.text intValue];
        sumaCombustibleFinal += [combustibleFinalTF.text intValue];
        
        NSMutableDictionary * combustibleDic = [[NSMutableDictionary alloc]init];
        [combustibleDic setObject:piernaLabel.text forKey:@"Pierna"];
        [combustibleDic setObject:combustibleInicialTF forKey:@"CombustibleInicial"];
        [combustibleDic setObject:tanqueoTF forKey:@"Tanqueo"];
        [combustibleDic setObject:comprobanteTF forKey:@"Comprobante"];
        [combustibleDic setObject:empresaSuministraTF forKey:@"EmpresaSuministra"];
        [combustibleDic setObject:combustibleFinalTF forKey:@"CombustibleFinal"];
        [arrayCombustible addObject:combustibleDic];
    }
    [dicTotalesCombustible setObject:tfCombustibleInicialArray forKey:@"TFCombustibleInicial"];
    [dicTotalesCombustible setObject:tfTanqueoArray forKey:@"TFTanqueo"];
    [dicTotalesCombustible setObject:tfCombustibleFinalArray forKey:@"TFCombustibleFinal"];
    
    
    UIView *containerDeResultado=[[UIView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*5, pageScrollView.frame.size.height-50, pageScrollView.frame.size.width, 50)];
    containerDeResultado.backgroundColor=[UIColor darkGrayColor];
    [pageScrollView addSubview:containerDeResultado];
    UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 40)];
    totalLabel.text=@"Total";
    totalLabel.backgroundColor=[UIColor clearColor];
    totalLabel.font=[UIFont boldSystemFontOfSize:20];
    totalLabel.textColor=[UIColor whiteColor];
    totalLabel.textAlignment=NSTextAlignmentCenter;
    [containerDeResultado addSubview:totalLabel];
    
    totalCombustibleInicialLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeftForTV, 5, tfWidthLarge, 40)];
    totalCombustibleInicialLabel.text=[NSString stringWithFormat:@"%i",sumaCombustibleInicial];
    totalCombustibleInicialLabel.textAlignment=NSTextAlignmentCenter;
    totalCombustibleInicialLabel.backgroundColor = [UIColor whiteColor];
    [containerDeResultado addSubview:totalCombustibleInicialLabel];
    
    totalTanqueoLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeftForTV+(tfWidthLarge*1)+2, 5, tfWidthLarge, 40)];
    totalTanqueoLabel.text=[NSString stringWithFormat:@"%i",sumaTanqueo];
    totalTanqueoLabel.textAlignment=NSTextAlignmentCenter;
    totalTanqueoLabel.backgroundColor = [UIColor whiteColor];
    [containerDeResultado addSubview:totalTanqueoLabel];
    
    totalCombustibleFinalLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeftForTV+(tfWidthLarge*4)+8, 5, tfWidthLarge, 40)];
    totalCombustibleFinalLabel.text=[NSString stringWithFormat:@"%i",sumaCombustibleFinal];
    totalCombustibleFinalLabel.textAlignment=NSTextAlignmentCenter;
    totalCombustibleFinalLabel.backgroundColor = [UIColor whiteColor];
    [containerDeResultado addSubview:totalCombustibleFinalLabel];
    
}
#pragma mark - creacion de textfields
- (UITextField*)crearTextField:(int)x y:(int)y width:(int)width height:(int)height InView:(UIView*)view{
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
    tf.backgroundColor = [UIColor whiteColor];
    tf.borderStyle =UITextBorderStyleLine;
    tf.delegate = self;
    [tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [view addSubview:tf];
    return tf;
}
#pragma mark - procedimientos compartidos entre páginas
////// las 3 primeras páginas están relacionadas entre sí.
////// dependiendo del número de piernas la cantidad de filas aumenta,
////// y en armamento se afecta el # de pags
-(void)crearFilasDeItinerarioYCondiciones{
    int i=0;
    float posFinalY=0;
    for (Piernas *pierna in ordenDeVuelo.arregloDePiernas) {
        CeldaItinerario *cell=[[CeldaItinerario alloc]initWithFrame:CGRectMake(0, 33+33*i, 0,0) andDelegate:lista];
        cell.noVuelo.text=pierna.piernaNumero;
        cell.de.text=pierna.de;
        cell.a.text=pierna.a;
        cell.tipoOperacion.text=pierna.operacionTipo;
        cell.plan.text=pierna.plan;
        cell.operacion.text=pierna.operacion;
        
        cell.idOperacion=pierna.idOperacion;
        cell.idPlan=pierna.idPlan;
        cell.idTipoOperacion=pierna.idOperacionTipo;
        
        cell.idDe=pierna.idDe;
        cell.idA=pierna.idA;
        
        [self checkIfItinerarioSavedWithCell:cell atIndex:i];
        //NSLog(@"Hora encendido omex %@",cell.horaEncendido.text);
        [paginaItinerario addSubview:cell];
        [arregloParaSumarItinerario addObject:cell];
        
        CeldaCondiciones *cond=[[CeldaCondiciones alloc]initWithFrame:CGRectMake(0, 33+33*i, 0,0) andDelegate:lista];
        cond.entidadTextfield.text=pierna.entidad;
        cond.noPiernaCondiciones=pierna.piernaNumero;
        cond.idEntidad=pierna.idEntidad;
        
        [self checkIfCondicionesSavedWithCell:cond atIndex:i];
        [paginaCondicionesDeVuelo addSubview:cond];
        [arregloParaSumarCondiciones addObject:cond];
        
        VistaListadoArmamento *vistaArmamentos=[[VistaListadoArmamento alloc]initWithFrame:CGRectMake(0, paginaArmamentoPierna.frame.size.height*i, 0, 0) andDelegate:lista];
        paginaArmamentoPierna.contentSize=CGSizeMake(paginaArmamentoPierna.frame.size.width, (paginaArmamentoPierna.frame.size.height+paginaArmamentoPierna.frame.size.height*i)+1);
        [self checkIfArmamentoSavedWithCell:vistaArmamentos atIndex:i];
        vistaArmamentos.stringNoVuelo=cell.noVuelo.text;
        vistaArmamentos.noVuelo.text=[NSString stringWithFormat:@"Vuelo No.: %@",vistaArmamentos.stringNoVuelo];
        [paginaArmamentoPierna addSubview:vistaArmamentos];
        [arregloPaginasArmamento addObject:vistaArmamentos];
        
        i++;
        posFinalY=cond.frame.origin.y+33;
    }
    /*for (int j=0; j<5; j++) {
        CeldaItinerario *cell=[[CeldaItinerario alloc]initWithFrame:CGRectMake(0, 33+33*j, 0,0) andDelegate:cell];
        [paginaItinerario addSubview:cell];
        [self checkIfItinerarioSavedWithCell:cell];
        [arregloParaSumarItinerario addObject:cell];
        
        CeldaCondiciones *cond=[[CeldaCondiciones alloc]initWithFrame:CGRectMake(0, 33+33*j, 0,0) andDelegate:cond];
        [paginaCondicionesDeVuelo addSubview:cond];
        [arregloParaSumarCondiciones addObject:cond];
        posFinalY=cond.frame.origin.y+33;
        VistaListadoArmamento *vistaArmamentos=[[VistaListadoArmamento alloc]initWithFrame:CGRectMake(0, paginaArmamentoPierna.frame.size.height*j, 0, 0)];
        paginaArmamentoPierna.contentSize=CGSizeMake(paginaArmamentoPierna.frame.size.width, paginaArmamentoPierna.frame.size.height+paginaArmamentoPierna.frame.size.height*j);
        vistaArmamentos.noVuelo.text=[NSString stringWithFormat:@"No.Vuelo: %@",cell.noVuelo.text];
        [paginaArmamentoPierna addSubview:vistaArmamentos];
        [arregloPaginasArmamento addObject:vistaArmamentos];
     }*/
    if (paginaItinerario.frame.size.height<posFinalY) {
        paginaItinerario.contentSize=CGSizeMake(paginaItinerario.frame.size.width, posFinalY);
        paginaCondicionesDeVuelo.contentSize=CGSizeMake(paginaCondicionesDeVuelo.frame.size.width, posFinalY);
    }
}
#pragma mark actualizado de columnas
-(void)sumarColumnasItinerario{
    //NSLog(@"Columnas sumadas");
    int totalAeronave1=0;
    int totalTripulacion1=0;
    for (CeldaItinerario *cell in arregloParaSumarItinerario) {
        totalAeronave1+=[cell.tiempoAeronave.text intValue];
        totalTripulacion1+=[cell.tiempoTripulacion.text intValue];
    }
    int minutos=((((int)totalAeronave1*60)/60)%60);
    int horas=(((int)totalAeronave1*60)/(3600));
    NSString *horasMinutosAeronave=[NSString stringWithFormat:@"%i:%.2i",horas,minutos];

    int minutos2=((((int)totalTripulacion1*60)/60)%60);
    int horas2=(((int)totalTripulacion1*60)/(3600));
    NSString *horasMinutosTripulacion=[NSString stringWithFormat:@"%i:%.2i",horas2,minutos2];

    totalAeronave.text=horasMinutosAeronave;//[NSString stringWithFormat:@"%i",totalAeronave1];
    totalTripulacion.text=horasMinutosTripulacion;//[NSString stringWithFormat:@"%i",totalTripulacion1];
    //NSLog(@"Total de la suma es %i",totalAeronave1);
}
-(void)sumarColumnasCondiciones{
    int totalVfrHh=0;
    int totalVfrMi=0;
    int totalIfrHh=0;
    int totalIfrMi=0;
    int totalNocHh=0;
    int totalNocMi=0;
    int totalNvgHh=0;
    int totalNvgMi=0;
    int totalAterrizajes=0;
    int totalHeridos=0;
    int totalMuertos=0;
    int totalPaxSuben=0;
    int totalPaxBajan=0;
    int totalPaxTransito=0;
    int totalCargaSuben=0;
    int totalCargaBajan=0;
    int totalCargaTransito=0;
    for (CeldaCondiciones *cell in arregloParaSumarCondiciones) {
        //NSLog(@"Celda texto %@",cell.paxSubenTextfield.text);
        totalVfrHh+=[cell.vfrHhTextfield.text intValue];
        totalVfrMi+=[cell.vfrMiTextfield.text intValue];
        totalIfrHh+=[cell.ifrHhTextfield.text intValue];
        totalIfrMi+=[cell.ifrMiTextfield.text intValue];
        totalNocHh+=[cell.nocHhTextfield.text intValue];
        totalNocMi+=[cell.nocMiTextfield.text intValue];
        totalNvgHh+=[cell.nvgHhTextfield.text intValue];
        totalNvgMi+=[cell.nvgMiTextfield.text intValue];
        totalAterrizajes+=[cell.aterrizajesTextfield.text intValue];
        totalHeridos+=[cell.heridosTextfield.text intValue];
        totalMuertos+=[cell.muertosTextfield.text intValue];
        totalPaxSuben+=[cell.paxSubenTextfield.text intValue];
        totalPaxBajan+=[cell.paxBajanTextfield.text intValue];
        totalPaxTransito+=[cell.paxTransitoTextfield.text intValue];
        totalCargaSuben+=[cell.cargaSubenTextfield.text intValue];
        totalCargaBajan+=[cell.cargaBajanTextfield.text intValue];
        totalCargaTransito+=[cell.cargaTransitoTextfield.text intValue];
    }
    condicionesTotal.vfrHhTotal.text=[NSString stringWithFormat:@"%i",totalVfrHh];
    condicionesTotal.vfrMiTotal.text=[NSString stringWithFormat:@"%i",totalVfrMi];
    condicionesTotal.ifrHhTotal.text=[NSString stringWithFormat:@"%i",totalIfrHh];
    condicionesTotal.ifrMiTotal.text=[NSString stringWithFormat:@"%i",totalIfrMi];
    condicionesTotal.nocHhTotal.text=[NSString stringWithFormat:@"%i",totalNocHh];
    condicionesTotal.nocMiTotal.text=[NSString stringWithFormat:@"%i",totalNocMi];
    condicionesTotal.nvgHhTotal.text=[NSString stringWithFormat:@"%i",totalNvgHh];
    condicionesTotal.nvgMiTotal.text=[NSString stringWithFormat:@"%i",totalNvgMi];
    condicionesTotal.aterrizajesTotal.text=[NSString stringWithFormat:@"%i",totalAterrizajes];
    condicionesTotal.heridosTotal.text=[NSString stringWithFormat:@"%i",totalHeridos];
    condicionesTotal.muertosTotal.text=[NSString stringWithFormat:@"%i",totalMuertos];
    condicionesTotal.paxSubenTotal.text=[NSString stringWithFormat:@"%i",totalPaxSuben];
    condicionesTotal.paxBajanTotal.text=[NSString stringWithFormat:@"%i",totalPaxBajan];
    condicionesTotal.paxTransitoTotal.text=[NSString stringWithFormat:@"%i",totalPaxTransito];
    condicionesTotal.cargaSubenTotal.text=[NSString stringWithFormat:@"%i",totalCargaSuben];
    condicionesTotal.cargaBajanTotal.text=[NSString stringWithFormat:@"%i",totalCargaBajan];
    condicionesTotal.cargaTransitoTotal.text=[NSString stringWithFormat:@"%i",totalCargaTransito];

    //NSLog(@"Total de la suma es %i",totalVfrHh);
}
#pragma mark - esconder pickers externos
-(void)callForeignDismisser{
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"esconderPicker" object:nil];
    [noRegistroTextfield becomeFirstResponder];
    [noRegistroTextfield resignFirstResponder];
}
#pragma mark - scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGRect frame=[[UIScreen mainScreen] applicationFrame];
    float roundedValue = round(pageScrollView.contentOffset.x / frame.size.width);
    [self seleccionarBoton:roundedValue+1];
    [self callForeignDismisser];
}
#pragma mark - picker delegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==2000) {
        return lista.arregloDeFaseDeVuelo.count;
    }
    else if (pickerView.tag==2001){
        return lista.arregloDeDepartamentos.count;
    }
    else if (pickerView.tag==2002){
        return lista.arregloDeMunicipios.count;
    }
    else if (pickerView.tag==2003){
        return lista.arregloDeArmamentosImpactados.count;
    }
    else if (pickerView.tag==2004){
        return arrayLatitud.count;
    }
    else if (pickerView.tag==2005){
        return arrayLongitud.count;
    }
    else if (pickerView.tag==2006){
        return lista.arregloDeUnidades.count;
    }
    else if (pickerView.tag==2007){
        return lista.arregloDeGrupo.count;
    }
    else if (pickerView.tag == 2008) {
        return numbersArray.count;
    }
    else{
        return 0;
    }
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        if (pickerView.tag==2000) {
        FaseVuelo *result=[lista.arregloDeFaseDeVuelo objectAtIndex:row];
        NSString *strRes=result.faseVuelo;
        return strRes;
        }
        else if (pickerView.tag==2001){
            Departamentos *result=[lista.arregloDeDepartamentos objectAtIndex:row];
            NSString *strRes=result.departamento;
            return strRes;
        }
        else if (pickerView.tag==2002){
            Municipios *result=[lista.arregloDeMunicipios objectAtIndex:row];
            NSString *strRes=[NSString stringWithFormat:@"%@ - %@",result.municipio,result.departamento.departamento];
            return strRes;
        }
        else if (pickerView.tag==2003){
            ArmamentosImpactados *result=[lista.arregloDeArmamentosImpactados objectAtIndex:row];
            NSString *strRes=result.nombre;
            return strRes;
        }
        else if (pickerView.tag==2004){
            NSString *result=[arrayLatitud objectAtIndex:row];
            return result;
        }
        else if (pickerView.tag==2005){
            NSString *result=[arrayLongitud objectAtIndex:row];
            return result;
        }
        else if (pickerView.tag==2006){
            Unidades *result=[lista.arregloDeUnidades objectAtIndex:row];
            NSString *strRes=result.sigla;
            return strRes;
        }
        else if (pickerView.tag==2007){
            Grupo *result=[lista.arregloDeGrupo objectAtIndex:row];
            NSString *strRes=result.nombreOrganizacion;
            return strRes;
        }
        else if (pickerView.tag == 2008) {
            return [NSString stringWithFormat:@"%@",[numbersArray objectAtIndex:row]];
        }
    }
    else{
        return nil;
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        if (pickerView.tag==2000) {
            FaseVuelo *result=[lista.arregloDeFaseDeVuelo objectAtIndex:row];
            NSString *strRes=result.faseVuelo;
            impactadaFaseTextField.text=strRes;
            idImpactadaFase=result.idFaseVuelo;
            return;
        }
        else if (pickerView.tag==2001){
            Departamentos *result=[lista.arregloDeDepartamentos objectAtIndex:row];
            NSString *strRes=result.departamento;
            impactadaDeptoTextField.text=strRes;
            return;
        }
        else if (pickerView.tag==2002){
            Municipios *result=[lista.arregloDeMunicipios objectAtIndex:row];
            NSString *strRes=result.municipio;
            impactadaMunicipioTextField.text=strRes;
            impactadaDeptoTextField.text=result.departamento.departamento;
            idMunicipio=result.idMunicipio;
            idDepartamento=result.departamento.idDepartamento;
            return;
        }
        else if (pickerView.tag==2003){
            ArmamentosImpactados *result=[lista.arregloDeArmamentosImpactados objectAtIndex:row];
            NSString *strRes=result.nombre;
            impactadaArmamentoTextField.text=strRes;
            idArmamentoImpactado=result.idArmamentoImpactado;
            return;
        }
        else if (pickerView.tag==2004){
            NSString *result=[arrayLatitud objectAtIndex:row];
            impactadaLatitud1TextField.text=result;
            return;
        }
        else if (pickerView.tag==2005){
            NSString *result=[arrayLongitud objectAtIndex:row];
            impactadaLongitud1TextField.text=result;
            return;
        }
        else if (pickerView.tag==2006){
            Unidades *result=[lista.arregloDeUnidades objectAtIndex:row];
            NSString *strRes=result.sigla;
            unidadQueCreaTextfield.text=strRes;
            idUnidad=result.idOrganizacion;
            return;
        }
        else if (pickerView.tag==2007){
            Grupo *result=[lista.arregloDeGrupo objectAtIndex:row];
            NSString *strRes=result.nombreOrganizacion;
            grupoTextfield.text=strRes;
            idGrupo=result.idOrganizacion;
            return;
        }
        else if (pickerView.tag == 2008) {
            
            currentTextField.text = [NSString stringWithFormat:@"%@",[numbersArray objectAtIndex:row]];
        }
 
    }
    return;
    
}
#pragma mark - guardar
-(IBAction)guardarRegistro:(UIButton*)sender{
    
    NSMutableDictionary *saveForMision = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *masterDic=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *generalDic=[[NSMutableDictionary alloc]init];
    
    if(idGrupo){[generalDic setObject:idGrupo forKey:@"id_grupo"];}
    if(idMunicipio){[generalDic setObject:idMunicipio forKey:@"id_municipio"];}
    if(idDepartamento){[generalDic setObject:idDepartamento forKey:@"id_departamento"];}
    if(idArmamentoImpactado){[generalDic setObject:idArmamentoImpactado forKey:@"id_armamento_impactado"];}
    if(idUnidad){[generalDic setObject:idUnidad forKey:@"id_unidad"];}
    
    if(ordenDeVuelo.principal.idConsecutivoUnidad){[generalDic setObject:ordenDeVuelo.principal.idConsecutivoUnidad forKey:@"id_consecutivo_unidad"];}
    if(ordenDeVuelo.principal.idOrdenVuelo){[generalDic setObject:ordenDeVuelo.principal.idOrdenVuelo forKey:@"id_orden_vuelo"];}
    if(ordenDeVuelo.principal.idUnidadAsume){[generalDic setObject:ordenDeVuelo.principal.idUnidadAsume forKey:@"id_unidad_asume"];}
    
    if(noRegistroTextfield.text){[generalDic setObject:noRegistroTextfield.text forKey:@"NoRegistro"];}
    if(ordenDeVueloTextfield.text){[generalDic setObject:ordenDeVueloTextfield.text forKey:@"OVNo"];}
    if(fechaTextfield.text){[generalDic setObject:fechaTextfield.text forKey:@"Fecha"];}
    if(unidadAsumeTextfield.text){[generalDic setObject:unidadAsumeTextfield.text forKey:@"UnidadAsume"];}
    if(aeronaveUnoTextfield.text){[generalDic setObject:aeronaveUnoTextfield.text forKey:@"Matricula"];}
    if(aeronaveDosTextfield.text){[generalDic setObject:aeronaveDosTextfield.text forKey:@"Alias"];}
    if(grupoTextfield.text.length>0){[generalDic setObject:grupoTextfield.text forKey:@"Grupo"];}
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"El campo 'Grupo' no debe estar vacío." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if(unidadQueCreaTextfield.text.length>0){
        [generalDic setObject:unidadQueCreaTextfield.text forKey:@"UnidadQueCrea"];
        NSDictionary *unidadDic = @{@"id":idUnidad ? idUnidad:0, @"nombre":unidadQueCreaTextfield.text};
        [saveForMision setObject:unidadDic forKey:@"UnidadQueCrea"];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"El campo 'Unidad que crea' no debe estar vacío." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if(requerimientosTextfield.text){[generalDic setObject:requerimientosTextfield.text forKey:@"Requerimientos"];}
    if(observacionTextfield.text){[generalDic setObject:observacionTextfield.text forKey:@"Observacion"];}
    if(vueloNacionalSwitch.on){[generalDic setObject:@"1" forKey:@"VueloNacionalSwitch"];}
    else{[generalDic setObject:@"0" forKey:@"VueloNacionalSwitch"];}
    
    if(aeronaveImpactadaSwitch.on){
        [generalDic setObject:@"S" forKey:@"aeronave_impactada"];
        if (![self isAllDigitsFromString:impactadaImpactosTextField.text]) {
            [self stopAlertWithFieldName:@"'Aeronave Impactada - Cantidad impactos'"];
            return;
        }
        NSArray *arrayCamposLatitud=[[NSArray alloc]initWithObjects:
                                     impactadaLatitud2TextField.text,
                                     impactadaLatitud3TextField.text,
                                     impactadaLatitud4TextField.text, nil];
        if (![self isAllDigitsFromArray:arrayCamposLatitud]) {
            [self stopAlertWithFieldName:@"'Aeronave Impactada - Latitud'"];
            return;
        }
        
        NSArray *arrayCamposLongitud=[[NSArray alloc]initWithObjects:
                                     impactadaLongitud2TextField.text,
                                     impactadaLongitud3TextField.text,
                                     impactadaLongitud4TextField.text, nil];
        if (![self isAllDigitsFromArray:arrayCamposLongitud]) {
            [self stopAlertWithFieldName:@"'Aeronave Impactada - Longitud'"];
            return;
        }
    
    }
    else{[generalDic setObject:@"N" forKey:@"aeronave_impactada"];}
    
    
    if(impactadaImpactosTextField.text){[generalDic setObject:impactadaImpactosTextField.text forKey:@"ImpactadaNoImpactos"];}
    
    if(idImpactadaFase){[generalDic setObject:idImpactadaFase forKey:@"id_impactada_fase"];}

    
    if(impactadaDeptoTextField.text){[generalDic setObject:impactadaDeptoTextField.text forKey:@"ImpactadaDepto"];}
    if(impactadaMunicipioTextField.text){[generalDic setObject:impactadaMunicipioTextField.text forKey:@"ImpactadaMunicipio"];}

    if(impactadaArmamentoTextField.text){[generalDic setObject:impactadaArmamentoTextField.text forKey:@"ImpactadaArmamento"];}
    if(impactadaNoVueloTextField.text){[generalDic setObject:impactadaNoVueloTextField.text forKey:@"ImpactadaNoVuelo"];}
    
    if(impactadaFaseTextField.text){[generalDic setObject:impactadaFaseTextField.text forKey:@"ImpactadaFase"];}
    
    if(impactadaLatitud1TextField.text){[generalDic setObject:impactadaLatitud1TextField.text forKey:@"ImpactadaLatitud"];}
    if(impactadaLatitud2TextField.text){[generalDic setObject:impactadaLatitud2TextField.text forKey:@"ImpactadaLatitudGrados"];}
    if(impactadaLatitud3TextField.text){[generalDic setObject:impactadaLatitud3TextField.text forKey:@"ImpactadaLatitudMinutos"];}
    if(impactadaLatitud4TextField.text){[generalDic setObject:impactadaLatitud4TextField.text forKey:@"ImpactadaLatitudSegundos"];}
    if(impactadaLongitud1TextField.text){[generalDic setObject:impactadaLongitud1TextField.text forKey:@"ImpactadaLongitud"];}
    if(impactadaLongitud2TextField.text){[generalDic setObject:impactadaLongitud2TextField.text forKey:@"ImpactadaLongitudGrados"];}
    if(impactadaLongitud3TextField.text){[generalDic setObject:impactadaLongitud3TextField.text forKey:@"ImpactadaLongitudMinutos"];}
    if(impactadaLongitud4TextField.text){[generalDic setObject:impactadaLongitud4TextField.text forKey:@"ImpactadaLongitudSegundos"];}
    
    FileSaver *file=[[FileSaver alloc]init];
    NSString *user=@"";
    if ([file getDictionary:@"User"]) {
        user=[[file getDictionary:@"User"] objectForKey:@"username"];
    }
    else{
        user=@"NoUser";
    }
        
    [generalDic setObject:user forKey:@"Usuario"];
    
    [masterDic setObject:generalDic forKey:@"General"];
    
    
    
    NSMutableArray *itinerarioArray=[[NSMutableArray alloc]init];
    for (CeldaItinerario *cell in arregloParaSumarItinerario) {
        NSMutableDictionary *itinerarioDic=[[NSMutableDictionary alloc]init];
        
        if(cell.noVuelo.text){[itinerarioDic setObject:cell.noVuelo.text forKey:@"NoVuelo"];}
        if(cell.de.text){[itinerarioDic setObject:cell.de.text forKey:@"De"];}
        if(cell.a.text){[itinerarioDic setObject:cell.a.text forKey:@"A"];}
        
        if(cell.segundosEncendido){[itinerarioDic setObject:[NSString stringWithFormat:@"%.0f",cell.segundosEncendido] forKey:@"HoraEncendidoSegundos"];}
        if(cell.segundosApagado){[itinerarioDic setObject:[NSString stringWithFormat:@"%.0f",cell.segundosApagado] forKey:@"HoraApagadoSegundos"];}
        if(cell.segundosDecolaje){[itinerarioDic setObject:[NSString stringWithFormat:@"%.0f",cell.segundosDecolaje] forKey:@"HoraDecolajeSegundos"];}
        if(cell.segundosAterrizaje){[itinerarioDic setObject:[NSString stringWithFormat:@"%.0f",cell.segundosAterrizaje] forKey:@"HoraAterrizajeSegundos"];}
        
        if(cell.horaEncendidoFormateado){[itinerarioDic setObject:[NSString stringWithFormat:@"%@",cell.horaEncendidoFormateado] forKey:@"HoraEncendido"];}
        if(cell.horaApagadoFormateado){[itinerarioDic setObject:[NSString stringWithFormat:@"%@",cell.horaApagadoFormateado] forKey:@"HoraApagado"];}
        if(cell.horaDecolajeFormateado){[itinerarioDic setObject:[NSString stringWithFormat:@"%@",cell.horaDecolajeFormateado] forKey:@"HoraDecolaje"];}
        if(cell.horaAterrizajeFormateado){[itinerarioDic setObject:[NSString stringWithFormat:@"%@",cell.horaAterrizajeFormateado] forKey:@"HoraAterrizaje"];}
        
        if(cell.horaEncendidoOverlay.text){[itinerarioDic setObject:cell.horaEncendidoOverlay.text forKey:@"HoraEncendidoOverlay"];}
        if(cell.horaApagadoOverlay.text){[itinerarioDic setObject:cell.horaApagadoOverlay.text forKey:@"HoraApagadoOverlay"];}
        if(cell.horaDecolajeOverlay.text){[itinerarioDic setObject:cell.horaDecolajeOverlay.text forKey:@"HoraDecolajeOverlay"];}
        if(cell.horaAterrizajeOverlay.text){[itinerarioDic setObject:cell.horaAterrizajeOverlay.text forKey:@"HoraAterrizajeOverlay"];}
        
        if(cell.segundosEncendido && cell.segundosApagado){
            double ap=cell.segundosApagado;
            double enc=cell.segundosEncendido;
            double res=ap-enc;
            [itinerarioDic setObject:[NSString stringWithFormat:@"%.2f",res] forKey:@"tiempo_tripulacion"];
        }
        else{
            [itinerarioDic setObject:@"0.00" forKey:@"tiempo_tripulacion"];
        }
        if(cell.horaDecolaje.text && cell.horaAterrizaje.text){
            double ap=cell.segundosAterrizaje;
            double enc=cell.segundosDecolaje;
            double res=ap-enc;
            [itinerarioDic setObject:[NSString stringWithFormat:@"%.2f",res] forKey:@"tiempo_aeronave"];
        }
        else{
            [itinerarioDic setObject:@"0.00" forKey:@"tiempo_aeronave"];
        }
        
        if(cell.tipoOperacion.text){[itinerarioDic setObject:cell.tipoOperacion.text forKey:@"TipoOperacion"];}
        if(cell.plan.text){[itinerarioDic setObject:cell.plan.text forKey:@"Plan"];}
        if(cell.operacion.text){[itinerarioDic setObject:cell.operacion.text forKey:@"Operacion"];}
        
        if(cell.idOperacion){[itinerarioDic setObject:cell.idOperacion forKey:@"id_operacion"];}
        if(cell.idPlan){[itinerarioDic setObject:cell.idPlan forKey:@"id_plan"];}
        if(cell.idTipoOperacion){[itinerarioDic setObject:cell.idTipoOperacion forKey:@"id_operacion_tipo"];}
        
        if(cell.idDe){[itinerarioDic setObject:cell.idDe forKey:@"id_de"];}
        if(cell.idA){[itinerarioDic setObject:cell.idA forKey:@"id_a"];}
        
//        NSMutableDictionary * tempDicForSave = [[NSMutableDictionary alloc]init];
//        [tempDicForSave setObject:cell.tipoOperacion forKey:@"OperacionTipo"];
//        [tempDicForSave setObject:cell.idTipoOperacion forKey:@"IdOperacionTipo"];
//        [tempDicForSave setObject:cell.operacion forKey:@"Operacion"];
//        [tempDicForSave setObject:cell.idOperacion forKey:@"IdOperacion"];
//        [tempDicForSave setObject:cell.plan forKey:@"Plan"];
//        [tempDicForSave setObject:cell.idPlan forKey:@"IdPlan"];
//        [arrayItinerario addObject:tempDicForSave];
        
        if(cell.checkDefensa.isOn){[itinerarioDic setObject:@"S" forKey:@"CheckDefensa"];}
        else{[itinerarioDic setObject:@"N" forKey:@"CheckDefensa"];}
        [itinerarioArray addObject:itinerarioDic];
    }
    [masterDic setObject:itinerarioArray forKey:@"ArregloItinerario"];
    
    
    //Save itinerario para misión
    [saveForMision setObject:itinerarioArray forKey:@"Itinerario"];
    [saveForMision setObject:requerimientosTextfield.text.length ? requerimientosTextfield.text:@"No" forKey:@"Requerimiento"];
    ////////////////////
    
    
    
    NSMutableArray *condicionesArray=[[NSMutableArray alloc]init];
    for (CeldaCondiciones *cell in arregloParaSumarCondiciones) {
        NSMutableDictionary *condicionesDic=[[NSMutableDictionary alloc]init];
        
        if (cell.idEntidad) {[condicionesDic setObject:cell.idEntidad forKey:@"id_entidad"];}
        
        if ([cell.vfrHhTextfield.text isEqualToString:@""]) {
            cell.vfrHhTextfield.text=@"0";
        }
        if ([cell.vfrMiTextfield.text isEqualToString:@""]) {
            cell.vfrMiTextfield.text=@"0";
        }
        if ([cell.ifrHhTextfield.text isEqualToString:@""]) {
            cell.ifrHhTextfield.text=@"0";
        }
        if ([cell.ifrMiTextfield.text isEqualToString:@""]) {
            cell.ifrMiTextfield.text=@"0";
        }
        if ([cell.nocHhTextfield.text isEqualToString:@""]) {
            cell.nocHhTextfield.text=@"0";
        }
        if ([cell.nocMiTextfield.text isEqualToString:@""]) {
            cell.nocMiTextfield.text=@"0";
        }
        if ([cell.nvgHhTextfield.text isEqualToString:@""]) {
            cell.nvgHhTextfield.text=@"0";
        }
        if ([cell.nvgMiTextfield.text isEqualToString:@""]) {
            cell.nvgMiTextfield.text=@"0";
        }
        if ([cell.aterrizajesTextfield.text isEqualToString:@""]) {
            cell.aterrizajesTextfield.text=@"0";
        }
        if ([cell.heridosTextfield.text isEqualToString:@""]) {
            cell.heridosTextfield.text=@"0";
        }
        if ([cell.muertosTextfield.text isEqualToString:@""]) {
            cell.muertosTextfield.text=@"0";
        }
        if ([cell.paxSubenTextfield.text isEqualToString:@""]) {
            cell.paxSubenTextfield.text=@"0";
        }
        if ([cell.paxBajanTextfield.text isEqualToString:@""]) {
            cell.paxBajanTextfield.text=@"0";
        }
        if ([cell.cargaSubenTextfield.text isEqualToString:@""]) {
            cell.cargaSubenTextfield.text=@"0";
        }
        if ([cell.cargaBajanTextfield.text isEqualToString:@""]) {
            cell.cargaBajanTextfield.text=@"0";
        }
        
        NSArray *numberVerifyingArray=[[NSArray alloc]initWithObjects:
                                       cell.vfrHhTextfield.text,
                                       cell.vfrMiTextfield.text,
                                       cell.ifrHhTextfield.text,
                                       cell.ifrMiTextfield.text,
                                       cell.nocHhTextfield.text,
                                       cell.nocMiTextfield.text,
                                       cell.nvgHhTextfield.text,
                                       cell.nvgMiTextfield.text,
                                       cell.aterrizajesTextfield.text,
                                       cell.heridosTextfield.text,
                                       cell.muertosTextfield.text,
                                       cell.paxSubenTextfield.text,
                                       cell.paxBajanTextfield.text,
                                       cell.cargaSubenTextfield.text,
                                       cell.cargaBajanTextfield.text,nil];

        
        BOOL esNumero=[self isAllDigitsFromArray:numberVerifyingArray];
        if (!esNumero) {
            NSLog(@"Hay items no numéricos, detener la operación");
            [self stopAlertWithSectionName:@"Condiciones de Vuelo"];
            return;
        }
        else{
            NSLog(@"Todos son números, se puede continuar");
        }
        
        if (cell.vfrHhTextfield.text) {[condicionesDic setObject:cell.vfrHhTextfield.text forKey:@"VfrHh"];}
        if (cell.vfrMiTextfield.text) {[condicionesDic setObject:cell.vfrMiTextfield.text forKey:@"VfrMi"];}
        if (cell.ifrHhTextfield.text) {[condicionesDic setObject:cell.ifrHhTextfield.text forKey:@"IfrHh"];}
        if (cell.ifrMiTextfield.text) {[condicionesDic setObject:cell.ifrMiTextfield.text forKey:@"IfrMi"];}
        if (cell.nocHhTextfield.text) {[condicionesDic setObject:cell.nocHhTextfield.text forKey:@"NocHh"];}
        if (cell.nocMiTextfield.text) {[condicionesDic setObject:cell.nocMiTextfield.text forKey:@"NocMi"];}
        if (cell.nvgHhTextfield.text) {[condicionesDic setObject:cell.nvgHhTextfield.text forKey:@"NvgHh"];}
        if (cell.nvgMiTextfield.text) {[condicionesDic setObject:cell.nvgMiTextfield.text forKey:@"NvgMi"];}
        if (cell.aterrizajesTextfield.text) {[condicionesDic setObject:cell.aterrizajesTextfield.text forKey:@"Aterrizajes"];}
        if (cell.heridosTextfield.text) {[condicionesDic setObject:cell.heridosTextfield.text forKey:@"Heridos"];}
        if (cell.muertosTextfield.text) {[condicionesDic setObject:cell.muertosTextfield.text forKey:@"Muertos"];}
        if (cell.paxSubenTextfield.text) {[condicionesDic setObject:cell.paxSubenTextfield.text forKey:@"PaxSuben"];}
        if (cell.paxBajanTextfield.text) {[condicionesDic setObject:cell.paxBajanTextfield.text forKey:@"PaxBajan"];}
        if (cell.cargaSubenTextfield.text) {[condicionesDic setObject:cell.cargaSubenTextfield.text forKey:@"CargaSuben"];}
        if (cell.cargaBajanTextfield.text) {[condicionesDic setObject:cell.cargaBajanTextfield.text forKey:@"CargaBajan"];}
        if (cell.entidadTextfield.text) {[condicionesDic setObject:cell.entidadTextfield.text forKey:@"Entidad"];}
        if (cell.noPiernaCondiciones) {[condicionesDic setObject:cell.noPiernaCondiciones forKey:@"NoVueloCondiciones"];}
        
        if(cell.cargaSubenTextfield.text && cell.cargaBajanTextfield.text){
            int ap=[cell.cargaSubenTextfield.text intValue];
            int enc=[cell.cargaBajanTextfield.text intValue];
            int res=ap-enc;
            [condicionesDic setObject:[NSString stringWithFormat:@"%i",res] forKey:@"carga_transito"];
        }
        else{
            [condicionesDic setObject:@"0" forKey:@"carga_transito"];
        }
        if(cell.paxSubenTextfield.text && cell.paxBajanTextfield.text){
            int ap=[cell.paxSubenTextfield.text intValue];
            int enc=[cell.paxBajanTextfield.text intValue];
            int res=ap-enc;
            [condicionesDic setObject:[NSString stringWithFormat:@"%i",res] forKey:@"pax_transito"];
        }
        else{
            [condicionesDic setObject:@"0" forKey:@"pax_transito"];
        }

        [condicionesArray addObject:condicionesDic];
    }
    //Save Condiciones para misión
    [saveForMision setObject:condicionesArray forKey:@"Condiciones"];
    ////////////////////
    
    [masterDic setObject:condicionesArray forKey:@"ArregloCondiciones"];
    
    NSMutableArray *armamentoArray=[[NSMutableArray alloc]init];
    for (VistaListadoArmamento *pag in arregloPaginasArmamento) {
        NSMutableArray *arregloCeldasArmamento=[[NSMutableArray alloc]init];
        for (CeldaArmamento *cell in pag.arregloDeFilasArmamento) {
            NSMutableDictionary *diccionarioCeldasArmamento=[[NSMutableDictionary alloc]init];
            if (cell.armamentoTextField.text) {[diccionarioCeldasArmamento setObject:cell.armamentoTextField.text forKey:@"Armamento"];}
            if (cell.cantidadTextiField.text) {[diccionarioCeldasArmamento setObject:[cell.cantidadTextiField.text length]>0 ? cell.cantidadTextiField.text:@"0" forKey:@"Cantidad"];}
            //if (cell.cantidadFallidoTextField.text) {[diccionarioCeldasArmamento setObject:cell.cantidadFallidoTextField.text forKey:@"CantidadFallido"];}
            
            if (cell.objetivoTextField.text) {[diccionarioCeldasArmamento setObject:cell.objetivoTextField.text forKey:@"Objetivo"];}
            if (cell.coordenadaTextField.text){
                NSString *coordParsed=[[[cell.coordenadaTextField.text stringByReplacingOccurrencesOfString:@"º" withString:@"g"] stringByReplacingOccurrencesOfString:@"'" withString:@"m"] stringByReplacingOccurrencesOfString:@"\"" withString:@"s"];
                [diccionarioCeldasArmamento setObject:coordParsed forKey:@"Coordenada"];
            }
            if (cell.departamentoTextfield.text) {[diccionarioCeldasArmamento setObject:cell.departamentoTextfield.text forKey:@"Departamento"];}
            if (cell.enemigoTextField.text) {[diccionarioCeldasArmamento setObject:cell.enemigoTextField.text forKey:@"Enemigo"];}
            if (pag.stringNoVuelo) {[diccionarioCeldasArmamento setObject:pag.stringNoVuelo forKey:@"NoVuelo"];}
            
            if(cell.idObjetivo){[diccionarioCeldasArmamento setObject:cell.idObjetivo forKey:@"id_blanco"];}
            if(cell.idEnemigo){[diccionarioCeldasArmamento setObject:cell.idEnemigo forKey:@"id_enemigo"];}
            if(cell.idArmamento){[diccionarioCeldasArmamento setObject:cell.idArmamento forKey:@"id_armamento"];}
            
            //Comprueba al menos que los 2 primeros campos tengan contenido para agregar un 0
            if ([cell.armamentoTextField.text length] > 0 && [cell.cantidadTextiField.text length] > 0) {
                [diccionarioCeldasArmamento setObject:[cell.cantidadFallidoTextField.text length] > 0 ? cell.cantidadFallidoTextField.text:@"0" forKey:@"CantidadFallido"];
                [arregloCeldasArmamento addObject:diccionarioCeldasArmamento];
            }
        }
        [armamentoArray addObject:arregloCeldasArmamento];
    }
    
    //Save Armamento para misión
    [saveForMision setObject:armamentoArray forKey:@"Armamento"];
    ////////////////////
    
    [masterDic setObject:armamentoArray forKey:@"ArregloArmamento"];
    
    NSMutableArray *tripulacionArray=[[NSMutableArray alloc]init];
    for (CeldaTripulacion *cell in arregloTripulacion) {
        NSMutableDictionary *tripulacionDic=[[NSMutableDictionary alloc]init];
        if (cell.cargoTextField.text) {[tripulacionDic setObject:cell.cargoTextField.text forKey:@"Cargo"];}
        if (cell.nombreTextiField.text) {[tripulacionDic setObject:cell.nombreTextiField.text forKey:@"Nombre"];}
        if (cell.codigoTextField.text) {[tripulacionDic setObject:cell.codigoTextField.text forKey:@"Codigo"];}
        if (cell.gradoTextField.text) {[tripulacionDic setObject:cell.gradoTextField.text forKey:@"Grado"];}
        
        if (cell.idPersona){[tripulacionDic setObject:cell.idPersona forKey:@"id_persona"];}
        
        [tripulacionArray addObject:tripulacionDic];
    }
    [masterDic setObject:tripulacionArray forKey:@"ArregloTripulacion"];
    
    NSMutableArray *entrenamientoArray=[[NSMutableArray alloc]init];
    for (CeldaTripulacion *cell in arregloEntrenamiento) {
        NSMutableDictionary *entrenamientoDic=[[NSMutableDictionary alloc]init];
        if (cell.maniobraTextField.text) {[entrenamientoDic setObject:cell.maniobraTextField.text forKey:@"Maniobra"];}
        if (cell.cantidadTextfield.text) {[entrenamientoDic setObject:[cell.cantidadTextfield.text length] > 0 ? cell.cantidadTextfield.text:@"0" forKey:@"Cantidad"];}

        if (cell.idManiobra) {[entrenamientoDic setObject:cell.idManiobra forKey:@"id_maniobra"];}
        
        [entrenamientoArray addObject:entrenamientoDic];
    }
    [masterDic setObject:entrenamientoArray forKey:@"ArregloEntrenamiento"];
    
    NSMutableArray *teplasArray=[[NSMutableArray alloc]init];
    for (CeldaTeplasSanidad *cell in arregloTeplas) {
        NSMutableDictionary *teplasDic=[[NSMutableDictionary alloc]init];
        if (cell.cargoTextField.text) {[teplasDic setObject:cell.cargoTextField.text forKey:@"Cargo"];}
        if (cell.nombreTextiField.text) {[teplasDic setObject:cell.nombreTextiField.text forKey:@"Nombre"];}
        if (cell.codigoTextField.text) {[teplasDic setObject:cell.codigoTextField.text forKey:@"Codigo"];}
        if (cell.gradoTextField.text) {[teplasDic setObject:cell.gradoTextField.text forKey:@"Grado"];}
        
        [teplasArray addObject:teplasDic];
    }
    [masterDic setObject:teplasArray forKey:@"ArregloTeplas"];
    
    NSMutableArray *sanidadArray=[[NSMutableArray alloc]init];
    for (CeldaTeplasSanidad *cell in arregloSanidad) {
        
        NSMutableDictionary *sanidadDic=[[NSMutableDictionary alloc]init];
        if (cell.cargoTextField.text) {[sanidadDic setObject:cell.cargoTextField.text forKey:@"Cargo"];}
        if (cell.nombreTextiField.text) {[sanidadDic setObject:cell.nombreTextiField.text forKey:@"Nombre"];}
        if (cell.codigoTextField.text) {[sanidadDic setObject:cell.codigoTextField.text forKey:@"Codigo"];}
        if (cell.gradoTextField.text) {[sanidadDic setObject:cell.gradoTextField.text forKey:@"Grado"];}
        
        [sanidadArray addObject:sanidadDic];
    }
    [masterDic setObject:sanidadArray forKey:@"ArregloSanidad"];
    
    NSMutableArray *combustibleArray=[[NSMutableArray alloc]init];
    for (NSDictionary *dic in arrayCombustible) {
        UITextField *tf1 = [dic objectForKey:@"CombustibleInicial"];
        UITextField *tf2 = [dic objectForKey:@"Tanqueo"];
        UITextField *tf3 = [dic objectForKey:@"Comprobante"];
        UITextField *tf4 = [dic objectForKey:@"EmpresaSuministra"];
        UITextField *tf5 = [dic objectForKey:@"CombustibleFinal"];
        
        //Validación acá
        int inicial = tf1.text.length ? [tf1.text intValue]:0;
        int final = tf2.text.length ? [tf5.text intValue]:0;
        int tanqueo = tf3.text.length ? [tf2.text intValue]:0;
        
        BOOL esMayor = final > (inicial+tanqueo) ? YES:NO;
        
        if (esMayor) {
            NSString *message = [NSString stringWithFormat:@"Los galones de combustibles finales, no deben ser  mayores a la suma de los galones de combustible iniciales y los galones de combustible tanqueados en la pierna %@",[dic objectForKey:@"Pierna"]];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
                //Fin de validación
        
        NSMutableDictionary *combustibleDic=[[NSMutableDictionary alloc]init];
        [combustibleDic setObject:tf1.text forKey:@"CombustibleInicial"];
        [combustibleDic setObject:tf2.text forKey:@"Tanqueo"];
        [combustibleDic setObject:tf3.text forKey:@"Comprobante"];
        [combustibleDic setObject:tf4.text forKey:@"EmpresaSuministra"];
        [combustibleDic setObject:[NSString stringWithFormat:@"%li",(long)tf4.tag] forKey:@"IDEmpresaSuministra"];
        [combustibleDic setObject:tf5.text forKey:@"CombustibleFinal"];
        [combustibleArray addObject:combustibleDic];
    }
    [masterDic setObject:combustibleArray forKey:@"Combustible"];
    
    SBJSON *json=[[SBJSON alloc]init];
    //NSMutableArray *arr=[[NSMutableArray alloc]init];
    //for (int i=0; i<19; i++) {
    //[arr addObject:[serverArray objectAtIndex:i]];
    //}
    
    //NSString *str=[json stringWithObject:serverArray];
    NSMutableDictionary *ultra=[[NSMutableDictionary alloc]init];
    [ultra setObject:masterDic forKey:@"RegistroDeVuelo"];
    NSString *str=[json stringWithObject:ultra];
    //NSLog(@"JSON %@",str);
    
    
    
    [masterDic setObject:@"NO" forKey:@"Done"];
    [masterDic setObject:ordenDeVuelo.principal.idConsecutivoUnidad forKey:@"NoOrden"];
    //[masterDic setObject:@"123456" forKey:@"IdRegistro"];

    [file setDictionary:saveForMision withName:@"SaveMision"];
    [file setDictionary:@{@"NoOrden":ordenDeVuelo.principal.idConsecutivoUnidad} withName:@"UltimoRegistroGuardado"];
    
    if (sender.tag==10) {
        FileSaver *file=[[FileSaver alloc]init];
        [file setDictionary:masterDic withName:ordenDeVuelo.principal.idConsecutivoUnidad];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (sender.tag==11){
        [self sincronizarDataConServer:str];
        //NSLog(@"Diccionario %@",masterDic);
    }
}
#pragma mark - fecha
-(void)displayDate:(id)sender {
    NSDate * selected = [datePicker date];
    //NSString * dateString = [selected description];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];//HH:mm
    
    NSString *strDate = [formatter stringFromDate:selected];
    fechaTextfield.text = strDate;
}
#pragma mark - server communication
-(void)sincronizarDataConServer:(NSString*)data{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=1;
    //FileSaver *file=[[FileSaver alloc]init];
    //NSString *params=[NSString  stringWithFormat:@"<jsonEntrada>%@</jsonEntrada>",[IAmCoder base64String:data]];
    
    
    /*NSData *realData=[data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *userDic=[file getDictionary:@"User"];
    NSData *cipher=[realData AES256EncryptWithKey:[userDic objectForKey:@"password"]];
    NSString *params=[NSString  stringWithFormat:@"<jsonEntrada>%@</jsonEntrada>",[IAmCoder base64EncodeData:cipher]];*/
    //FileSaver *temp=[[FileSaver alloc]init];
    //NSString *cipher=[IAmCoder encryptAndBase64:data withKey:[[temp getDictionary:@"Temp"] objectForKey:@"sha"]];
    NSString *cipher=[IAmCoder encryptAndBase64:data withKey:[IAmCoder dateKey]];

    NSString *params=[NSString  stringWithFormat:@"<jsonEntrada>%@</jsonEntrada>",cipher];
    
    [server callServerWithMethod:@"RegistrarVuelo" andParameter:params];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"Enviando Registro";
}
#pragma mark - server response
-(void)receivedDataFromServer:(ServerCommunicator*)sender{
    //NSLog(@"Respuesta %@",sender.resDic);
    if (sender.tag==1) {
        /*if ([[sender.resDic objectForKey:@"status:"] isEqualToString:@"false"] || [[sender.resDic objectForKey:@"status:"] isEqualToString:@" false"]) {
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:[sender.resDic objectForKey:@"mensaje:"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         }
         else if ([[sender.resDic objectForKey:@"status:"] isEqualToString:@"true"] || [[sender.resDic objectForKey:@"status:"] isEqualToString:@" true"]) {
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"Registro exitoso No:\n%@",[sender.resDic objectForKey:@"noRegistro"]] message:[sender.resDic objectForKey:@"mensaje:"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         FileSaver *file=[[FileSaver alloc]init];
         NSMutableDictionary *masterDic=[[NSMutableDictionary alloc]init];
         [masterDic setObject:@"YES" forKey:@"Done"];
         [file setDictionary:masterDic withName:ordenDeVuelo.principal.idConsecutivoUnidad];
         [self.navigationController popViewControllerAnimated:YES];
         }*/
        if ([sender.resDic objectForKey:@"status:"]) {
            if ([[sender.resDic objectForKey:@"status:"] intValue]==2) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:[sender.resDic objectForKey:@"mensaje:"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                UILabel *label=[[UILabel alloc]init];
                label.backgroundColor=[UIColor redColor];
                label.layer.cornerRadius=10;
                label.frame=CGRectMake(5, 2, 273, 13);
                [alert addSubview:label];
                [alert show];
            }
            else if ([[sender.resDic objectForKey:@"status:"] intValue]==0) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"Registro exitoso No:\n%@",[sender.resDic objectForKey:@"noRegistro"]] message:[sender.resDic objectForKey:@"mensaje:"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                UILabel *label=[[UILabel alloc]init];
                label.backgroundColor=[UIColor greenColor];
                label.layer.cornerRadius=10;
                label.frame=CGRectMake(5, 2, 273, 13);
                [alert addSubview:label];
                [alert show];
                FileSaver *file=[[FileSaver alloc]init];
                NSMutableDictionary *masterDic=[[NSMutableDictionary alloc]init];
                [masterDic setObject:@"YES" forKey:@"Done"];
                [masterDic setObject:[sender.resDic objectForKey:@"IdRegistro"] forKey:@"IdRegistro"];
                [masterDic setObject:[sender.resDic objectForKey:@"noRegistro"] forKey:@"noRegistro"];
                [file setDictionary:masterDic withName:ordenDeVuelo.principal.idConsecutivoUnidad];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if ([[sender.resDic objectForKey:@"status:"] intValue]==1) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"Registro con Advertencia No:\n%@",[sender.resDic objectForKey:@"noRegistro"]] message:[sender.resDic objectForKey:@"mensaje:"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                UILabel *label=[[UILabel alloc]init];
                label.backgroundColor=[UIColor yellowColor];
                label.layer.cornerRadius=10;
                label.frame=CGRectMake(5, 2, 273, 13);
                [alert addSubview:label];
                [alert show];
                FileSaver *file=[[FileSaver alloc]init];
                NSMutableDictionary *masterDic=[[NSMutableDictionary alloc]init];
                [masterDic setObject:@"YES" forKey:@"Done"];
                [masterDic setObject:[sender.resDic objectForKey:@"IdRegistro"] forKey:@"IdRegistro"];
                [masterDic setObject:[sender.resDic objectForKey:@"noRegistro"] forKey:@"noRegistro"];
                [file setDictionary:masterDic withName:ordenDeVuelo.principal.idConsecutivoUnidad];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Ha ocurrido un error. Por favor vuelva a intentarlo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)receivedDataFromServerWithError:(ServerCommunicator*)sender{
    if (sender.tag==1) {
        NSString *titulo=@"Error al enviar registro de vuelo";
        NSString *mensaje=@"Su registro no pudo ser enviado. Compruebe la conexión a la red y vuelva a intentarlo.";
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark number check
- (BOOL) isAllDigitsFromArray:(NSArray*)array{
    for (NSString *string in array) {
        NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSRange r = [string rangeOfCharacterFromSet: nonNumbers];
        if (r.location != NSNotFound) {
            return NO;
        }
    }
    return YES;
}
- (BOOL) isAllDigitsFromString:(NSString*)string{
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [string rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}
- (void) stopAlertWithFieldName:(NSString*)fieldName{
    NSString *titulo=@"Error";
    NSString *mensaje=[NSString stringWithFormat:@"Su registro no pudo ser enviado ya que contiene un elemento no numérico en el campo %@. Por favor verifique y vuelva a intentarlo.",fieldName];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (void) stopAlertWithSectionName:(NSString*)sectionName{
    NSString *titulo=@"Error";
    NSString *mensaje=[NSString stringWithFormat:@"Su registro no pudo ser enviado ya que contiene un elemento no numérico en la sección %@. Por favor verifique y vuelva a intentarlo.",sectionName];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end
