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

@synthesize ordenDeVuelo;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self crearPaginas];
    [self seleccionarBoton:1];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.view setBounds: CGRectMake(0, -20, 1024, 748)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ibactions
-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
//    FileSaver *file=[[FileSaver alloc]init];
//    NSMutableDictionary *masterDic=[[NSMutableDictionary alloc]init];
//    [masterDic setObject:@"YES" forKey:@"Done"];
//    [file setDictionary:masterDic withName:ordenDeVuelo.principal.idConsecutivoUnidad];
}
-(IBAction)informe:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 0, 0.0f) animated:YES];
    [self seleccionarBoton:1];
}
-(IBAction)informacion:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 1, 0.0f) animated:YES];
    [self seleccionarBoton:2];
}
-(IBAction)paxCargaArmamento:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 2, 0.0f) animated:YES];
    [self seleccionarBoton:3];
}
-(IBAction)resultados:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 3, 0.0f) animated:YES];
    [self seleccionarBoton:4];
}
-(IBAction)motivosRetardo:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width * 4, 0.0f) animated:YES];
    [self seleccionarBoton:5];
}

#pragma mark - hilight method
-(void)seleccionarBoton:(int)numeroDeBoton{
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
-(void)crearPaginas{
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
-(void)crearPaginaInforme{
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
    [paginaInforme addSubview:descripcionTV];
    
    
    UILabel *recomendacionesLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, (marginTop*2)-threshold, labelWidth, labelHeight)];
    [recomendacionesLabel setText:@"Recomendaciones:"];
    [recomendacionesLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInforme addSubview:recomendacionesLabel];
    recomendacionesTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, (marginTop*2)-threshold-(tvHeight/4), tvWidth, tvHeight)];
    recomendacionesTV.layer.borderWidth = 1;
    recomendacionesTV.layer.borderColor = [[UIColor grayColor] CGColor];
    [paginaInforme addSubview:recomendacionesTV];
    
    UILabel *resultadosLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, (marginTop*3)-threshold, labelWidth, labelHeight)];
    [resultadosLabel setText:@"Resultados:"];
    [resultadosLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInforme addSubview:resultadosLabel];
    resultadosTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, (marginTop*3)-threshold-(tvHeight/4), tvWidth, tvHeight)];
    resultadosTV.layer.borderWidth = 1;
    resultadosTV.layer.borderColor = [[UIColor grayColor] CGColor];
    [paginaInforme addSubview:resultadosTV];
    
    UILabel *observacionesLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, (marginTop*4)-threshold, labelWidth, labelHeight)];
    [observacionesLabel setText:@"Observaciones:"];
    [observacionesLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInforme addSubview:observacionesLabel];
    observacionesTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, (marginTop*4)-threshold-(tvHeight/4), tvWidth, tvHeight)];
    observacionesTV.layer.borderWidth = 1;
    observacionesTV.layer.borderColor = [[UIColor grayColor] CGColor];
    [paginaInforme addSubview:observacionesTV];
    
    UILabel *noSerieVideoLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, (marginTop*5)-threshold, labelWidth, labelHeight)];
    [noSerieVideoLabel setText:@"No. Serie Video:"];
    [noSerieVideoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    [paginaInforme addSubview:noSerieVideoLabel];
    noSerieVideoTV = [[UITextView alloc]initWithFrame:CGRectMake(marginLeft+distanceForTV, (marginTop*5)-threshold, tvWidth, tvHeight/2)];
    noSerieVideoTV.layer.borderWidth = 1;
    noSerieVideoTV.layer.borderColor = [[UIColor grayColor] CGColor];
    [paginaInforme addSubview:noSerieVideoTV];
    
}
-(void)crearPaginaInformacion{
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
    for(int i=0;i<8;i++){
        UITextField *entidadTF = [self crearTextField:marginLeftForTV y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [entidadTF setUserInteractionEnabled:NO];
        UITextField *requerimientoTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*1)+2 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [requerimientoTF setUserInteractionEnabled:NO];
        UITextField *operacionTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*2)+4 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [operacionTF setUserInteractionEnabled:NO];
        UITextField *operacionTipoTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*3)+6 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [operacionTipoTF setUserInteractionEnabled:NO];
        UITextField *planTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*4)+8 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        [planTF setUserInteractionEnabled:NO];

    }
    
    
}
-(void)crearPaginaPax{
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
    
    tipoPax0 = [self crearTextField:marginLeft y:marginTop+(tfHeight*0) width:tfWidthLarge height:tfHeight InView:paxScroll];
    entidadPax0 = [self crearTextField:marginLeft+(tfWidthLarge)+2 y:marginTop+(tfHeight*0) width:tfWidthLarge height:tfHeight InView:paxScroll];
    cantidadPax0 = [self crearTextField:marginLeft+(tfWidthLarge*2)+4 y:marginTop+(tfHeight*0) width:tfWidthShort height:tfHeight InView:paxScroll];
    
    tipoPax1 = [self crearTextField:marginLeft y:marginTop+(tfHeight*1)+1 width:tfWidthLarge height:tfHeight InView:paxScroll];
    entidadPax1 = [self crearTextField:marginLeft+(tfWidthLarge)+2 y:marginTop+(tfHeight*1)+1 width:tfWidthLarge height:tfHeight InView:paxScroll];
    cantidadPax1 = [self crearTextField:marginLeft+(tfWidthLarge*2)+4 y:marginTop+(tfHeight*1)+1 width:tfWidthShort height:tfHeight InView:paxScroll];
    
    tipoPax2 = [self crearTextField:marginLeft y:marginTop+(tfHeight*2)+2 width:tfWidthLarge height:tfHeight InView:paxScroll];
    entidadPax2 = [self crearTextField:marginLeft+(tfWidthLarge)+2 y:marginTop+(tfHeight*2)+2 width:tfWidthLarge height:tfHeight InView:paxScroll];
    cantidadPax2 = [self crearTextField:marginLeft+(tfWidthLarge*2)+4 y:marginTop+(tfHeight*2)+2 width:tfWidthShort height:tfHeight InView:paxScroll];
    
    tipoPax3 = [self crearTextField:marginLeft y:marginTop+(tfHeight*3)+3 width:tfWidthLarge height:tfHeight InView:paxScroll];
    entidadPax3 = [self crearTextField:marginLeft+(tfWidthLarge)+2 y:marginTop+(tfHeight*3)+3 width:tfWidthLarge height:tfHeight InView:paxScroll];
    cantidadPax3 = [self crearTextField:marginLeft+(tfWidthLarge*2)+4 y:marginTop+(tfHeight*3)+3 width:tfWidthShort height:tfHeight InView:paxScroll];
    
    tipoPax4 = [self crearTextField:marginLeft y:marginTop+(tfHeight*4)+4 width:tfWidthLarge height:tfHeight InView:paxScroll];
    entidadPax4 = [self crearTextField:marginLeft+(tfWidthLarge)+2 y:marginTop+(tfHeight*4)+4 width:tfWidthLarge height:tfHeight InView:paxScroll];
    cantidadPax4 = [self crearTextField:marginLeft+(tfWidthLarge*2)+4 y:marginTop+(tfHeight*4)+4 width:tfWidthShort height:tfHeight InView:paxScroll];
    
    tipoPax5 = [self crearTextField:marginLeft y:marginTop+(tfHeight*5)+5 width:tfWidthLarge height:tfHeight InView:paxScroll];
    entidadPax5 = [self crearTextField:marginLeft+(tfWidthLarge)+2 y:marginTop+(tfHeight*5)+5 width:tfWidthLarge height:tfHeight InView:paxScroll];
    cantidadPax5 = [self crearTextField:marginLeft+(tfWidthLarge*2)+4 y:marginTop+(tfHeight*5)+5 width:tfWidthShort height:tfHeight InView:paxScroll];
    
    tipoPax6 = [self crearTextField:marginLeft y:marginTop+(tfHeight*6)+6 width:tfWidthLarge height:tfHeight InView:paxScroll];
    entidadPax6 = [self crearTextField:marginLeft+(tfWidthLarge)+2 y:marginTop+(tfHeight*6)+6 width:tfWidthLarge height:tfHeight InView:paxScroll];
    cantidadPax6 = [self crearTextField:marginLeft+(tfWidthLarge*2)+4 y:marginTop+(tfHeight*6)+6 width:tfWidthShort height:tfHeight InView:paxScroll];
    
    tipoPax7 = [self crearTextField:marginLeft y:marginTop+(tfHeight*7)+7 width:tfWidthLarge height:tfHeight InView:paxScroll];
    entidadPax7 = [self crearTextField:marginLeft+(tfWidthLarge)+2 y:marginTop+(tfHeight*7)+7 width:tfWidthLarge height:tfHeight InView:paxScroll];
    cantidadPax7 = [self crearTextField:marginLeft+(tfWidthLarge*2)+4 y:marginTop+(tfHeight*7)+7 width:tfWidthShort height:tfHeight InView:paxScroll];
    
    tipoPax7.data1 = @"Hola mundo";
    
    UITextField *totalPaxTF = [self crearTextField:420 y:155 width:80 height:30 InView:paginaPaxArmamento];
    totalPaxTF.userInteractionEnabled = NO;
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
    
    entidadCarga0 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*0) width:tfWidthShort height:tfHeight InView:cargaScroll];
    cantidadCarga0 = [self crearTextField:marginLeft+(tfWidthShort)+4 y:marginTop+(tfHeight*0) width:tfWidthLarge height:tfHeight InView:cargaScroll];
    
    entidadCarga1 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*1)+1 width:tfWidthShort height:tfHeight InView:cargaScroll];
    cantidadCarga1 = [self crearTextField:marginLeft+(tfWidthShort)+4 y:marginTop+(tfHeight*1)+1 width:tfWidthLarge height:tfHeight InView:cargaScroll];
    
    entidadCarga2 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*2)+2 width:tfWidthShort height:tfHeight InView:cargaScroll];
    cantidadCarga2 = [self crearTextField:marginLeft+(tfWidthShort)+4 y:marginTop+(tfHeight*2)+2 width:tfWidthLarge height:tfHeight InView:cargaScroll];
    
    entidadCarga3 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*3)+3 width:tfWidthShort height:tfHeight InView:cargaScroll];
    cantidadCarga3 = [self crearTextField:marginLeft+(tfWidthShort)+4 y:marginTop+(tfHeight*3)+3 width:tfWidthLarge height:tfHeight InView:cargaScroll];
    
    entidadCarga4 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*4)+4 width:tfWidthShort height:tfHeight InView:cargaScroll];
    cantidadCarga4 = [self crearTextField:marginLeft+(tfWidthShort)+4 y:marginTop+(tfHeight*4)+4 width:tfWidthLarge height:tfHeight InView:cargaScroll];
    
    entidadCarga5 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*5)+5 width:tfWidthShort height:tfHeight InView:cargaScroll];
    cantidadCarga5 = [self crearTextField:marginLeft+(tfWidthShort)+4 y:marginTop+(tfHeight*5)+5 width:tfWidthLarge height:tfHeight InView:cargaScroll];
    
    entidadCarga6 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*6)+6 width:tfWidthShort height:tfHeight InView:cargaScroll];
    cantidadCarga6 = [self crearTextField:marginLeft+(tfWidthShort)+4 y:marginTop+(tfHeight*6)+6 width:tfWidthLarge height:tfHeight InView:cargaScroll];
    
    entidadCarga7 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*7)+7 width:tfWidthShort height:tfHeight InView:cargaScroll];
    cantidadCarga7 = [self crearTextField:marginLeft+(tfWidthShort)+4 y:marginTop+(tfHeight*7)+7 width:tfWidthLarge height:tfHeight InView:cargaScroll];
    
    UITextField *totalCargaTF = [self crearTextField:607 y:155 width:80 height:30 InView:paginaPaxArmamento];
    totalCargaTF.userInteractionEnabled = NO;
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
    tipoArmamento0 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*0) width:tfWidthLarge*3 height:tfHeight InView:armamentoScroll];
    cantidadArmamento0 = [self crearTextField:marginLeft+4+(tfWidthLarge*3) y:marginTop+(tfHeight*0) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    cantidadFallidoArmamento0 = [self crearTextField:marginLeft+6+(tfWidthLarge*3+tfWidthShort) y:marginTop+(tfHeight*0) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    efectividadArmamento0 = [self crearTextField:marginLeft+8+(tfWidthLarge*3+tfWidthShort*2) y:marginTop+(tfHeight*0) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    
    tipoArmamento1 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*1) width:tfWidthLarge*3 height:tfHeight InView:armamentoScroll];
    cantidadArmamento1 = [self crearTextField:marginLeft+4+(tfWidthLarge*3) y:marginTop+(tfHeight*1) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    cantidadFallidoArmamento1 = [self crearTextField:marginLeft+6+(tfWidthLarge*3+tfWidthShort) y:marginTop+(tfHeight*1) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    efectividadArmamento1 = [self crearTextField:marginLeft+8+(tfWidthLarge*3+tfWidthShort*2) y:marginTop+(tfHeight*1) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    
    tipoArmamento2 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*2) width:tfWidthLarge*3 height:tfHeight InView:armamentoScroll];
    cantidadArmamento2 = [self crearTextField:marginLeft+4+(tfWidthLarge*3) y:marginTop+(tfHeight*2) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    cantidadFallidoArmamento2 = [self crearTextField:marginLeft+6+(tfWidthLarge*3+tfWidthShort) y:marginTop+(tfHeight*2) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    efectividadArmamento2 = [self crearTextField:marginLeft+8+(tfWidthLarge*3+tfWidthShort*2) y:marginTop+(tfHeight*2) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    
    tipoArmamento3 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*3) width:tfWidthLarge*3 height:tfHeight InView:armamentoScroll];
    cantidadArmamento3 = [self crearTextField:marginLeft+4+(tfWidthLarge*3) y:marginTop+(tfHeight*3) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    cantidadFallidoArmamento3 = [self crearTextField:marginLeft+6+(tfWidthLarge*3+tfWidthShort) y:marginTop+(tfHeight*3) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    efectividadArmamento3 = [self crearTextField:marginLeft+8+(tfWidthLarge*3+tfWidthShort*2) y:marginTop+(tfHeight*3) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    
    tipoArmamento4 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*4) width:tfWidthLarge*3 height:tfHeight InView:armamentoScroll];
    cantidadArmamento4 = [self crearTextField:marginLeft+4+(tfWidthLarge*3) y:marginTop+(tfHeight*4) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    cantidadFallidoArmamento4 = [self crearTextField:marginLeft+6+(tfWidthLarge*3+tfWidthShort) y:marginTop+(tfHeight*4) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    efectividadArmamento4 = [self crearTextField:marginLeft+8+(tfWidthLarge*3+tfWidthShort*2) y:marginTop+(tfHeight*4) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    
    tipoArmamento5 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*5) width:tfWidthLarge*3 height:tfHeight InView:armamentoScroll];
    cantidadArmamento5 = [self crearTextField:marginLeft+4+(tfWidthLarge*3) y:marginTop+(tfHeight*5) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    cantidadFallidoArmamento5 = [self crearTextField:marginLeft+6+(tfWidthLarge*3+tfWidthShort) y:marginTop+(tfHeight*5) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    efectividadArmamento5 = [self crearTextField:marginLeft+8+(tfWidthLarge*3+tfWidthShort*2) y:marginTop+(tfHeight*5) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    
    tipoArmamento6 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*6) width:tfWidthLarge*3 height:tfHeight InView:armamentoScroll];
    cantidadArmamento6 = [self crearTextField:marginLeft+4+(tfWidthLarge*3) y:marginTop+(tfHeight*6) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    cantidadFallidoArmamento6 = [self crearTextField:marginLeft+6+(tfWidthLarge*3+tfWidthShort) y:marginTop+(tfHeight*6) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    efectividadArmamento6 = [self crearTextField:marginLeft+8+(tfWidthLarge*3+tfWidthShort*2) y:marginTop+(tfHeight*6) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    
    tipoArmamento7 = [self crearTextField:marginLeft+2 y:marginTop+(tfHeight*7) width:tfWidthLarge*3 height:tfHeight InView:armamentoScroll];
    cantidadArmamento7 = [self crearTextField:marginLeft+4+(tfWidthLarge*3) y:marginTop+(tfHeight*7) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    cantidadFallidoArmamento7 = [self crearTextField:marginLeft+6+(tfWidthLarge*3+tfWidthShort) y:marginTop+(tfHeight*7) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    efectividadArmamento7 = [self crearTextField:marginLeft+8+(tfWidthLarge*3+tfWidthShort*2) y:marginTop+(tfHeight*7) width:tfWidthShort height:tfHeight InView:armamentoScroll];
    
}
-(void)crearPaginaResultados{
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
    for(int i=0;i<8;i++){
        UITextField *entidadTF = [self crearTextField:10 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tipoOperacionScroll];
        [entidadTF setUserInteractionEnabled:NO];
        //UITextField *requerimientoTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*1)+2 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        //[requerimientoTF setUserInteractionEnabled:NO];
    }
    
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
    for(int i=0;i<8;i++){
        UITextField *entidadTF = [self crearTextField:10 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:convenioScroll];
        [entidadTF setUserInteractionEnabled:NO];
    }
    
    
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
    for(int i=0;i<8;i++){
        UITextField *entidadTF = [self crearTextField:10 y:(tfHeight*i)+(2*i) width:480 height:tfHeight InView:motivosIncumplimientoScroll];
        [entidadTF setUserInteractionEnabled:NO];
        //UITextField *requerimientoTF = [self crearTextField:marginLeftForTV+(tfWidthLarge*1)+2 y:(tfHeight*i)+(2*i) width:tfWidthLarge height:tfHeight InView:tVScroll];
        //[requerimientoTF setUserInteractionEnabled:NO];
    }
    
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
    for(int i=0;i<8;i++){
        UITextField *entidadTF = [self crearTextField:10 y:(tfHeight*i)+(2*i) width:300 height:tfHeight InView:resultadosInmediatosScroll];
        [entidadTF setUserInteractionEnabled:NO];
        UITextField *requerimientoTF = [self crearTextField:10+(300*1)+2 y:(tfHeight*i)+(2*i) width:180 height:tfHeight InView:resultadosInmediatosScroll];
        [requerimientoTF setUserInteractionEnabled:NO];
    }
    
    //Last Textfield
    UILabel *otrosResultadosLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 380, 180, 30)];
    [otrosResultadosLabel setText:@"Otros Resultados:"];
    [otrosResultadosLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
    [paginaResultados addSubview:otrosResultadosLabel];
    
    UITextFieldDS *otrosResultadosTF = [self crearTextField:200 y:380 width:703 height:tfHeight InView:paginaResultados];
    
}
-(void)crearPaginaMotivos{
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
    
    
    retardo1 = [self crearTextField:center y:(marginTop*1)+initialMargin width:tfWidth height:tfHeight InView:paginaMotivos];
    retardo2 = [self crearTextField:center y:(marginTop*2)+initialMargin width:tfWidth height:tfHeight InView:paginaMotivos];
    retardo3 = [self crearTextField:center y:(marginTop*3)+initialMargin width:tfWidth height:tfHeight InView:paginaMotivos];
    retardo4 = [self crearTextField:center y:(marginTop*4)+initialMargin width:tfWidth height:tfHeight InView:paginaMotivos];
    retardo5 = [self crearTextField:center y:(marginTop*5)+initialMargin width:tfWidth height:tfHeight InView:paginaMotivos];
    retardo6 = [self crearTextField:center y:(marginTop*6)+initialMargin width:tfWidth height:tfHeight InView:paginaMotivos];
    retardo7 = [self crearTextField:center y:(marginTop*7)+initialMargin width:tfWidth height:tfHeight InView:paginaMotivos];
    retardo8 = [self crearTextField:center y:(marginTop*8)+initialMargin width:tfWidth height:tfHeight InView:paginaMotivos];
    
}
-(UITextFieldDS*)crearTextField:(int)x y:(int)y width:(int)width height:(int)height InView:(UIView*)view{
    UITextFieldDS *tf = [[UITextFieldDS alloc]initWithFrame:CGRectMake(x, y, width, height)];
    tf.backgroundColor = [UIColor whiteColor];
    tf.borderStyle =UITextBorderStyleLine;
    [view addSubview:tf];
    return tf;
}
#pragma mark - procedimientos compartidos entre páginas

#pragma mark - esconder pickers externos
-(void)callForeignDismisser{
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"esconderPicker" object:nil];
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
    return 0;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    return;
    
}
#pragma mark - guardar
-(IBAction)guardarRegistro:(UIButton*)sender{
}
#pragma mark - fecha
-(void)displayDate:(id)sender {
    NSDate * selected = [datePicker date];
    //NSString * dateString = [selected description];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];//HH:mm
    
    //NSString *strDate = [formatter stringFromDate:selected];
    //fechaTextfield.text = strDate;
}
#pragma mark - server communication
-(void)sincronizarDataConServer:(NSString*)data{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=1;
}
#pragma mark - server response
-(void)receivedDataFromServer:(ServerCommunicator*)sender{
}
-(void)receivedDataFromServerWithError:(ServerCommunicator*)sender{
}
#pragma mark number check
- (BOOL) isAllDigitsFromArray:(NSArray*)array
{
    for (NSString *string in array) {
        NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSRange r = [string rangeOfCharacterFromSet: nonNumbers];
        if (r.location != NSNotFound) {
            return NO;
        }
    }
    return YES;
}
- (BOOL) isAllDigitsFromString:(NSString*)string
{
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
