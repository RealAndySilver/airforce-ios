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

@implementation RegistroDeVueloViewController
@synthesize ordenDeVuelo,arrayFaseVuelo,arrayDepartamentos,arrayMunicipios,arrayArmamentos,arrayLatitud,arrayLongitud;
- (void)viewDidLoad
{
    [super viewDidLoad];
    arregloParaSumarItinerario=[[NSMutableArray alloc]init];
    arregloParaSumarCondiciones=[[NSMutableArray alloc]init];
    arregloPaginasArmamento=[[NSMutableArray alloc]init];
    arregloTripulacion=[[NSMutableArray alloc]init];
    arregloEntrenamiento=[[NSMutableArray alloc]init];
    [self crearPaginas];
    [self seleccionarBoton:1];
    //NSLog(@"Fecha fase %@",ordenDeVuelo.principal.fecha);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sumarColumnasItinerario) name:@"validado" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sumarColumnasCondiciones) name:@"updateCondiciones" object:nil];
    
    [self integrarInfoDeOrdenDeVueloEnLosTextfields];
    [self setAllPickers];
    [self checkIfSaved];
    
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
    if (arrayDepartamentos.count) {
        impactadaDeptoTextField.inputView=pickerDepto;
    }
    
    pickerMunicipio=[[UIPickerView alloc]init];
    pickerMunicipio.dataSource=self;
    pickerMunicipio.delegate=self;
    pickerMunicipio.showsSelectionIndicator = YES;
    pickerMunicipio.tag=2002;
    //impactadaMunicipioTextField.inputView=pickerMunicipio;
    
    pickerArmamentos=[[UIPickerView alloc]init];
    pickerArmamentos.dataSource=self;
    pickerArmamentos.delegate=self;
    pickerArmamentos.showsSelectionIndicator = YES;
    pickerArmamentos.tag=2003;
    if (arrayArmamentos.count) {
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
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(displayDate:) forControlEvents:UIControlEventAllEvents];
    fechaTextfield.inputView=datePicker;
}
-(void)checkIfSaved{
    FileSaver *file=[[FileSaver alloc]init];
    
    
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];

        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;
        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            noRegistroTextfield.text=[masterDic objectForKey:@"NoRegistro"];
            requerimientosTextfield.text=[masterDic objectForKey:@"Requerimientos"];
            observacionTextfield.text=[masterDic objectForKey:@"Observacion"];
            grupoTextfield.text=[masterDic objectForKey:@"Grupo"];
            fechaTextfield.text=[masterDic objectForKey:@"Fecha"];
            unidadQueCreaTextfield.text=[masterDic objectForKey:@"UnidadQueCrea"];

            impactadaImpactosTextField.text=[masterDic objectForKey:@"NoImpactos"];
            impactadaDeptoTextField.text=[masterDic objectForKey:@"Depto"];
            impactadaMunicipioTextField.text=[masterDic objectForKey:@"Municipio"];
            impactadaArmamentoTextField.text=[masterDic objectForKey:@"Armamento"];
            impactadaNoVueloTextField.text=[masterDic objectForKey:@"NoVuelo"];
            impactadaFaseTextField.text=[masterDic objectForKey:@"Fase"];
            impactadaLatitud1TextField.text=[masterDic objectForKey:@"Latitud1"];
            impactadaLatitud2TextField.text=[masterDic objectForKey:@"Latitud2"];
            impactadaLatitud3TextField.text=[masterDic objectForKey:@"Latitud3"];
            impactadaLatitud4TextField.text=[masterDic objectForKey:@"Latitud4"];
            impactadaLongitud1TextField.text=[masterDic objectForKey:@"Longitud1"];
            impactadaLongitud2TextField.text=[masterDic objectForKey:@"Longitud2"];
            impactadaLongitud3TextField.text=[masterDic objectForKey:@"Longitud3"];
            impactadaLongitud4TextField.text=[masterDic objectForKey:@"Longitud4"];
            if ([[masterDic objectForKey:@"VueloNacionalSwitch"] isEqualToString:@"off"]) {
                [vueloNacionalSwitch setOn:NO];
                [self tipoDeVuelo:vueloNacionalSwitch];
            }
            if ([[masterDic objectForKey:@"ImpactadaSwitch"] isEqualToString:@"on"]) {
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
                
                cell.segundosEncendido=[[dic objectForKey:@"HoraEncendido"] intValue];
                cell.segundosApagado=[[dic objectForKey:@"HoraApagado"]intValue];
                cell.segundosDecolaje=[[dic objectForKey:@"HoraDecolaje"]intValue];
                cell.segundosAterrizaje=[[dic objectForKey:@"HoraAterrizaje"]intValue];
                
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
                if ([[dic objectForKey:@"CheckDefensa"]isEqualToString:@"on"]) {
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
                cell.coordenadaTextField.text=[dic objectForKey:@"Coordenada"];
                cell.departamentoTextfield.text=[dic objectForKey:@"Departamento"];
                cell.enemigoTextField.text=[dic objectForKey:@"Enemigo"];
            }
        }
    }
}
-(void)checkIfTripulacionSavedWithCell:(CeldaTripulacion*)cell atIndex:(int)i{
    FileSaver *file=[[FileSaver alloc]init];
    if ([file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad]) {
        //NSDictionary *masterDic=[file getDictionary:@"registroDeVuelo"];
        NSDictionary *masterDic=[file getDictionary:ordenDeVuelo.principal.idConsecutivoUnidad];        if (![[masterDic objectForKey:@"NoOrden"] isEqualToString:ordenDeVuelo.principal.idConsecutivoUnidad])return;

        if ([[masterDic objectForKey:@"Done"]isEqualToString:@"NO"]) {
            NSArray *array=[masterDic objectForKey:@"ArregloTripulacion"];
            NSDictionary *dic=[array objectAtIndex:i];
            cell.cargoTextField.text=[dic objectForKey:@"Cargo"];
            cell.nombreTextiField.text=[dic objectForKey:@"Nombre"];
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
        }
    }
}
- (void)didReceiveMemoryWarning
{
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
    UIColor *colorHilight=[UIColor blueColor];
    switch (numeroDeBoton) {
        case 1:
            [botonItinerario setBackgroundColor:colorHilight];
            [botonCondiciones setBackgroundColor:colorNormal];
            [botonArmamento setBackgroundColor:colorNormal];
            [botonTripulacion setBackgroundColor:colorNormal];
            [botonItinerario setHighlighted:YES];
            [botonCondiciones setHighlighted:NO];
            [botonArmamento setHighlighted:NO];
            [botonTripulacion setHighlighted:NO];
            break;
        case 2:
            [botonItinerario setBackgroundColor:colorNormal];
            [botonCondiciones setBackgroundColor:colorHilight];
            [botonArmamento setBackgroundColor:colorNormal];
            [botonTripulacion setBackgroundColor:colorNormal];
            [botonItinerario setHighlighted:NO];
            [botonCondiciones setHighlighted:YES];
            [botonArmamento setHighlighted:NO];
            [botonTripulacion setHighlighted:NO];
            break;
        case 3:
            [botonItinerario setBackgroundColor:colorNormal];
            [botonCondiciones setBackgroundColor:colorNormal];
            [botonArmamento setBackgroundColor:colorHilight];
            [botonTripulacion setBackgroundColor:colorNormal];
            [botonItinerario setHighlighted:NO];
            [botonCondiciones setHighlighted:NO];
            [botonArmamento setHighlighted:YES];
            [botonTripulacion setHighlighted:NO];
            break;
        case 4:
            [botonItinerario setBackgroundColor:colorNormal];
            [botonCondiciones setBackgroundColor:colorNormal];
            [botonArmamento setBackgroundColor:colorNormal];
            [botonTripulacion setBackgroundColor:colorHilight];
            [botonItinerario setHighlighted:NO];
            [botonCondiciones setHighlighted:NO];
            [botonArmamento setHighlighted:NO];
            [botonTripulacion setHighlighted:YES];
            break;
            
        default:
            break;
    }
    
    
}
#pragma mark - creacion de paginas
-(void)crearPaginas{
    int numeroPaginas=4;
    [pageScrollView setPagingEnabled:YES];
    pageScrollView.delegate=self;
    pageScrollView.contentSize=CGSizeMake(pageScrollView.frame.size.width*numeroPaginas, pageScrollView.frame.size.height);
    [pageScrollView setShowsHorizontalScrollIndicator:NO];
    
    [self crearPaginaItinerario];
    [self crearPaginaCondiciones];
    [self crearPaginaArmamentoPiernas];
    [self crearPaginaTripulacion];
    [self crearFilasDeItinerarioYCondiciones];
    
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
        CeldaTripulacion *celdaEntrenamiento=[[CeldaTripulacion alloc]initEntrenamientoWithFrame:CGRectMake(500, 33+33*k, 0, 0)];
        [paginaTripulacion addSubview:celdaEntrenamiento];
        [arregloEntrenamiento addObject:celdaEntrenamiento];
        [self checkIfEntrenamientoSavedWithCell:celdaEntrenamiento atIndex:k];
    }
}
#pragma mark - procedimientos compartidos entre páginas
////// las 3 primeras páginas están relacionadas entre sí.
////// dependiendo del número de piernas la cantidad de filas aumenta,
////// y en armamento se afecta el # de pags
-(void)crearFilasDeItinerarioYCondiciones{
    int i=0;
    float posFinalY=0;
    for (Piernas *pierna in ordenDeVuelo.arregloDePiernas) {
        CeldaItinerario *cell=[[CeldaItinerario alloc]initWithFrame:CGRectMake(0, 33+33*i, 0,0) andDelegate:nil];
        cell.noVuelo.text=pierna.piernaNumero;
        cell.de.text=pierna.de;
        cell.a.text=pierna.a;
        [self checkIfItinerarioSavedWithCell:cell atIndex:i];
        //NSLog(@"Hora encendido omex %@",cell.horaEncendido.text);
        [paginaItinerario addSubview:cell];
        [arregloParaSumarItinerario addObject:cell];
        
        CeldaCondiciones *cond=[[CeldaCondiciones alloc]initWithFrame:CGRectMake(0, 33+33*i, 0,0) andDelegate:nil];
        cond.entidadTextfield.text=pierna.entidad;
        [self checkIfCondicionesSavedWithCell:cond atIndex:i];
        [paginaCondicionesDeVuelo addSubview:cond];
        [arregloParaSumarCondiciones addObject:cond];
        
        VistaListadoArmamento *vistaArmamentos=[[VistaListadoArmamento alloc]initWithFrame:CGRectMake(0, paginaArmamentoPierna.frame.size.height*i, 0, 0)];
        paginaArmamentoPierna.contentSize=CGSizeMake(paginaArmamentoPierna.frame.size.width, (paginaArmamentoPierna.frame.size.height+paginaArmamentoPierna.frame.size.height*i)+1);
        [self checkIfArmamentoSavedWithCell:vistaArmamentos atIndex:i];
        vistaArmamentos.noVuelo.text=[NSString stringWithFormat:@"Vuelo No.: %@",cell.noVuelo.text];
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
    float roundedValue = round(pageScrollView.contentOffset.x / frame.size.height);
    [self seleccionarBoton:roundedValue+1];
}
#pragma mark - picker delegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==2000) {
        return arrayFaseVuelo.count;
    }
    else if (pickerView.tag==2001){
        return arrayDepartamentos.count;
    }
    else if (pickerView.tag==2002){
        return arrayMunicipios.count;
    }
    else if (pickerView.tag==2003){
        return arrayArmamentos.count;
    }
    else if (pickerView.tag==2004){
        return arrayLatitud.count;
    }
    else if (pickerView.tag==2005){
        return arrayLongitud.count;
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
        FaseVuelo *result=[arrayFaseVuelo objectAtIndex:row];
        NSString *strRes=result.faseVuelo;
        return strRes;
        }
        else if (pickerView.tag==2001){
            Departamentos *result=[arrayDepartamentos objectAtIndex:row];
            NSString *strRes=result.departamento;
            return strRes;
        }
        else if (pickerView.tag==2003){
            Armamentos *result=[arrayArmamentos objectAtIndex:row];
            NSString *strRes=result.armamento;
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
    }
    else{
        return nil;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        if (pickerView.tag==2000) {
            FaseVuelo *result=[arrayFaseVuelo objectAtIndex:row];
            NSString *strRes=result.faseVuelo;
            impactadaFaseTextField.text=strRes;
            return;
        }
        else if (pickerView.tag==2001){
            Departamentos *result=[arrayDepartamentos objectAtIndex:row];
            NSString *strRes=result.departamento;
            impactadaDeptoTextField.text=strRes;
            return;
        }
        else if (pickerView.tag==2003){
            Armamentos *result=[arrayArmamentos objectAtIndex:row];
            NSString *strRes=result.armamento;
            impactadaArmamentoTextField.text=strRes;
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
        else if (pickerView.tag==2002){
            
        }
    }
    return;
    
}
#pragma mark - guardar
-(IBAction)guardarRegistro{
    NSMutableDictionary *masterDic=[[NSMutableDictionary alloc]init];
    if(noRegistroTextfield.text){[masterDic setObject:noRegistroTextfield.text forKey:@"NoRegistro"];}
    if(requerimientosTextfield.text){[masterDic setObject:requerimientosTextfield.text forKey:@"Requerimientos"];}
    if(observacionTextfield.text){[masterDic setObject:observacionTextfield.text forKey:@"Observacion"];}
    if(grupoTextfield.text){[masterDic setObject:grupoTextfield.text forKey:@"Grupo"];}
    if(fechaTextfield.text){[masterDic setObject:fechaTextfield.text forKey:@"Fecha"];}
    if(unidadQueCreaTextfield.text){[masterDic setObject:unidadQueCreaTextfield.text forKey:@"UnidadQueCrea"];}
    if(impactadaImpactosTextField.text){[masterDic setObject:impactadaImpactosTextField.text forKey:@"NoImpactos"];}
    if(impactadaDeptoTextField.text){[masterDic setObject:impactadaDeptoTextField.text forKey:@"Depto"];}
    if(impactadaMunicipioTextField.text){[masterDic setObject:impactadaMunicipioTextField.text forKey:@"Municipio"];}
    if(impactadaArmamentoTextField.text){[masterDic setObject:impactadaArmamentoTextField.text forKey:@"Armamento"];}
    if(impactadaNoVueloTextField.text){[masterDic setObject:impactadaNoVueloTextField.text forKey:@"NoVuelo"];}
    if(impactadaFaseTextField.text){[masterDic setObject:impactadaFaseTextField.text forKey:@"Fase"];}
    if(impactadaLatitud1TextField.text){[masterDic setObject:impactadaLatitud1TextField.text forKey:@"Latitud1"];}
    if(impactadaLatitud2TextField.text){[masterDic setObject:impactadaLatitud2TextField.text forKey:@"Latitud2"];}
    if(impactadaLatitud3TextField.text){[masterDic setObject:impactadaLatitud3TextField.text forKey:@"Latitud3"];}
    if(impactadaLatitud4TextField.text){[masterDic setObject:impactadaLatitud4TextField.text forKey:@"Latitud4"];}
    if(impactadaLongitud1TextField.text){[masterDic setObject:impactadaLongitud1TextField.text forKey:@"Longitud1"];}
    if(impactadaLongitud2TextField.text){[masterDic setObject:impactadaLongitud2TextField.text forKey:@"Longitud2"];}
    if(impactadaLongitud3TextField.text){[masterDic setObject:impactadaLongitud3TextField.text forKey:@"Longitud3"];}
    if(impactadaLongitud4TextField.text){[masterDic setObject:impactadaLongitud4TextField.text forKey:@"Longitud4"];}
    if(vueloNacionalSwitch.on){[masterDic setObject:@"on" forKey:@"VueloNacionalSwitch"];}
    else{[masterDic setObject:@"off" forKey:@"VueloNacionalSwitch"];}
    if(aeronaveImpactadaSwitch.on){[masterDic setObject:@"on" forKey:@"ImpactadaSwitch"];}
    else{[masterDic setObject:@"off" forKey:@"ImpactadaSwitch"];}
    NSMutableArray *itinerarioArray=[[NSMutableArray alloc]init];
    for (CeldaItinerario *cell in arregloParaSumarItinerario) {
        NSMutableDictionary *itinerarioDic=[[NSMutableDictionary alloc]init];
        
        if(cell.noVuelo.text){[itinerarioDic setObject:cell.noVuelo.text forKey:@"NoVuelo"];}
        if(cell.de.text){[itinerarioDic setObject:cell.de.text forKey:@"De"];}
        if(cell.a.text){[itinerarioDic setObject:cell.a.text forKey:@"A"];}
        if(cell.segundosEncendido){[itinerarioDic setObject:[NSString stringWithFormat:@"%f",cell.segundosEncendido] forKey:@"HoraEncendido"];}
        if(cell.segundosApagado){[itinerarioDic setObject:[NSString stringWithFormat:@"%f",cell.segundosApagado] forKey:@"HoraApagado"];}
        if(cell.segundosDecolaje){[itinerarioDic setObject:[NSString stringWithFormat:@"%f",cell.segundosDecolaje] forKey:@"HoraDecolaje"];}
        if(cell.segundosAterrizaje){[itinerarioDic setObject:[NSString stringWithFormat:@"%f",cell.segundosAterrizaje] forKey:@"HoraAterrizaje"];}
        
        if(cell.horaEncendidoOverlay.text){[itinerarioDic setObject:cell.horaEncendidoOverlay.text forKey:@"HoraEncendidoOverlay"];}
        if(cell.horaApagadoOverlay.text){[itinerarioDic setObject:cell.horaApagadoOverlay.text forKey:@"HoraApagadoOverlay"];}
        if(cell.horaDecolajeOverlay.text){[itinerarioDic setObject:cell.horaDecolajeOverlay.text forKey:@"HoraDecolajeOverlay"];}
        if(cell.horaAterrizajeOverlay.text){[itinerarioDic setObject:cell.horaAterrizajeOverlay.text forKey:@"HoraAterrizajeOverlay"];}
        
        if(cell.tipoOperacion.text){[itinerarioDic setObject:cell.tipoOperacion.text forKey:@"TipoOperacion"];}
        if(cell.plan.text){[itinerarioDic setObject:cell.plan.text forKey:@"Plan"];}
        if(cell.operacion.text){[itinerarioDic setObject:cell.operacion.text forKey:@"Operacion"];}
        if(cell.checkDefensa.isOn){[itinerarioDic setObject:@"on" forKey:@"CheckDefensa"];}
        else{[itinerarioDic setObject:@"off" forKey:@"CheckDefensa"];}
        [itinerarioArray addObject:itinerarioDic];
    }
    [masterDic setObject:itinerarioArray forKey:@"ArregloItinerario"];
    
    NSMutableArray *condicionesArray=[[NSMutableArray alloc]init];
    for (CeldaCondiciones *cell in arregloParaSumarCondiciones) {
        NSMutableDictionary *condicionesDic=[[NSMutableDictionary alloc]init];
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
        [condicionesArray addObject:condicionesDic];
    }
    [masterDic setObject:condicionesArray forKey:@"ArregloCondiciones"];
    
    NSMutableArray *armamentoArray=[[NSMutableArray alloc]init];
    for (VistaListadoArmamento *pag in arregloPaginasArmamento) {
        NSMutableArray *arregloCeldasArmamento=[[NSMutableArray alloc]init];
        for (CeldaArmamento *cell in pag.arregloDeFilasArmamento) {
            NSMutableDictionary *diccionarioCeldasArmamento=[[NSMutableDictionary alloc]init];
            if (cell.armamentoTextField.text) {[diccionarioCeldasArmamento setObject:cell.armamentoTextField.text forKey:@"Armamento"];}
            if (cell.cantidadTextiField.text) {[diccionarioCeldasArmamento setObject:cell.cantidadTextiField.text forKey:@"Cantidad"];}
            if (cell.cantidadFallidoTextField.text) {[diccionarioCeldasArmamento setObject:cell.cantidadFallidoTextField.text forKey:@"CantidadFallido"];}
            if (cell.objetivoTextField.text) {[diccionarioCeldasArmamento setObject:cell.objetivoTextField.text forKey:@"Objetivo"];}
            if (cell.coordenadaTextField.text) {[diccionarioCeldasArmamento setObject:cell.coordenadaTextField.text forKey:@"Coordenada"];}
            if (cell.departamentoTextfield.text) {[diccionarioCeldasArmamento setObject:cell.departamentoTextfield.text forKey:@"Departamento"];}
            if (cell.enemigoTextField.text) {[diccionarioCeldasArmamento setObject:cell.enemigoTextField.text forKey:@"Enemigo"];}
            [arregloCeldasArmamento addObject:diccionarioCeldasArmamento];
        }
        [armamentoArray addObject:arregloCeldasArmamento];
    }
    [masterDic setObject:armamentoArray forKey:@"ArregloArmamento"];
    
    NSMutableArray *tripulacionArray=[[NSMutableArray alloc]init];
    for (CeldaTripulacion *cell in arregloTripulacion) {
        NSMutableDictionary *tripulacionDic=[[NSMutableDictionary alloc]init];
        if (cell.cargoTextField.text) {[tripulacionDic setObject:cell.cargoTextField.text forKey:@"Cargo"];}
        if (cell.nombreTextiField.text) {[tripulacionDic setObject:cell.nombreTextiField.text forKey:@"Nombre"];}
        if (cell.codigoTextField.text) {[tripulacionDic setObject:cell.codigoTextField.text forKey:@"Codigo"];}
        if (cell.gradoTextField.text) {[tripulacionDic setObject:cell.gradoTextField.text forKey:@"Grado"];}
        [tripulacionArray addObject:tripulacionDic];
    }
    [masterDic setObject:tripulacionArray forKey:@"ArregloTripulacion"];
    
    NSMutableArray *entrenamientoArray=[[NSMutableArray alloc]init];
    for (CeldaTripulacion *cell in arregloEntrenamiento) {
        NSMutableDictionary *entrenamientoDic=[[NSMutableDictionary alloc]init];
        if (cell.maniobraTextField.text) {[entrenamientoDic setObject:cell.maniobraTextField.text forKey:@"Maniobra"];}
        if (cell.cantidadTextfield.text) {[entrenamientoDic setObject:cell.cantidadTextfield.text forKey:@"Cantidad"];}

        [entrenamientoArray addObject:entrenamientoDic];
    }
    [masterDic setObject:entrenamientoArray forKey:@"ArregloEntrenamiento"];
    
    [masterDic setObject:@"NO" forKey:@"Done"];
    [masterDic setObject:ordenDeVuelo.principal.idConsecutivoUnidad forKey:@"NoOrden"];

    FileSaver *file=[[FileSaver alloc]init];
    [file setDictionary:masterDic withName:ordenDeVuelo.principal.idConsecutivoUnidad];
    [self.navigationController popViewControllerAnimated:YES];
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
@end
