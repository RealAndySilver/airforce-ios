//
//  MisionCumplidaViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 13/04/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import "MisionCumplidaViewController.h"

@interface MisionCumplidaViewController ()

@end

@implementation MisionCumplidaViewController

@synthesize ordenDeVuelo,lista;
- (void)viewDidLoad{
    [super viewDidLoad];
    [self initializeDictionaries];
    [self initializeArrays];
    
    pathForSave = @"mc"/*ordenDeVuelo.principal.idConsecutivoUnidad*/;
    
    numbersArray = [[NSMutableArray alloc]init];
    for (int i=0; i<101; i++) {
        [numbersArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    [self populateWithOrdenDeVuelo];
    [self setAllPickers];
    [self crearPaginas];
    [self seleccionarBoton:1];
    
    [self initializeOutlets];
    [self loadDataIntoOutlets];
    [self totalPaxYCarga];

}
- (void)viewWillAppear:(BOOL)animated{
    [self.view setBounds: CGRectMake(0, -20, 1024, 748)];
    [self setOverlayLabel];
    UITapGestureRecognizer *tapDismisser=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callForeignDismisser)];
    [self.view addGestureRecognizer:tapDismisser];
    [pageScrollView addGestureRecognizer:tapDismisser];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data inits
- (void)initializeDictionaries{
    masterDictionary = [[NSMutableDictionary alloc]init];
    informeDictionary = [[NSMutableDictionary alloc]init];
    infoGeneralDictionary = [[NSMutableDictionary alloc]init];
    paxCargaDictionary = [[NSMutableDictionary alloc]init];
    resultadosDictionary = [[NSMutableDictionary alloc]init];
    motivosDictionary = [[NSMutableDictionary alloc]init];
    
    [masterDictionary setObject:informeDictionary forKey:@"paginaInforme"];
    [masterDictionary setObject:infoGeneralDictionary forKey:@"paginaInfoGeneral"];
    [masterDictionary setObject:paxCargaDictionary forKey:@"paginaPaxCargaArmamento"];
    [masterDictionary setObject:informeDictionary forKey:@"paginaResultados"];
    [masterDictionary setObject:informeDictionary forKey:@"paginaMotivos"];
}
- (void)initializeArrays{
    sumaCargaArray = [[NSMutableArray alloc]init];
    sumaPaxArray = [[NSMutableArray alloc]init];
    porcentajeArray = [[NSMutableArray alloc]init];
}

#pragma mark - outlets init
- (void)initializeOutlets{
     [consecutivoTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [unidadAsumeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [unidadCreaTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [fechaDigitadoTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [registroVueloTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [fechaTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [horaTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [ovTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [aeronaveUnoTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [aeronaveDosTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [hDecolajeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [hAterrizajeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [horaBlancoTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [firmaTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [itinerarioTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    fechaDigitadoTF.inputView = datePicker;
    fechaTF.inputView = fechaCompletaPicker;
    horaTF.inputView = hourPicker;
    hDecolajeTF.inputView = hourPicker;
    hAterrizajeTF.inputView = hourPicker;
    horaBlancoTF.inputView = hourPicker;

}
- (void)loadDataIntoOutlets{
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *masterDic=[file getDictionary:pathForSave];
    NSDictionary * cabezeraDic = [masterDic objectForKey:@"GeneralCabezera"];
    
    consecutivoTF.text = [cabezeraDic objectForKey:@"ConsecutivoUnidad"];
    unidadAsumeTF.text = [cabezeraDic objectForKey:@"UnidadAsume"];
    unidadAsumeTF.tag = [[cabezeraDic objectForKey:@"IdUnidadAsume"] intValue];
    
    unidadCreaTF.text = [cabezeraDic objectForKey:@"UnidadCrea"];
    unidadCreaTF.tag = [[cabezeraDic objectForKey:@"IdUnidadCrea"] intValue];
    
    
    NSString *fechaDigitado = [cabezeraDic objectForKey:@"FechaDigitado"];
    if(!fechaDigitado.length){
        fechaDigitadoTF.text = [self getNowDate];
    }
    else{
        fechaDigitadoTF.text = [cabezeraDic objectForKey:@"FechaDigitado"];
    }

    registroVueloTF.text = [cabezeraDic objectForKey:@"IdRegistroVuelo"];
    
    fechaTF.text = [cabezeraDic objectForKey:@"HoraOrden"];
    
    ovTF.text = [cabezeraDic objectForKey:@"OrdenVuelo"];
    ovTF.tag = [[cabezeraDic objectForKey:@"IdOrdenVuelo"] intValue];

    aeronaveUnoTF.text = [cabezeraDic objectForKey:@"AeronaveUno"];
    aeronaveUnoTF.tag = [[cabezeraDic objectForKey:@"IdAeronave"] intValue];

    aeronaveDosTF.text = [cabezeraDic objectForKey:@"AeronaveDos"];

    hDecolajeTF.text = [cabezeraDic objectForKey:@"HoraDecolaje"];

    hAterrizajeTF.text = [cabezeraDic objectForKey:@"HoraAterrizaje"];
    
    horaBlancoTF.text = [cabezeraDic objectForKey:@"HoraBlanco"];
    
    firmaTF.text = [cabezeraDic objectForKey:@"Firma"];
    firmaTF.tag = [[cabezeraDic objectForKey:@"IdPiloto"] intValue];

    itinerarioTF.text = [cabezeraDic objectForKey:@"Itinerario"];
}

#pragma mark - populate outlets con orden de vuelo
- (void)populateWithOrdenDeVuelo{
    consecutivoTF.text = ordenDeVuelo.principal.idConsecutivoUnidad;
    ovTF.text = ordenDeVuelo.principal.idConsecutivoUnidad;
    unidadCreaTF.text = ordenDeVuelo.principal.unidad;
    unidadAsumeTF.text = ordenDeVuelo.principal.unidadAsume;
    aeronaveUnoTF.text = ordenDeVuelo.principal.matricula;
    aeronaveDosTF.text = ordenDeVuelo.principal.equipo;
    fechaTF.text = ordenDeVuelo.principal.fecha;
    itinerarioTF.text = ordenDeVuelo.principal.itinerario;
}

#pragma mark - set pickers
- (void)setAllPickers{
    pickerNumeros=[[UIPickerView alloc]init];
    pickerNumeros.dataSource=self;
    pickerNumeros.delegate=self;
    pickerNumeros.showsSelectionIndicator = YES;
    pickerNumeros.tag=2000;
    
    pickerConvenio=[[UIPickerView alloc]init];
    pickerConvenio.dataSource=self;
    pickerConvenio.delegate=self;
    pickerConvenio.showsSelectionIndicator = YES;
    pickerConvenio.tag=2001;
    
    pickerEntidad=[[UIPickerView alloc]init];
    pickerEntidad.dataSource=self;
    pickerEntidad.delegate=self;
    pickerEntidad.showsSelectionIndicator = YES;
    pickerEntidad.tag=2002;
    
    pickerMotivos=[[UIPickerView alloc]init];
    pickerMotivos.dataSource=self;
    pickerMotivos.delegate=self;
    pickerMotivos.showsSelectionIndicator = YES;
    pickerMotivos.tag=2003;
    
    pickerResultadosInmediatos=[[UIPickerView alloc]init];
    pickerResultadosInmediatos.dataSource=self;
    pickerResultadosInmediatos.delegate=self;
    pickerResultadosInmediatos.showsSelectionIndicator = YES;
    pickerResultadosInmediatos.tag=2004;
    
    pickerRetardo=[[UIPickerView alloc]init];
    pickerRetardo.dataSource=self;
    pickerRetardo.delegate=self;
    pickerRetardo.showsSelectionIndicator = YES;
    pickerRetardo.tag=2005;
    
    pickerTipoOperacion=[[UIPickerView alloc]init];
    pickerTipoOperacion.dataSource=self;
    pickerTipoOperacion.delegate=self;
    pickerTipoOperacion.showsSelectionIndicator = YES;
    pickerTipoOperacion.tag=2006;
    
    pickerTipoPax=[[UIPickerView alloc]init];
    pickerTipoPax.dataSource=self;
    pickerTipoPax.delegate=self;
    pickerTipoPax.showsSelectionIndicator = YES;
    pickerTipoPax.tag=2007;
    
    
    
    fechaCompletaPicker=[[UIDatePicker alloc]init];
    fechaCompletaPicker.tag = 5000;
    fechaCompletaPicker.datePickerMode = UIDatePickerModeDateAndTime;
    [fechaCompletaPicker addTarget:self action:@selector(displayDate:) forControlEvents:UIControlEventAllEvents];
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.tag = 5001;
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(displayDate:) forControlEvents:UIControlEventAllEvents];
    
    hourPicker=[[UIDatePicker alloc]init];
    hourPicker.tag = 5002;
    hourPicker.datePickerMode = UIDatePickerModeTime;
    [hourPicker addTarget:self action:@selector(displayDate:) forControlEvents:UIControlEventAllEvents];
}

#pragma mark - set pickers
- (void)setOverlayLabel{
    overlayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    [overlayLabel setBackgroundColor:[UIColor whiteColor]];
    overlayLabel.center = CGPointMake(self.view.bounds.size.width/2, 800);
    overlayLabel.text=@"Hola mundo";
    overlayLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    overlayLabel.textAlignment = NSTextAlignmentCenter;
    overlayLabel.alpha=0;
    overlayLabel.layer.borderWidth = 2;
    overlayLabel.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:overlayLabel];
}

#pragma mark - ibactions
- (IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
//    FileSaver *file=[[FileSaver alloc]init];
//    NSMutableDictionary *masterDic=[[NSMutableDictionary alloc]init];
//    [masterDic setObject:@"YES" forKey:@"Done"];
//    [file setDictionary:masterDic withName:ordenDeVuelo.principal.idConsecutivoUnidad];
}
- (IBAction)informe:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 0, 0.0f) animated:YES];
    [self seleccionarBoton:1];
}
- (IBAction)informacion:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 1, 0.0f) animated:YES];
    [self seleccionarBoton:2];
}
- (IBAction)paxCargaArmamento:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 2, 0.0f) animated:YES];
    [self seleccionarBoton:3];
}
- (IBAction)resultados:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 3, 0.0f) animated:YES];
    [self seleccionarBoton:4];
}
- (IBAction)motivosRetardo:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 4, 0.0f) animated:YES];
    [self seleccionarBoton:5];
}

#pragma mark - hilight method
- (void)seleccionarBoton:(int)numeroDeBoton{
    UIColor *colorNormal=[UIColor grayColor];
    UIColor *colorHilight=[UIColor colorWithRed:0 green:0 blue:0.3 alpha:1];
    [self callForeignDismisser];
    switch (numeroDeBoton) {
        case 1:
            [botonInforme setBackgroundColor:colorHilight];
            [botonInformacion setBackgroundColor:colorNormal];
            [botonPaxArmamento setBackgroundColor:colorNormal];
            [botonResultados setBackgroundColor:colorNormal];
            [botonMotivosRetardo setBackgroundColor:colorNormal];
            [botonInforme setHighlighted:YES];
            [botonInformacion setHighlighted:NO];
            [botonPaxArmamento setHighlighted:NO];
            [botonResultados setHighlighted:NO];
            [botonMotivosRetardo setHighlighted:NO];
            break;
        case 2:
            [botonInforme setBackgroundColor:colorNormal];
            [botonInformacion setBackgroundColor:colorHilight];
            [botonPaxArmamento setBackgroundColor:colorNormal];
            [botonResultados setBackgroundColor:colorNormal];
            [botonMotivosRetardo setBackgroundColor:colorNormal];
            [botonInforme setHighlighted:NO];
            [botonInformacion setHighlighted:YES];
            [botonPaxArmamento setHighlighted:NO];
            [botonResultados setHighlighted:NO];
            [botonMotivosRetardo setHighlighted:NO];
            break;
        case 3:
            [botonInforme setBackgroundColor:colorNormal];
            [botonInformacion setBackgroundColor:colorNormal];
            [botonPaxArmamento setBackgroundColor:colorHilight];
            [botonResultados setBackgroundColor:colorNormal];
            [botonMotivosRetardo setBackgroundColor:colorNormal];
            [botonInforme setHighlighted:NO];
            [botonInformacion setHighlighted:NO];
            [botonPaxArmamento setHighlighted:YES];
            [botonResultados setHighlighted:NO];
            [botonMotivosRetardo setHighlighted:NO];
            break;
        case 4:
            [botonInforme setBackgroundColor:colorNormal];
            [botonInformacion setBackgroundColor:colorNormal];
            [botonPaxArmamento setBackgroundColor:colorNormal];
            [botonResultados setBackgroundColor:colorHilight];
            [botonMotivosRetardo setBackgroundColor:colorNormal];
            [botonInforme setHighlighted:NO];
            [botonInformacion setHighlighted:NO];
            [botonPaxArmamento setHighlighted:NO];
            [botonResultados setHighlighted:YES];
            [botonMotivosRetardo setHighlighted:NO];
            break;
            
        case 5:
            [botonInforme setBackgroundColor:colorNormal];
            [botonInformacion setBackgroundColor:colorNormal];
            [botonPaxArmamento setBackgroundColor:colorNormal];
            [botonResultados setBackgroundColor:colorNormal];
            [botonMotivosRetardo setBackgroundColor:colorHilight];
            [botonInforme setHighlighted:NO];
            [botonInformacion setHighlighted:NO];
            [botonPaxArmamento setHighlighted:NO];
            [botonResultados setHighlighted:NO];
            [botonMotivosRetardo setHighlighted:YES];
            break;
    
        default:
            break;
    }
    
    
}

#pragma mark - creacion de paginas
- (void)crearPaginas{
    int numeroPaginas=5;
    [pageScrollView setPagingEnabled:YES];
    pageScrollView.delegate=self;
    pageScrollView.contentSize=CGSizeMake(pageScrollView.frame.size.width*numeroPaginas, pageScrollView.frame.size.height);
    [pageScrollView setShowsHorizontalScrollIndicator:NO];
    
    [self crearPaginaInforme];
    [self crearPaginaInformacion];
    [self crearPaginaPax];
    [self crearPaginaResultados];
    [self crearPaginaMotivos];
    
}
- (void)crearPaginaInforme{
    
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *masterDic=[file getDictionary:pathForSave];
    
    paginaInforme=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*0, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height-50)];
    paginaInforme.contentSize=CGSizeMake(paginaInforme.frame.size.width, paginaInforme.frame.size.height+1);
    paginaInforme.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *tapDismisser=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callForeignDismisser)];
    [self.view addGestureRecognizer:tapDismisser];
    [pageScrollView addSubview:paginaInforme];
    int marginLeft = 30;
    int labelWidth = 200;
    int labelHeight = 40;
    int marginTop = 70;
    int threshold = 40;
    int tvWidth = 700;
    int tvHeight = marginTop-5;
    int distanceForTV = 200;
    
    UILabel *descripcionLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, marginTop-threshold, labelWidth, labelHeight)];
    [descripcionLabel setText:@"Descripción:"];
    [descripcionLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInforme addSubview:descripcionLabel];
    descripcionTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, marginTop-threshold-(tvHeight/4), tvWidth, tvHeight)];
    descripcionTV.layer.borderWidth = 1;
    descripcionTV.layer.borderColor = [[UIColor grayColor] CGColor];
    descripcionTV.delegate = self;
    descripcionTV.text = [[masterDic objectForKey:@"Informe"] objectForKey:@"Descripcion"];
    [paginaInforme addSubview:descripcionTV];
    
    
    UILabel *recomendacionesLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, (marginTop*2)-threshold, labelWidth, labelHeight)];
    [recomendacionesLabel setText:@"Recomendaciones:"];
    [recomendacionesLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInforme addSubview:recomendacionesLabel];
    recomendacionesTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, (marginTop*2)-threshold-(tvHeight/4), tvWidth, tvHeight)];
    recomendacionesTV.layer.borderWidth = 1;
    recomendacionesTV.layer.borderColor = [[UIColor grayColor] CGColor];
    recomendacionesTV.delegate = self;
    recomendacionesTV.text = [[masterDic objectForKey:@"Informe"] objectForKey:@"Recomendaciones"];
    [paginaInforme addSubview:recomendacionesTV];
    
    UILabel *resultadosLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, (marginTop*3)-threshold, labelWidth, labelHeight)];
    [resultadosLabel setText:@"Resultados:"];
    [resultadosLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInforme addSubview:resultadosLabel];
    resultadosTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, (marginTop*3)-threshold-(tvHeight/4), tvWidth, tvHeight)];
    resultadosTV.layer.borderWidth = 1;
    resultadosTV.layer.borderColor = [[UIColor grayColor] CGColor];
    resultadosTV.delegate = self;
    resultadosTV.text = [[masterDic objectForKey:@"Informe"] objectForKey:@"Resultados"];
    [paginaInforme addSubview:resultadosTV];
    
    UILabel *observacionesLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, (marginTop*4)-threshold, labelWidth, labelHeight)];
    [observacionesLabel setText:@"Observaciones:"];
    [observacionesLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInforme addSubview:observacionesLabel];
    observacionesTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, (marginTop*4)-threshold-(tvHeight/4), tvWidth, tvHeight)];
    observacionesTV.layer.borderWidth = 1;
    observacionesTV.layer.borderColor = [[UIColor grayColor] CGColor];
    observacionesTV.delegate = self;
    observacionesTV.text = [[masterDic objectForKey:@"Informe"] objectForKey:@"Observaciones"];
    [paginaInforme addSubview:observacionesTV];
    
    UILabel *noSerieVideoLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, (marginTop*5)-threshold, labelWidth, labelHeight)];
    [noSerieVideoLabel setText:@"No. Serie Video:"];
    [noSerieVideoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInforme addSubview:noSerieVideoLabel];
    noSerieVideoTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, (marginTop*5)-threshold, tvWidth, tvHeight/2)];
    noSerieVideoTV.layer.borderWidth = 1;
    noSerieVideoTV.layer.borderColor = [[UIColor grayColor] CGColor];
    noSerieVideoTV.delegate = self;
    noSerieVideoTV.text = [[masterDic objectForKey:@"Informe"] objectForKey:@"NoSerieVideo"];
    [paginaInforme addSubview:noSerieVideoTV];
    
}
- (void)crearPaginaInformacion{
    
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *masterDic=[file getDictionary:pathForSave];
    
    paginaInformacion=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*1, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    paginaInformacion.contentSize=CGSizeMake(paginaInformacion.frame.size.width, paginaInformacion.frame.size.height+1);
    paginaInformacion.backgroundColor=[UIColor clearColor];
    [pageScrollView addSubview:paginaInformacion];
    
    int marginLeft = 30;
    int labelWidth = 200;
    int labelHeight = 40;
    int marginTop = 100;
    int threshold = 40;
    int tvWidth = 500;
    int tvHeight = marginTop-5;
    int distanceForTV = 150;
    
    UILabel *instruccionesLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, marginTop-threshold, labelWidth, labelHeight)];
    [instruccionesLabel setText:@"Instrucciones:"];
    [instruccionesLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInformacion addSubview:instruccionesLabel];
    instruccionesTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, marginTop-threshold-(tvHeight/4), tvWidth, tvHeight)];
    instruccionesTV.layer.borderWidth = 1;
    instruccionesTV.layer.borderColor = [[UIColor grayColor] CGColor];
    instruccionesTV.delegate = self;
    instruccionesTV.text = [[masterDic objectForKey:@"InformacionGeneral"] objectForKey:@"Instrucciones"];

    [paginaInformacion addSubview:instruccionesTV];
    
    UILabel *escoltaVIPLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV+instruccionesTV.frame.size.width+20, marginTop-threshold-20, labelWidth, labelHeight)];
    [escoltaVIPLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    [escoltaVIPLabel setText:@"Escolta VIP:"];
    [paginaInformacion addSubview:escoltaVIPLabel];
    
    UILabel *transitoVIPLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV+instruccionesTV.frame.size.width+20, marginTop-threshold+20, labelWidth, labelHeight)];
    [transitoVIPLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    [transitoVIPLabel setText:@"Tránsito VIP:"];
    [paginaInformacion addSubview:transitoVIPLabel];
    
    escoltaVIPSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV+instruccionesTV.frame.size.width+90, marginTop-threshold-20, labelWidth, labelHeight)];
    [escoltaVIPSwitch setOn:NO];
    [paginaInformacion addSubview:escoltaVIPSwitch];
    
    transporteVIPSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV+instruccionesTV.frame.size.width+90, marginTop-threshold+20, labelWidth, labelHeight)];
    [transporteVIPSwitch setOn:NO];
    [paginaInformacion addSubview:transporteVIPSwitch];
    
    //Seter para el switch de escolta
    NSString *stringForEscolta = [[masterDic objectForKey:@"InformacionGeneral"] objectForKey:@"EscoVip"];
    if([stringForEscolta isEqualToString:@"S"]){
        [escoltaVIPSwitch setOn:YES];
    }
    else{
        [escoltaVIPSwitch setOn:NO];
    }
    
    //Seter para el switch de tránsito
    NSString *stringForTransito = [[masterDic objectForKey:@"InformacionGeneral"] objectForKey:@"TransVip"];
    if([stringForTransito isEqualToString:@"S"]){
        [transporteVIPSwitch setOn:YES];
    }
    else{
        [transporteVIPSwitch setOn:NO];
    }
    
    //Cabecera Table View
    UILabel *entidadLabel = [[UILabel alloc]initWithFrame:CGRectMake( 100, 230, 80, 20)];
    entidadLabel.text = @"Entidad";
    [entidadLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *requerimientoLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 230, 80, 20)];
    requerimientoLabel.text = @"Requerimiento";
    [requerimientoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *operacionLabel = [[UILabel alloc]initWithFrame:CGRectMake(440, 230, 80, 20)];
    operacionLabel.text = @"Operacion ";
    [operacionLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *operacionTipoLabel = [[UILabel alloc]initWithFrame:CGRectMake(600, 230, 80, 20)];
    operacionTipoLabel.text = @"O. Tipo";
    [operacionTipoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *planTipoLabel = [[UILabel alloc]initWithFrame:CGRectMake(770, 230, 80, 20)];
    planTipoLabel.text = @"Plan";
    [planTipoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    
    [paginaInformacion addSubview:entidadLabel];
    [paginaInformacion addSubview:requerimientoLabel];
    [paginaInformacion addSubview:operacionLabel];
    [paginaInformacion addSubview:operacionTipoLabel];
    [paginaInformacion addSubview:planTipoLabel];
    
    //Table view custom
    UIScrollView *tVScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(50, 260, 830, 150)];
    tVScroll.backgroundColor = [UIColor clearColor];
    tVScroll.contentSize=CGSizeMake(280, 260);
    tVScroll.showsVerticalScrollIndicator = YES;
    [paginaInformacion addSubview:tVScroll];
    int marginLeftForTV = 10;
    int tfHeight = 30;
    int tfWidthLarge = 160;
    marginLeft +=15;
    
    
    NSArray *infoGeneralFileArray = [[masterDic objectForKey:@"InformacionGeneral"] objectForKey:@"InstruccionesMision"];

    NSMutableArray *infoGeneralArray = [[NSMutableArray alloc]init];
    
    for(int i=0;i<8;i++){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        
        UITextField *entidadTF = [self crearTextField:marginLeftForTV y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [entidadTF setUserInteractionEnabled:NO];
        
        UITextField *requerimientoTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*1)+2 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [requerimientoTF setUserInteractionEnabled:NO];

        UITextField *operacionTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*2)+4 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [operacionTF setUserInteractionEnabled:NO];

        UITextField *operacionTipoTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*3)+6 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [operacionTipoTF setUserInteractionEnabled:NO];
        //operacionTipoTF.inputView = pickerTipoOperacion;
        
        UITextField *planTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*4)+8 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [planTF setUserInteractionEnabled:NO];

        
        if(infoGeneralFileArray.count >i){
            NSDictionary *tempDic = infoGeneralFileArray[i];
            
            entidadTF.text = [[tempDic objectForKey:@"entidad"] objectForKey:@"text"] ? [[tempDic objectForKey:@"entidad"] objectForKey:@"text"]:@"";
            entidadTF.tag = [[tempDic objectForKey:@"entidad"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"entidad"] objectForKey:@"id"] intValue]:0;
            
            requerimientoTF.text = [[tempDic objectForKey:@"requerimiento"] objectForKey:@"text"] ? [[tempDic objectForKey:@"requerimiento"] objectForKey:@"text"]:@"";
            requerimientoTF.tag = [[tempDic objectForKey:@"requerimiento"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"requerimiento"] objectForKey:@"id"] intValue]:0;
            
            operacionTF.text = [[tempDic objectForKey:@"operacion"] objectForKey:@"text"] ? [[tempDic objectForKey:@"operacion"] objectForKey:@"text"]:@"";
            operacionTF.tag = [[tempDic objectForKey:@"operacion"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"operacion"] objectForKey:@"id"] intValue]:0;

            operacionTipoTF.text = [[tempDic objectForKey:@"operacionTipo"] objectForKey:@"text"] ? [[tempDic objectForKey:@"operacionTipo"] objectForKey:@"text"]:@"";
            operacionTipoTF.tag = [[tempDic objectForKey:@"operacionTipo"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"operacionTipo"] objectForKey:@"id"] intValue]:0;

            planTF.text = [[tempDic objectForKey:@"plan"] objectForKey:@"text"] ? [[tempDic objectForKey:@"plan"] objectForKey:@"text"]:@"";
            planTF.tag = [[tempDic objectForKey:@"plan"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"plan"] objectForKey:@"id"] intValue]:0;
        }
        
        
        [dictionary setObject:entidadTF forKey:@"entidad"];
        [dictionary setObject:requerimientoTF forKey:@"requerimiento"];
        [dictionary setObject:operacionTF forKey:@"operacion"];
        [dictionary setObject:operacionTipoTF forKey:@"operacionTipo"];
        [dictionary setObject:planTF forKey:@"plan"];
        
        [infoGeneralArray addObject:dictionary];

    }
    [infoGeneralDictionary setObject:infoGeneralArray forKey:@"instruccionesMision"];
}
- (void)crearPaginaPax{
    int maxNumberOfCells = 8;
    
    paginaPaxArmamento=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*2, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    [paginaPaxArmamento setPagingEnabled:YES];
    [paginaPaxArmamento setShowsVerticalScrollIndicator:NO];
    paginaPaxArmamento.backgroundColor=[UIColor clearColor];
    paginaPaxArmamento.contentSize=CGSizeMake(paginaPaxArmamento.frame.size.width, paginaPaxArmamento.frame.size.height+1);
    [pageScrollView addSubview:paginaPaxArmamento];
    
    //Cabecera de las tablas
    UILabel *tipoPaxLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, 80, 20)];
    tipoPaxLabel.text = @"Tipo PAX";
    [tipoPaxLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *entidadPaxLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 25, 80, 20)];
    entidadPaxLabel.text = @"Entidad";
    [entidadPaxLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *cantidadPaxLabel = [[UILabel alloc]initWithFrame:CGRectMake(423, 25, 80, 20)];
    cantidadPaxLabel.text = @"Cantidad";
    [cantidadPaxLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    
    UILabel *cantidadCargaLabel = [[UILabel alloc]initWithFrame:CGRectMake(610, 25, 80, 20)];
    cantidadCargaLabel.text = @"Cantidad";
    [cantidadCargaLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *entidadCargaLabel = [[UILabel alloc]initWithFrame:CGRectMake(700, 25, 80, 20)];
    entidadCargaLabel.text = @"Entidad";
    [entidadCargaLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    
    UILabel *tipoArmamentoLabel = [[UILabel alloc]initWithFrame:CGRectMake(330, 230, 80, 20)];
    tipoArmamentoLabel.text = @"Tipo";
    [tipoArmamentoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *cantitadArmamentoLabel = [[UILabel alloc]initWithFrame:CGRectMake(630, 230, 80, 20)];
    cantitadArmamentoLabel.text = @"Cantidad";
    [cantitadArmamentoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *cantidadFallidoArmamentoLabel = [[UILabel alloc]initWithFrame:CGRectMake(698, 230, 80, 20)];
    cantidadFallidoArmamentoLabel.text = @"Cantidad Fallido";
    [cantidadFallidoArmamentoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    UILabel *efectividadArmamentoLabel = [[UILabel alloc]initWithFrame:CGRectMake(785, 230, 80, 20)];
    efectividadArmamentoLabel.text = @"%Efectividad";
    [efectividadArmamentoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    
    [paginaPaxArmamento addSubview:tipoPaxLabel];
    [paginaPaxArmamento addSubview:entidadPaxLabel];
    [paginaPaxArmamento addSubview:cantidadPaxLabel];
    
    [paginaPaxArmamento addSubview:cantidadCargaLabel];
    [paginaPaxArmamento addSubview:entidadCargaLabel];
    
    [paginaPaxArmamento addSubview:tipoArmamentoLabel];
    [paginaPaxArmamento addSubview:cantitadArmamentoLabel];
    [paginaPaxArmamento addSubview:cantidadFallidoArmamentoLabel];
    [paginaPaxArmamento addSubview:efectividadArmamentoLabel];
    //Fin de cabecera
    
    UIScrollView *paxScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(50, 50, 460, 100)];
    paxScroll.backgroundColor = [UIColor clearColor];
    paxScroll.contentSize=CGSizeMake(455, 250);
    paxScroll.showsVerticalScrollIndicator = YES;
    [paxScroll flashScrollIndicators];
    [paginaPaxArmamento addSubview:paxScroll];
    
    int marginLeft = 5;
    int marginTop = 1;
    int tfHeight = 30;
    int tfWidthShort = 80;
    int tfWidthLarge = 180;
    
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *masterDic=[file getDictionary:pathForSave];
    
    NSArray *paxFileArray = [[masterDic objectForKey:@"PaxCargaArmamento"] objectForKey:@"PAX"];
    
    NSMutableArray *paxArray = [[NSMutableArray alloc]init];
    for(int i=0; i<maxNumberOfCells; i++){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        UITextField *tipoPax = [self crearTextField:marginLeft y:marginTop+(tfHeight*i)+i width:tfWidthLarge height:tfHeight InView:paxScroll];
        tipoPax.inputView = pickerTipoPax;
        UITextField *entidadPax = [self crearTextField:marginLeft+(tfWidthLarge)+2 y:marginTop+(tfHeight*i)+i width:tfWidthLarge height:tfHeight InView:paxScroll];
        entidadPax.inputView = pickerEntidad;
        UITextField *cantidadPax = [self crearTextField:marginLeft+(tfWidthLarge*2)+4 y:marginTop+(tfHeight*i)+i width:tfWidthShort height:tfHeight InView:paxScroll];
        [cantidadPax setTag:-1000];
        cantidadPax.inputView = pickerNumeros;
        cantidadPax.textAlignment = NSTextAlignmentCenter;
        
        
        if(paxFileArray.count >i){
            NSDictionary *tempDic = paxFileArray[i];
            tipoPax.text = [[tempDic objectForKey:@"tipoPax"] objectForKey:@"text"] ? [[tempDic objectForKey:@"tipoPax"] objectForKey:@"text"]:@"";
            tipoPax.tag = [[tempDic objectForKey:@"tipoPax"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"tipoPax"] objectForKey:@"id"] intValue]:0;
            
            entidadPax.text = [[tempDic objectForKey:@"entidadPax"] objectForKey:@"text"] ? [[tempDic objectForKey:@"entidadPax"] objectForKey:@"text"]:@"";
            entidadPax.tag = [[tempDic objectForKey:@"entidadPax"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"entidadPax"] objectForKey:@"id"] intValue]:0;
            
            cantidadPax.text =[[tempDic objectForKey:@"cantidad"] objectForKey:@"text"] ? [[tempDic objectForKey:@"cantidad"] objectForKey:@"text"]:@"";
        }
        
        [dictionary setObject:tipoPax forKey:@"tipoPax"];
        [dictionary setObject:entidadPax forKey:@"entidadPax"];
        [dictionary setObject:cantidadPax forKey:@"cantidadPax"];
        
        [paxArray addObject:dictionary];
        [sumaPaxArray addObject:cantidadPax];
        paxScroll.contentSize=CGSizeMake(280, (marginTop+tfHeight)+((marginTop+tfHeight)*i));
    }
    [paxCargaDictionary setObject:paxArray forKey:@"pax"];
    
    totalPaxTF = [self crearTextField:420 y:155 width:80 height:30 InView:paginaPaxArmamento];
    totalPaxTF.userInteractionEnabled = NO;
    totalPaxTF.textAlignment = NSTextAlignmentCenter;
    UILabel *totalPaxLabel = [[UILabel alloc]initWithFrame:CGRectMake(320, 155, 80, 30)];
    totalPaxLabel.text = @"Total PAX";
    [paginaPaxArmamento addSubview:totalPaxLabel];
    UILabel *paxLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 80, 30)];
    paxLabel.text = @"PAX";
    [paginaPaxArmamento addSubview:paxLabel];
    
    
    UIScrollView *cargaScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(600, 50, 280, 100)];
    cargaScroll.backgroundColor = [UIColor clearColor];
    cargaScroll.contentSize=CGSizeMake(280, 250);
    cargaScroll.showsVerticalScrollIndicator = YES;
    [cargaScroll flashScrollIndicators];
    [paginaPaxArmamento addSubview:cargaScroll];
    
    NSArray *cargaFileArray = [[masterDic objectForKey:@"PaxCargaArmamento"] objectForKey:@"Carga"];
    
    NSMutableArray *cargaArray = [[NSMutableArray alloc]init];
    for(int i=0; i<maxNumberOfCells; i++){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        UITextField *cantidadCarga = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*i)+i width:tfWidthShort height:tfHeight InView:cargaScroll];
        cantidadCarga.textAlignment = NSTextAlignmentCenter;
        cantidadCarga.inputView = pickerNumeros;
        [cantidadCarga setTag:-1000];
        UITextField *entidadCarga = [self crearTextField:marginLeft+(tfWidthShort)+4 y:marginTop+(tfHeight*i)+i width:tfWidthLarge height:tfHeight InView:cargaScroll];
        entidadCarga.inputView = pickerEntidad;
        
        if(cargaFileArray.count >i){
            NSDictionary *tempDic = cargaFileArray[i];
            entidadCarga.text = [[tempDic objectForKey:@"entidadCarga"] objectForKey:@"text"] ? [[tempDic objectForKey:@"entidadCarga"] objectForKey:@"text"]:@"";
            entidadCarga.tag = [[tempDic objectForKey:@"entidadCarga"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"entidadCarga"] objectForKey:@"id"] intValue]:0;
            cantidadCarga.text =[[tempDic objectForKey:@"cantidad"] objectForKey:@"text"] ? [[tempDic objectForKey:@"cantidad"] objectForKey:@"text"]:@"";
        }
        
        
        [dictionary setObject:entidadCarga forKey:@"entidadCarga"];
        [dictionary setObject:cantidadCarga forKey:@"cantidadCarga"];
        
        [cargaArray addObject:dictionary];
        [sumaCargaArray addObject:cantidadCarga];
        cargaScroll.contentSize=CGSizeMake(280, (marginTop+tfHeight)+((marginTop+tfHeight)*i));
    }
    [paxCargaDictionary setObject:cargaArray forKey:@"carga"];
    
    totalCargaTF = [self crearTextField:607 y:155 width:80 height:30 InView:paginaPaxArmamento];
    totalCargaTF.userInteractionEnabled = NO;
    totalCargaTF.textAlignment = NSTextAlignmentCenter;
    UILabel *totalCargaLabel = [[UILabel alloc]initWithFrame:CGRectMake(710, 155, 100, 30)];
    totalCargaLabel.text = @"Total Carga";
    [paginaPaxArmamento addSubview:totalCargaLabel];
    UILabel *cargaLabel = [[UILabel alloc]initWithFrame:CGRectMake(605, 0, 80, 30)];
    cargaLabel.text = @"Carga";
    [paginaPaxArmamento addSubview:cargaLabel];
    
    
    
    UILabel *armamentoLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 205, 120, 30)];
    armamentoLabel.text = @"Armamento";
    [paginaPaxArmamento addSubview:armamentoLabel];
    
    UIScrollView *armamentoScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(50, 250, 830, 150)];
    armamentoScroll.backgroundColor = [UIColor clearColor];
    armamentoScroll.contentSize=CGSizeMake(280, 250);
    armamentoScroll.showsVerticalScrollIndicator = YES;
    [armamentoScroll flashScrollIndicators];
    [paginaPaxArmamento addSubview:armamentoScroll];
    
    marginLeft +=15;
    
    NSArray *armamentoFileArray = [[masterDic objectForKey:@"PaxCargaArmamento"] objectForKey:@"Armamento"];
    
    NSMutableArray *armamentoArray = [[NSMutableArray alloc]init];
    for(int i=0; i<maxNumberOfCells; i++){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        NSMutableDictionary *percentDictionary = [[NSMutableDictionary alloc]init];

        UITextField *tipoArmamento = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*i)+i width:tfWidthLarge*3 height:tfHeight InView:armamentoScroll];
        UITextField *cantidadArmamento = [self crearTextField:marginLeft+4+(tfWidthLarge*3) y:marginTop+(tfHeight*i)+i width:tfWidthShort height:tfHeight InView:armamentoScroll];
        cantidadArmamento.textAlignment = NSTextAlignmentCenter;
        cantidadArmamento.inputView = pickerNumeros;
        [cantidadArmamento setTag:-2000-i];

        UITextField *cantidadFallidoArmamento = [self crearTextField:marginLeft+6+(tfWidthLarge*3+tfWidthShort) y:marginTop+(tfHeight*i)+i width:tfWidthShort height:tfHeight InView:armamentoScroll];
        cantidadFallidoArmamento.textAlignment = NSTextAlignmentCenter;
        cantidadFallidoArmamento.inputView = pickerNumeros;
        [cantidadFallidoArmamento setTag:-2500-i];
        
        UITextField *efectividadArmamento = [self crearTextField:marginLeft+8+(tfWidthLarge*3+tfWidthShort*2) y:marginTop+(tfHeight*i)+i width:tfWidthShort height:tfHeight InView:armamentoScroll];
        efectividadArmamento.textAlignment = NSTextAlignmentCenter;
        efectividadArmamento.inputView = pickerNumeros;
        [efectividadArmamento setTag:-3000-i];
        [efectividadArmamento setUserInteractionEnabled:NO];
        
        
        if(armamentoFileArray.count >i){
            NSDictionary *tempDic = armamentoFileArray[i];
            tipoArmamento.text = [[tempDic objectForKey:@"tipoArmamento"] objectForKey:@"text"] ? [[tempDic objectForKey:@"tipoArmamento"] objectForKey:@"text"]:@"";
            tipoArmamento.tag = [[tempDic objectForKey:@"tipoArmamento"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"tipoArmamento"] objectForKey:@"id"] intValue]:0;
            
            cantidadArmamento.text =[[tempDic objectForKey:@"cantidadArmamento"] objectForKey:@"text"] ? [[tempDic objectForKey:@"cantidadArmamento"] objectForKey:@"text"]:@"";
            cantidadFallidoArmamento.text =[[tempDic objectForKey:@"cantidadFallidoArmamento"] objectForKey:@"text"] ? [[tempDic objectForKey:@"cantidadFallidoArmamento"] objectForKey:@"text"]:@"";
            efectividadArmamento.text =[[tempDic objectForKey:@"efectividadArmamento"] objectForKey:@"text"] ? [[tempDic objectForKey:@"efectividadArmamento"] objectForKey:@"text"]:@"";
        }
        
        [dictionary setObject:tipoArmamento forKey:@"tipoArmamento"];
        [dictionary setObject:cantidadArmamento forKey:@"cantidadArmamento"];
        [dictionary setObject:cantidadFallidoArmamento forKey:@"cantidadFallidoArmamento"];
        [dictionary setObject:efectividadArmamento forKey:@"efectividadArmamento"];
        
        [percentDictionary setObject:cantidadArmamento forKey:@"cantidadArmamento"];
        [percentDictionary setObject:cantidadFallidoArmamento forKey:@"cantidadFallidoArmamento"];
        [percentDictionary setObject:efectividadArmamento forKey:@"efectividadArmamento"];
        
        [porcentajeArray addObject:percentDictionary];
        
        [armamentoArray addObject:dictionary];
        
        armamentoScroll.contentSize=CGSizeMake(280, (marginTop+tfHeight)+((marginTop+tfHeight)*i));
    }
    [paxCargaDictionary setObject:armamentoArray forKey:@"armamento"];
    
}
- (void)crearPaginaResultados{
    paginaResultados=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*3, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    paginaResultados.backgroundColor=[UIColor clearColor];
    paginaResultados.contentSize=CGSizeMake(paginaResultados.frame.size.width, paginaResultados.frame.size.height+1);
    [pageScrollView addSubview:paginaResultados];
    
    //Table view custom top left
    UILabel *tipoOperacionLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, 130, 20)];
    tipoOperacionLabel.text = @"Tipo Operación";
    [tipoOperacionLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [paginaResultados addSubview:tipoOperacionLabel];
    
    UIScrollView *tipoOperacionScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(50, 50, 300, 130)];
    tipoOperacionScroll.backgroundColor = [UIColor clearColor];
    tipoOperacionScroll.contentSize=CGSizeMake(280, 260);
    tipoOperacionScroll.showsVerticalScrollIndicator = YES;
    [paginaResultados addSubview:tipoOperacionScroll];
    int tfHeight = 30;
    int tfWidthLarge = 280;
    
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *masterDic=[file getDictionary:pathForSave];
    NSArray *tipoFileArray = [[masterDic objectForKey:@"Resultados"] objectForKey:@"TipoOperacion"];
    NSMutableArray *tipoOperacionArray = [[NSMutableArray alloc]init];
    
    for(int i=0;i<8;i++){
        UITextField *TF = [self crearTextField:10 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tipoOperacionScroll];
        TF.inputView = pickerTipoOperacion;
        if(tipoFileArray.count >i){
            NSDictionary *tempDic = tipoFileArray[i];
            TF.text = [tempDic objectForKey:@"text"];
            TF.tag =[[tempDic objectForKey:@"id"] intValue];
        }
        [tipoOperacionArray addObject:TF];
    }
    [resultadosDictionary setObject:tipoOperacionArray forKey:@"tipoOperacion"];
    
    
    //Table view custom bottom left
    UILabel *convenioLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 200, 130, 20)];
    convenioLabel.text = @"Convenio";
    [convenioLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [paginaResultados addSubview:convenioLabel];
    
    UIScrollView *convenioScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(50, 220, 300, 130)];
    convenioScroll.backgroundColor = [UIColor clearColor];
    convenioScroll.contentSize=CGSizeMake(280, 260);
    convenioScroll.showsVerticalScrollIndicator = YES;
    [paginaResultados addSubview:convenioScroll];
    
    
    NSArray *convenioFileArray = [[masterDic objectForKey:@"Resultados"] objectForKey:@"Convenio"];
    NSMutableArray *convenioArray = [[NSMutableArray alloc]init];
    for(int i=0;i<8;i++){
        UITextField *TF = [self crearTextField:10 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:convenioScroll];
        TF.inputView = pickerConvenio;
        if(convenioFileArray.count >i){
            NSDictionary *tempDic = convenioFileArray[i];
            TF.text = [tempDic objectForKey:@"text"];
            TF.tag =[[tempDic objectForKey:@"id"] intValue];
        }
        [convenioArray addObject:TF];
    }
    [resultadosDictionary setObject:convenioArray forKey:@"convenio"];
    
    //Table view custom top right
    UILabel *motivosIncumplimientoLabel = [[UILabel alloc]initWithFrame:CGRectMake(420, 25, 180, 20)];
    motivosIncumplimientoLabel.text = @"Motivos Incumplimiento";
    [motivosIncumplimientoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [paginaResultados addSubview:motivosIncumplimientoLabel];
    
    UIScrollView *motivosIncumplimientoScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(410, 50, 500, 130)];
    motivosIncumplimientoScroll.backgroundColor = [UIColor clearColor];
    motivosIncumplimientoScroll.contentSize=CGSizeMake(280, 260);
    motivosIncumplimientoScroll.showsVerticalScrollIndicator = YES;
    [paginaResultados addSubview:motivosIncumplimientoScroll];
    
    NSArray *motivosIncumplimientoFileArray = [[masterDic objectForKey:@"Resultados"] objectForKey:@"MotivosIncumplimiento"];
    NSMutableArray *motivosIncumplimientoArray = [[NSMutableArray alloc]init];
    for(int i=0;i<8;i++){
        UITextField *TF = [self crearTextField:10 y:(tfHeight*i)+(2*i) width:480 height:tfHeight InView:motivosIncumplimientoScroll];
        TF.inputView = pickerMotivos;
        if(motivosIncumplimientoFileArray.count >i){
            NSDictionary *tempDic = motivosIncumplimientoFileArray[i];
            TF.text = [tempDic objectForKey:@"text"];
            TF.tag =[[tempDic objectForKey:@"id"] intValue];
        }
        [motivosIncumplimientoArray addObject:TF];
    }
    [resultadosDictionary setObject:motivosIncumplimientoArray forKey:@"motivosIncumplimiento"];
    
    //Table view custom top right
    UILabel *resultadosInmediatosLabel = [[UILabel alloc]initWithFrame:CGRectMake(420, 200, 180, 20)];
    resultadosInmediatosLabel.text = @"Resultados Inmediatos";
    [resultadosInmediatosLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [paginaResultados addSubview:resultadosInmediatosLabel];
    
    UILabel *cantidadLabel = [[UILabel alloc]initWithFrame:CGRectMake(725, 200, 180, 20)];
    cantidadLabel.text = @"Cantidad";
    [cantidadLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [paginaResultados addSubview:cantidadLabel];
    
    UIScrollView *resultadosInmediatosScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(410, 220, 500, 130)];
    resultadosInmediatosScroll.backgroundColor = [UIColor clearColor];
    resultadosInmediatosScroll.contentSize=CGSizeMake(280, 260);
    resultadosInmediatosScroll.showsVerticalScrollIndicator = YES;
    [paginaResultados addSubview:resultadosInmediatosScroll];
    
    NSArray *resultadosInmediatosFileArray = [[masterDic objectForKey:@"Resultados"] objectForKey:@"ResultadosInmediatos"];
    NSMutableArray *resultadosInmediatosArray = [[NSMutableArray alloc]init];
    for(int i=0;i<8;i++){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        UITextField *resultadosTF = [self crearTextField:10 y:(tfHeight*i)+(2*i) width:300 height:tfHeight InView:resultadosInmediatosScroll];
        resultadosTF.inputView = pickerResultadosInmediatos;
        UITextField *cantidadTF = [self crearTextField:10+(300*1)+2 y:(tfHeight*i)+(2*i) width:180 height:tfHeight InView:resultadosInmediatosScroll];
        cantidadTF.textAlignment = NSTextAlignmentCenter;
        cantidadTF.inputView =pickerNumeros;
        
        if(resultadosInmediatosFileArray.count >i){
            NSDictionary *tempDic = resultadosInmediatosFileArray[i];
            resultadosTF.text = [[tempDic objectForKey:@"resultados"] objectForKey:@"text"] ? [[tempDic objectForKey:@"resultados"] objectForKey:@"text"]:@"";
            resultadosTF.tag = [[tempDic objectForKey:@"resultados"] objectForKey:@"id"] ? [[[tempDic objectForKey:@"resultados"] objectForKey:@"id"] intValue]:0;
            cantidadTF.text =[[tempDic objectForKey:@"cantidad"] objectForKey:@"text"] ? [[tempDic objectForKey:@"cantidad"] objectForKey:@"text"]:@"";
        }
        
        [dictionary setObject:resultadosTF forKey:@"resultados"];
        [dictionary setObject:cantidadTF forKey:@"cantidad"];
        [resultadosInmediatosArray addObject:dictionary];
    }
    [resultadosDictionary setObject:resultadosInmediatosArray forKey:@"resultadosInmediatos"];
    
    //Last Textfield
    UILabel *otrosResultadosLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 380, 180, 30)];
    [otrosResultadosLabel setText:@"Otros Resultados:"];
    [otrosResultadosLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
    [paginaResultados addSubview:otrosResultadosLabel];
    
    NSArray *otrosFileArray = [[masterDic objectForKey:@"Resultados"] objectForKey:@"OtrosResultados"];
    NSMutableArray *otrosResultadosArray = [[NSMutableArray alloc]init];
    UITextField *otrosResultadosTF = [self crearTextField:200 y:380 width:703 height:tfHeight InView:paginaResultados];
    if(otrosFileArray.count){
        otrosResultadosTF.text = otrosFileArray[0];
    }
    [otrosResultadosArray addObject:otrosResultadosTF];
    [resultadosDictionary setObject:otrosResultadosArray forKey:@"otrosResultados"];
    
}
- (void)crearPaginaMotivos{
    paginaMotivos=[[UIScrollView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*4, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    paginaMotivos.backgroundColor=[UIColor clearColor];
    paginaMotivos.contentSize=CGSizeMake(paginaMotivos.frame.size.width, paginaMotivos.frame.size.height+1);
    [pageScrollView addSubview:paginaMotivos];
    
    int initialMargin = 70;
    int marginTop = 32;
    int tfWidth = 400;
    int tfHeight = 30;
    int center = (paginaMotivos.frame.size.width/2)-(tfWidth/2);

    UILabel *retardoLabel = [[UILabel alloc]initWithFrame:CGRectMake(center, 30, 100, 30)];
    [retardoLabel setText:@"Retardo:"];
    [paginaMotivos addSubview:retardoLabel];
    
    NSMutableArray *motivosRetardoArray = [[NSMutableArray alloc]init];
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *masterDic=[file getDictionary:pathForSave];
    NSArray *motivosArray = [masterDic objectForKey:@"MotivosRetardo"];
    for(int i=0;i<8;i++){
        UITextField *TF = [self crearTextField:center y:(marginTop*(i+1))+initialMargin width:tfWidth height:tfHeight InView:paginaMotivos];
        TF.inputView = pickerRetardo;
        if(motivosArray.count >i){
            NSDictionary *tempDic = motivosArray[i];
            TF.text = [tempDic objectForKey:@"text"];
            TF.tag =[[tempDic objectForKey:@"id"] intValue];
        }
        [motivosRetardoArray addObject:TF];
    }
    file = nil;
    [motivosDictionary setObject:motivosRetardoArray forKey:@"motivosRetardo"];
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

#pragma mark - esconder keyboards
- (void)callForeignDismisser{
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"esconderPicker" object:nil];
    [currentTextField becomeFirstResponder];
    [currentTextField resignFirstResponder];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGRect frame=[[UIScreen mainScreen] applicationFrame];
    float roundedValue = round(pageScrollView.contentOffset.x / frame.size.width);
    [self seleccionarBoton:roundedValue+1];
    [self callForeignDismisser];
}

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTextField = textField;
    overlayLabel.text = currentTextField.text;
    if (currentTextField.inputView) {
        currentPicker = (UIPickerView*)currentTextField.inputView;
        [self animarView:overlayLabel Hasta:CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height/2)+118) conAlpha:1];
        if([currentTextField.inputView isKindOfClass:[UIDatePicker class]]){
            if(currentTextField.text.length>0){
            [(UIDatePicker *)currentPicker setDate:[self returnDateWithStringDate:currentTextField.text
                                               andStringFormat:[self getStringFormatFromDatePicker:(UIDatePicker *)currentPicker]] animated:YES];
            }
            return;
        }
        NSInteger index = 0;
        if (currentPicker.tag == 2000) {
            index=[numbersArray indexOfObject:currentTextField.text];
        }
        else if (currentPicker.tag == 2001) {
            index=[lista.arregloDeConvenios indexOfObject:currentTextField.text];
        }
        
        if(index != NSNotFound ){
            [currentPicker selectRow:index inComponent:0 animated:YES];
        }
        else{
            [currentPicker selectRow:0 inComponent:0 animated:YES];
        }
        
    }
    else{
        [self animarView:overlayLabel Hasta:CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height/2)-28) conAlpha:1];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self animarView:overlayLabel Hasta:CGPointMake(self.view.bounds.size.width/2, 800) conAlpha:0];
    overlayLabel.text = @"";
    if (currentTextField.inputView) {
        //Este caso es para los totales de pax y carga
        if (currentTextField.tag==-1000) {
            [self totalPaxYCarga];
        }
        else if (currentTextField.tag <=-2000 && currentTextField.tag >-3000) {
            if (currentTextField.tag <=-2000 && currentTextField.tag >-2500){
                [self porcentajeArmamentoConTag:currentTextField.tag menosDiferencia:2000];
            }
            else{
                [self porcentajeArmamentoConTag:currentTextField.tag menosDiferencia:2500];
            }
            
        }
    }
}
- (void)textFieldDidChange:(UITextField *)textField{
    overlayLabel.text = currentTextField.text;
}

#pragma mark - textview delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    currentTextField = (UITextField*)textView;
    overlayLabel.text = currentTextField.text;
    [self animarView:overlayLabel Hasta:CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height/2)-28) conAlpha:1];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self animarView:overlayLabel Hasta:CGPointMake(self.view.bounds.size.width/2, 800) conAlpha:0];
    overlayLabel.text = @"";
}
- (void)textViewDidChange:(UITextView *)textView{
    overlayLabel.text = currentTextField.text;
}

#pragma mark - helpers
- (void)totalPaxYCarga{
    int contadorPax =0;
    for (UITextField *textfield in sumaPaxArray){
        contadorPax += [textfield.text intValue];
    }
    totalPaxTF.text = [NSString stringWithFormat:@"%i",contadorPax];
    
    int contadorCarga =0;
    for (UITextField *textfield in sumaCargaArray){
        contadorCarga += [textfield.text intValue];
    }
    totalCargaTF.text = [NSString stringWithFormat:@"%i",contadorCarga];
}
- (void)porcentajeArmamentoConTag:(int)tag menosDiferencia:(int)diferencia{
    float contador =0;
    NSMutableDictionary *tempDic = porcentajeArray[abs(tag)-diferencia];
    UITextField *cantidadArmamentoTF = [tempDic objectForKey:@"cantidadArmamento"];
    UITextField *cantidadFallidoArmamentoTF = [tempDic objectForKey:@"cantidadFallidoArmamento"];
    UITextField *efectividadTF = [tempDic objectForKey:@"efectividadArmamento"];
    contador += (([cantidadFallidoArmamentoTF.text floatValue]*100)/[cantidadArmamentoTF.text floatValue]-100)*-1;
    efectividadTF.text = [NSString stringWithFormat:@"%% %.1f",contador];
}

#pragma mark - guardar
- (IBAction)guardarRegistro:(UIButton*)sender{
}

#pragma mark - date helpers
- (void)displayDate:(id)sender{
    UIDatePicker *tempPicker = sender;
    NSString *format = [self getStringFormatFromDatePicker:tempPicker];
    
    NSDate * selected = [tempPicker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];//HH:mm
    NSString *strDate = [formatter stringFromDate:selected];
    currentTextField.text = strDate;
    overlayLabel.text = currentTextField.text;
}
- (NSString*)getStringFormatFromDatePicker:(UIDatePicker*)picker{
    NSString *format = @"";
    if (picker.tag == 5000) {
        format = @"dd-MM-yyyy HH:mm";
    }
    else if (picker.tag == 5001){
        format = @"dd-MM-yyyy";
    }
    else if (picker.tag == 5002){
        format = @"HH:mm";
    }
    return format;
}
- (NSDate*)returnDateWithStringDate:(NSString*)date andStringFormat:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSDate *finalDate = [dateFormatter dateFromString:date];
    return finalDate;
}
- (NSString*)getNowDate{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    return dateString;
}
#pragma mark - server communication
- (void)sincronizarDataConServer:(NSString*)data{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=1;
    NSString *cipher=[IAmCoder encryptAndBase64:data withKey:[IAmCoder dateKey]];
    
    NSString *params=[NSString  stringWithFormat:@"<jsonEntrada>%@</jsonEntrada>",cipher];
    
    [server callServerWithMethod:@"MisionCumplida" andParameter:params];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"Enviando Registro";
}

#pragma mark - server response
- (void)receivedDataFromServer:(ServerCommunicator*)sender{
}
- (void)receivedDataFromServerWithError:(ServerCommunicator*)sender{
}

#pragma mark number check
- (BOOL)isAllDigitsFromArray:(NSArray*)array{
    for (NSString *string in array) {
        NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSRange r = [string rangeOfCharacterFromSet: nonNumbers];
        if (r.location != NSNotFound) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)isAllDigitsFromString:(NSString*)string{
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [string rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}
- (void)stopAlertWithFieldName:(NSString*)fieldName{
    NSString *titulo=@"Error";
    NSString *mensaje=[NSString stringWithFormat:@"Su registro no pudo ser enviado ya que contiene un elemento no numérico en el campo %@. Por favor verifique y vuelva a intentarlo.",fieldName];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)stopAlertWithSectionName:(NSString*)sectionName{
    NSString *titulo=@"Error";
    NSString *mensaje=[NSString stringWithFormat:@"Su registro no pudo ser enviado ya que contiene un elemento no numérico en la sección %@. Por favor verifique y vuelva a intentarlo.",sectionName];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - picker delegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 2000) {
        return numbersArray.count;
    }
    else if (pickerView.tag == 2001) {
        return lista.arregloDeConvenios.count;
    }
    else if (pickerView.tag == 2002) {
        return lista.arregloEntidadesPaxCarga.count;
    }
    else if (pickerView.tag == 2003) {
        return lista.arregloMotivosIncumplimiento.count;
    }
    else if (pickerView.tag == 2004) {
        return lista.arregloResultadosInmediatos.count;
    }
    else if (pickerView.tag == 2005) {
        return lista.arregloRetardos.count;
    }
    else if (pickerView.tag == 2006) {
        return lista.arregloTipoOperacionMision.count;
    }
    else if (pickerView.tag == 2007) {
        return lista.arregloTipoPax.count;
    }
    return 0;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 2000) {
        return [NSString stringWithFormat:@"%@",[numbersArray objectAtIndex:row]];
    }
    else if (pickerView.tag == 2001) {
        NSDictionary *dic = lista.arregloDeConvenios[row];
        return [NSString stringWithFormat:@"%@",[dic objectForKey:@"Descripcion"]];
    }
    else if (pickerView.tag == 2002) {
        NSDictionary *dic = lista.arregloEntidadesPaxCarga[row];
        return [NSString stringWithFormat:@"%@",[dic objectForKey:@"NombreOrganizacion"]];
    }
    else if (pickerView.tag == 2003) {
        NSDictionary *dic = lista.arregloMotivosIncumplimiento[row];
        return [NSString stringWithFormat:@"%@",[dic objectForKey:@"Descripcion"]];
    }
    else if (pickerView.tag == 2004) {
        NSDictionary *dic = lista.arregloResultadosInmediatos[row];
        return [NSString stringWithFormat:@"%@",[dic objectForKey:@"Descripcion"]];
    }
    else if (pickerView.tag == 2005) {
        NSDictionary *dic = lista.arregloRetardos[row];
        return [NSString stringWithFormat:@"%@",[dic objectForKey:@"Descripcion"]];
    }
    else if (pickerView.tag == 2006) {
        NSDictionary *dic = lista.arregloTipoOperacionMision[row];
        return [NSString stringWithFormat:@"%@",[dic objectForKey:@"DescripcionValorDefinicion"]];
    }
    else if (pickerView.tag == 2007) {
        NSDictionary *dic = lista.arregloTipoPax[row];
        return [NSString stringWithFormat:@"%@",[dic objectForKey:@"Descripcion"]];
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 2000) {
        currentTextField.text = [NSString stringWithFormat:@"%@",[numbersArray objectAtIndex:row]];
    }
    else if (pickerView.tag == 2001) {
        NSDictionary *dic = lista.arregloDeConvenios[row];
        currentTextField.text = [dic objectForKey:@"Descripcion"];
        currentTextField.tag = [dic objectForKey:@"IdConvenio"];
    }
    else if (pickerView.tag == 2002) {
        NSDictionary *dic = lista.arregloEntidadesPaxCarga[row];
        currentTextField.text = [dic objectForKey:@"NombreOrganizacion"];
        currentTextField.tag = [dic objectForKey:@"OrganizacionId"];
    }
    else if (pickerView.tag == 2003) {
        NSDictionary *dic = lista.arregloMotivosIncumplimiento[row];
        currentTextField.text = [dic objectForKey:@"Descripcion"];
        currentTextField.tag = [dic objectForKey:@"IdIncumplimiento"];
    }
    else if (pickerView.tag == 2004) {
        NSDictionary *dic = lista.arregloResultadosInmediatos[row];
        currentTextField.text = [dic objectForKey:@"Descripcion"];
        currentTextField.tag = [dic objectForKey:@"IdResultado"];
    }
    else if (pickerView.tag == 2005) {
        NSDictionary *dic = lista.arregloRetardos[row];
        currentTextField.text = [dic objectForKey:@"Descripcion"];
        currentTextField.tag = [dic objectForKey:@"IdRetardo"];
    }
    else if (pickerView.tag == 2006) {
        NSDictionary *dic = lista.arregloTipoOperacionMision[row];
        currentTextField.text = [dic objectForKey:@"DescripcionValorDefinicion"];
        currentTextField.tag = [dic objectForKey:@"ValorDefinicionId"];
    }
    else if (pickerView.tag == 2007) {
        NSDictionary *dic = lista.arregloTipoPax[row];
        currentTextField.text = [dic objectForKey:@"Descripcion"];
        currentTextField.tag = [dic objectForKey:@"IdTipoPax"];
    }
    overlayLabel.text = currentTextField.text;
    return;
}

#pragma mark - animaciones
-(void)animarView:(UIView*)view Hasta:(CGPoint)hasta conAlpha:(float)alpha{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.center=hasta;
    view.alpha = alpha;
    [UIView commitAnimations];
}

#pragma mark - guardar mision
-(IBAction)guardarMision:(UIButton*)sender{
    NSLog(@"Saving..");
    NSMutableDictionary *masterDic=[[NSMutableDictionary alloc]init];
    //////////////////////////////////////
    ////////General Cabezera//////////////
    //////////////////////////////////////
    NSMutableDictionary *generalCabezeraDic = [[NSMutableDictionary alloc]init];
    if(consecutivoTF.text){
        [generalCabezeraDic setObject:consecutivoTF.text forKey:@"ConsecutivoUnidad"];
    }
    if(unidadAsumeTF.text){
        [generalCabezeraDic setObject:unidadAsumeTF.text forKey:@"UnidadAsume"];
        [generalCabezeraDic setObject:[NSString stringWithFormat:@"%i",unidadAsumeTF.tag] forKey:@"IdUnidadAsume"];
    }
    if(unidadCreaTF.text){
        [generalCabezeraDic setObject:unidadCreaTF.text forKey:@"UnidadCrea"];
        [generalCabezeraDic setObject:[NSString stringWithFormat:@"%i",unidadCreaTF.tag] forKey:@"IdUnidadCrea"];
    }
    if(fechaDigitadoTF.text){
        [generalCabezeraDic setObject:fechaDigitadoTF.text forKey:@"FechaDigitado"];
    }
    if(registroVueloTF.text){
        [generalCabezeraDic setObject:registroVueloTF.text forKey:@"IdRegistroVuelo"];
    }
    if(fechaTF.text){
        [generalCabezeraDic setObject:fechaTF.text forKey:@"HoraOrden"];
    }
    if(ovTF.text){
        [generalCabezeraDic setObject:ovTF.text forKey:@"OrdenVuelo"];
        [generalCabezeraDic setObject:[NSString stringWithFormat:@"%i",ovTF.tag] forKey:@"IdOrdenVuelo"];
    }
    if(aeronaveUnoTF.text){
        [generalCabezeraDic setObject:aeronaveUnoTF.text forKey:@"AeronaveUno"];
        [generalCabezeraDic setObject:[NSString stringWithFormat:@"%i",aeronaveUnoTF.tag] forKey:@"IdAeronave"];
    }
    if(aeronaveDosTF.text){
        [generalCabezeraDic setObject:aeronaveDosTF.text forKey:@"AeronaveDos"];
    }
    if(hDecolajeTF.text){
        [generalCabezeraDic setObject:hDecolajeTF.text forKey:@"HoraDecolaje"];
    }
    if(hAterrizajeTF.text){
        [generalCabezeraDic setObject:hAterrizajeTF.text forKey:@"HoraAterrizaje"];
    }
    if(horaBlancoTF.text){
        [generalCabezeraDic setObject:horaBlancoTF.text forKey:@"HoraBlanco"];
    }
    if(firmaTF.text){
        [generalCabezeraDic setObject:firmaTF.text forKey:@"Firma"];
        [generalCabezeraDic setObject:[NSString stringWithFormat:@"%i",firmaTF.tag] forKey:@"IdPiloto"];
    }
    if(itinerarioTF.text){
        [generalCabezeraDic setObject:itinerarioTF.text forKey:@"Itinerario"];
    }
    //////////////////////////////////////
    ////////Fin General Cabezera//////////
    //////////////////////////////////////
    
    [masterDic setObject:generalCabezeraDic forKey:@"GeneralCabezera"];
    
    //////////////////////////////////////
    ////////Informe///////////////////////
    //////////////////////////////////////
    NSMutableDictionary *informeDic = [[NSMutableDictionary alloc]init];
    if(descripcionTV.text){[informeDic setObject:descripcionTV.text forKey:@"Descripcion"];}
    if(recomendacionesTV.text){[informeDic setObject:recomendacionesTV.text forKey:@"Recomendaciones"];}
    if(resultadosTV.text){[informeDic setObject:resultadosTV.text forKey:@"Resultados"];}
    if(observacionesTV.text){[informeDic setObject:observacionesTV.text forKey:@"Observaciones"];}
    if(noSerieVideoTV.text){[informeDic setObject:noSerieVideoTV.text forKey:@"NoSerieVideo"];}
    //////////////////////////////////////
    ////////Fin Informe///////////////////
    //////////////////////////////////////
    
    [masterDic setObject:informeDic forKey:@"Informe"];
    
    //////////////////////////////////////
    ////////Información General///////////
    //////////////////////////////////////
    //Instrucciones
    NSMutableDictionary *informaciongeneralDic = [[NSMutableDictionary alloc]init];
    if(instruccionesTV.text){[informaciongeneralDic setObject:instruccionesTV.text forKey:@"Instrucciones"];}
    
    //Switches
    if(escoltaVIPSwitch.on){
        [informaciongeneralDic setObject:@"S" forKey:@"EscoVip"];
    }
    else{
        [informaciongeneralDic setObject:@"N" forKey:@"EscoVip"];
    }
    if(transporteVIPSwitch.on){
        [informaciongeneralDic setObject:@"S" forKey:@"TransVip"];
    }
    else{
        [informaciongeneralDic setObject:@"N" forKey:@"TransVip"];
    }
    //Lista
    //NSMutableDictionary *instruccionesMisionDic = [[NSMutableDictionary alloc]init];
    NSArray *instruccionesMisionArray = [infoGeneralDictionary objectForKey:@"instruccionesMision"];
    NSMutableArray *instruccionesMisionSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<instruccionesMisionArray.count; i++){
        NSDictionary *masterTempDic = instruccionesMisionArray[i];
        UITextField *tempTF = [masterTempDic objectForKey:@"entidad"];
        UITextField *tempTF2 = [masterTempDic objectForKey:@"requerimiento"];
        UITextField *tempTF3 = [masterTempDic objectForKey:@"operacion"];
        UITextField *tempTF4 = [masterTempDic objectForKey:@"operacionTipo"];
        UITextField *tempTF5 = [masterTempDic objectForKey:@"plan"];

        NSMutableDictionary *singleDic = [[NSMutableDictionary alloc] init];
        if(tempTF.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"entidad"];
        }
        if(tempTF2.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF2.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF2.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"requerimiento"];
        }
        if(tempTF3.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF3.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF2.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"operacion"];
        }
        if(tempTF4.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF4.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF2.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"operacionTipo"];
        }
        if(tempTF5.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF5.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF2.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"plan"];
        }
        if(tempTF.text.length || tempTF2.text.length || tempTF3.text.length || tempTF4.text.length || tempTF5.text.length){
            [instruccionesMisionSave addObject:singleDic];
        }
    }
    [informaciongeneralDic setObject:instruccionesMisionSave forKey:@"InstruccionesMision"];
    //////////////////////////////////////
    ////////Fin Pax Carga Armamento///////
    //////////////////////////////////////
    [masterDic setObject:informaciongeneralDic forKey:@"InformacionGeneral"];

    
    //////////////////////////////////////
    ////////Pax Carga Armamento///////////
    //////////////////////////////////////
    //PAX
    NSMutableDictionary *paxCargaArmamentoDic = [[NSMutableDictionary alloc]init];
    NSArray *paxArray = [paxCargaDictionary objectForKey:@"pax"];
    NSMutableArray *paxSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<paxArray.count; i++){
        NSDictionary *masterTempDic = paxArray[i];
        UITextField *tempTF = [masterTempDic objectForKey:@"tipoPax"];
        UITextField *tempTF2 = [masterTempDic objectForKey:@"entidadPax"];
        UITextField *tempTF3 = [masterTempDic objectForKey:@"cantidadPax"];
        NSMutableDictionary *singleDic = [[NSMutableDictionary alloc] init];
        if(tempTF.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"tipoPax"];
        }
        if(tempTF2.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF2.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF2.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"entidadPax"];
        }
        if(tempTF3.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF3.text forKey:@"text"];
            [singleDic setObject:tempDic forKey:@"cantidad"];
        }
        if(tempTF.text.length || tempTF2.text.length || tempTF3.text.length){
            [paxSave addObject:singleDic];
        }
    }
    [paxCargaArmamentoDic setObject:paxSave forKey:@"PAX"];
    
    //CARGA
    NSArray *cargaArray = [paxCargaDictionary objectForKey:@"carga"];
    NSMutableArray *cargaSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<cargaArray.count; i++){
        NSDictionary *masterTempDic = cargaArray[i];
        UITextField *tempTF = [masterTempDic objectForKey:@"entidadCarga"];
        UITextField *tempTF2 = [masterTempDic objectForKey:@"cantidadCarga"];
        NSMutableDictionary *singleDic = [[NSMutableDictionary alloc] init];
        if(tempTF.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"entidadCarga"];
        }
        if(tempTF2.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF2.text forKey:@"text"];
            [singleDic setObject:tempDic forKey:@"cantidad"];
        }
        if(tempTF.text.length || tempTF2.text.length){
            [cargaSave addObject:singleDic];
        }
    }
    [paxCargaArmamentoDic setObject:cargaSave forKey:@"Carga"];
    
    //ARMAMENTO
    NSArray *armamentoArray = [paxCargaDictionary objectForKey:@"armamento"];
    NSMutableArray *armamentoSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<armamentoArray.count; i++){
        NSDictionary *masterTempDic = armamentoArray[i];
        UITextField *tempTF = [masterTempDic objectForKey:@"tipoArmamento"];
        UITextField *tempTF2 = [masterTempDic objectForKey:@"cantidadArmamento"];
        UITextField *tempTF3 = [masterTempDic objectForKey:@"cantidadFallidoArmamento"];
        UITextField *tempTF4 = [masterTempDic objectForKey:@"efectividadArmamento"];
        NSMutableDictionary *singleDic = [[NSMutableDictionary alloc] init];
        if(tempTF.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"tipoArmamento"];
        }
        if(tempTF2.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF2.text forKey:@"text"];
            [singleDic setObject:tempDic forKey:@"cantidadArmamento"];
        }
        if(tempTF3.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF3.text forKey:@"text"];
            [singleDic setObject:tempDic forKey:@"cantidadFallidoArmamento"];
        }
        if(tempTF4.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF4.text forKey:@"text"];
            [singleDic setObject:tempDic forKey:@"efectividadArmamento"];
        }
        if(tempTF.text.length || tempTF2.text.length || tempTF3.text.length || tempTF4.text.length){
            [armamentoSave addObject:singleDic];
        }
    }
    [paxCargaArmamentoDic setObject:armamentoSave forKey:@"Armamento"];
    //////////////////////////////////////
    ////////Fin Pax Carga Armamento///////
    //////////////////////////////////////
    
    [masterDic setObject:paxCargaArmamentoDic forKey:@"PaxCargaArmamento"];
    
    
    //////////////////////////////////////
    ////////Resultados////////////////////
    //////////////////////////////////////
    NSMutableDictionary *resultadosDic = [[NSMutableDictionary alloc]init];
    
    //TIPO OPERACION
    NSArray *tipoOperacion = [resultadosDictionary objectForKey:@"tipoOperacion"];
    NSMutableArray *tipoOperacionSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<tipoOperacion.count; i++){
        UITextField *tempTF = tipoOperacion[i];
        if(tempTF.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF.tag] forKey:@"id"];
            [tipoOperacionSave addObject:tempDic];
        }
    }
    [resultadosDic setObject:tipoOperacionSave forKey:@"TipoOperacion"];
    
    //MOTIVOS INCUMPLIMIENTO
    NSArray *motivosIncumplimiento = [resultadosDictionary objectForKey:@"motivosIncumplimiento"];
    NSMutableArray *motivosIncumplimientoSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<motivosIncumplimiento.count; i++){
        UITextField *tempTF = motivosIncumplimiento[i];
        if(tempTF.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF.tag] forKey:@"id"];
            [motivosIncumplimientoSave addObject:tempDic];
        }
    }
    [resultadosDic setObject:motivosIncumplimientoSave forKey:@"MotivosIncumplimiento"];
    
    //CONVENIO
    NSArray *convenioArray = [resultadosDictionary objectForKey:@"convenio"];
    NSMutableArray *convenioSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<convenioArray.count; i++){
        UITextField *tempTF = convenioArray[i];
        if(tempTF.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF.tag] forKey:@"id"];
            [convenioSave addObject:tempDic];
        }
    }
    [resultadosDic setObject:convenioSave forKey:@"Convenio"];
    
    //RESULTADOS INMEDIATOS
    NSArray *resultadosInmediatosArray = [resultadosDictionary objectForKey:@"resultadosInmediatos"];
    NSMutableArray *resultadosInmeidiatosSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<resultadosInmediatosArray.count; i++){
        NSDictionary *masterTempDic = resultadosInmediatosArray[i];
        UITextField *tempTF = [masterTempDic objectForKey:@"resultados"];
        UITextField *tempTF2 = [masterTempDic objectForKey:@"cantidad"];
        NSMutableDictionary *singleDic = [[NSMutableDictionary alloc] init];
        if(tempTF.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF.tag] forKey:@"id"];
            [singleDic setObject:tempDic forKey:@"resultados"];
        }
        if(tempTF2.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF2.text forKey:@"text"];
            [singleDic setObject:tempDic forKey:@"cantidad"];
        }
        if(tempTF.text.length || tempTF2.text.length){
            [resultadosInmeidiatosSave addObject:singleDic];
        }
    }
    [resultadosDic setObject:resultadosInmeidiatosSave forKey:@"ResultadosInmediatos"];
    
    //OTROS RESULTADOS
    NSArray *otrosArray = [resultadosDictionary objectForKey:@"otrosResultados"];
    NSMutableArray *otrosSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<otrosArray.count; i++){
        UITextField *tempTF = otrosArray[i];
        if(tempTF.text.length){
            [otrosSave addObject:tempTF.text];
        }
    }
    [resultadosDic setObject:otrosSave forKey:@"OtrosResultados"];
    
    //NSLog(@"Resultadoxxx: %@",resultadosDic);
    
    [masterDic setObject:resultadosDic forKey:@"Resultados"];
    //////////////////////////////////////
    /////Fin sección de resultados////////
    //////////////////////////////////////
    
    //////////////////////////////////////
    /////Motivos de retardo///////////////
    //////////////////////////////////////
    NSArray *motArr = [motivosDictionary objectForKey:@"motivosRetardo"];
    NSMutableArray *motivosForSave = [[NSMutableArray alloc]init];
    for(int i = 0; i<motArr.count; i++){
        UITextField *tempTF = motArr[i];
        if(tempTF.text.length){
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            [tempDic setObject:tempTF.text forKey:@"text"];
            [tempDic setObject:[NSString stringWithFormat:@"%i",tempTF.tag] forKey:@"id"];
            [motivosForSave addObject:tempDic];
        }
    }
    [masterDic setObject:motivosForSave forKey:@"MotivosRetardo"];
    //////////////////////////////////////
    /////Fin de Motivos de retardo////////
    //////////////////////////////////////
    
    SBJSON *json=[[SBJSON alloc]init];

    NSMutableDictionary *ultra=[[NSMutableDictionary alloc]init];
    [ultra setObject:masterDic forKey:@"MisionCumplida"];
    NSString *str=[json stringWithObject:ultra];
    
    //NSLog(@"JsonXX: %@",str);
    
    [masterDic setObject:@"NO" forKey:@"Done"];
    [masterDic setObject:@"mc" forKey:@"NoOrden"];
    
    
    if (sender.tag==10) {
        FileSaver *file=[[FileSaver alloc]init];
        NSString *nameForFile = [NSString stringWithFormat:@"mc%@",@""/*ordenDeVuelo.principal.idConsecutivoUnidad*/];
        [file setDictionary:masterDic withName:nameForFile];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (sender.tag==11){
        [self sincronizarDataConServer:str];
        //NSLog(@"Diccionario %@",masterDic);
    }
}
@end
