//
//  DashBoardViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 30/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "DashBoardViewController.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController
@synthesize searchDisplayController,leftSearchBar;
- (void)viewDidLoad
{
    [super viewDidLoad];
    frameInicialOV=CGRectMake(804, 567, 220, 181);
    frameFinalOV=CGRectMake((self.view.frame.size.width/2)+27.5,
                            (self.view.frame.size.height/2)/2,
                            220,
                            181);
    frameInicialMT=CGRectMake(634, 45, 211, 107);
    frameFinalMT=CGRectMake((self.view.frame.size.width/2)+27.5,
                            ((self.view.frame.size.height/2)/2)+40,
                            211,
                            107);
    searchInicialMT=CGRectMake(0, 45, 298, 44);
    searchFinalMT=CGRectMake(0,
                             (self.view.frame.size.height/3)+12,
                             self.view.frame.size.height,
                             44);
    //leftTableArray=[[NSMutableArray alloc]initWithObjects:@"pptexample.ppt",@"docexample.doc",@"pdf.pdf", nil];
    leftTableArray=[[NSMutableArray alloc]init];
    
    searchDisplayController.searchResultsTableView.frame=CGRectMake(0, 200, 300, 500);
    //[leftTableArray addObject:@"pptexample.ppt"];
    //[leftTableArray addObject:@"docexample.doc"];
    //[leftTableArray addObject:@"pdf.pdf"];
    
    
    rightTableMetarArray = [[NSMutableArray alloc]init];
    rightTableMetarArrayParcial = [[NSMutableArray alloc]init];
    rightTableMetarArrayFijo = [[NSMutableArray alloc]init];
    
    rightTableNotamArray = [[NSMutableArray alloc]init];
    rightTableNotamArrayParcial = [[NSMutableArray alloc]init];
    rightTableNotamArrayFijo = [[NSMutableArray alloc]init];
    
    arrayFaseVuelo=[[NSMutableArray alloc]init];
    arrayDepartamentos=[[NSMutableArray alloc]init];
    arrayMunicipios=[[NSMutableArray alloc]init];
    arrayArmamentos=[[NSMutableArray alloc]init];

    /*[rightTableArray addObject:@"SKBO A1947/12 STRIP RWY 13L/31R AND ASSOCIATED TWY, WIP EXER CTN. H24, 26 JUN 02:40 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 02:40 2012"];
     [rightTableArray addObject:@"SKBO A1949/12 STRIP RWY 13R/31L AND ASSOCIATED TWY, WIP EXER CTN. H24, 26 JUN 02:40 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 02:51 2012"];
     [rightTableArray addObject:@"SKBO A1950/12 STRIP TWY A AND F, WIP EXER CTN. H24, 01 JUL 00:00 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 03:06 2012 "];
     [rightTableArray addObject:@"SKBO A1955/12 STRIP TWY R AND TWY S, WIP EXER CTN. H24, 01 JUL 00:00 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 03:37 2012"];
     [rightTableArray addObject:@"SKBO A1956/12 STRIP TWY M, WIP EXER CTN. 01 JUL 00:00 2012 UNTIL 31 DEC 23:59 2012. CREATED: 01 JUL 05:59 2012"];
     [rightTableArray addObject:@"SKBO A1957/12 STRIP TWY D BTN TWY A AND TWY M, WIP EXER CTN. H24, 01 JUL 00:00 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 05:01 2012"];*/
    
    
    //NSLog (@"%d subviews", [self.searchDisplayController.searchContentsController.view.subviews count]);
    for (int i = 0; i < [self.searchDisplayController.searchContentsController.view.subviews count]; i++)
    {
        id view = [self.searchDisplayController.searchContentsController.view.subviews objectAtIndex:i];
        NSRange rng = [[view description] rangeOfString:@"UIControl"];
        if (rng.length != 0)
        {
            UIView * backgroundView = (UIView*)view;
            CGRect frame = leftTableView.frame;
            frame.size.height = self.searchDisplayController.searchContentsController.view.frame.size.height;
            backgroundView.frame = frame;
        }
        
        //NSLog (@"%@", view);
    }
    containerOV.layer.borderColor=[UIColor darkGrayColor].CGColor;
    containerOV.layer.borderWidth=2;
    containerOV.layer.cornerRadius=10;
    containerMetar.layer.borderColor=[UIColor darkGrayColor].CGColor;
    containerMetar.layer.cornerRadius=10;
    containerMetar.layer.borderWidth=2;
    
    //notamSwitch.onTintColor=[UIColor grayColor];
    //metarSwitch.onTintColor=[UIColor grayColor];
    //conservarSwitch.onTintColor=[UIColor grayColor];
    //ovTF.text=@"1472";
    //matriTF.text=@"4005";
    ovTF.text=@"633";
    matriTF.text=@"1010";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(archivoSuccess:)
												 name:@"ArchivosSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(archivoError:)
												 name:@"ArchivosError" object:nil];
    Archivo *archivo=[[Archivo alloc]init];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"true" forKey:@"Offline"];
    [archivo validarDiccionarioDeArchivos:dic];    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma text delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    touchFlag=YES;
    if (textField.tag==1000) {
        [self animarView:containerOV Hasta:frameFinalOV];
        [self animarView:containerMetar Hasta:frameInicialMT];
        //[self animarView:leftSearchBar Hasta:searchInicialMT];
    }
    else if(textField.tag==1001){
        [self animarView:containerMetar Hasta:frameFinalMT];
        [self animarView:containerOV Hasta:frameInicialOV];
        //[self animarView:leftSearchBar Hasta:searchInicialMT];
    }
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    touchFlag=YES;
    //[self animarView:leftSearchBar Hasta:searchFinalMT];
    [self animarView:containerOV Hasta:frameInicialOV];
    [self animarView:containerMetar Hasta:frameInicialMT];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    touchFlag=NO;
    [self performSelector:@selector(delayed) withObject:nil afterDelay:0.001];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    touchFlag=NO;
    [self performSelector:@selector(delayed) withObject:nil afterDelay:0.001];
}
-(void)delayed{
    if (!touchFlag) {
        [self animarView:containerOV Hasta:frameInicialOV];
        [self animarView:containerMetar Hasta:frameInicialMT];
        //[self animarView:leftSearchBar Hasta:searchInicialMT];
    }
}

#pragma mark animacion
-(void)animarView:(UIView*)view Hasta:(CGRect)hasta{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.frame=hasta;
    [UIView commitAnimations];
}
#pragma mark dismiss keyboard
-(void)resignKeyboard{
    [ovTF resignFirstResponder];
    [matriTF resignFirstResponder];
}
#pragma mark button actions
-(IBAction)showImage:(UIButton*)sender{
    if (sender.tag==100) {
        /*DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
         dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
         dVC.path=[[NSBundle mainBundle] pathForResource:@"test.pdf" ofType:nil];
         //[self.navigationController pushViewController:dVC animated:YES];
         [self loadDocument:@"test.pdf" inView:nil];*/
        [self getImageFromServerWithNumber:@"1"];
    }
    else if (sender.tag==101) {
        /*DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
         dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
         dVC.path=[[NSBundle mainBundle] pathForResource:@"test.pdf" ofType:nil];
         //[self.navigationController pushViewController:dVC animated:YES];
         [self loadDocument:@"test.pdf" inView:nil];*/
        [self getImageFromServerWithNumber:@"2"];
    }
    else if (sender.tag==102) {
        /*DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
         dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
         dVC.path=[[NSBundle mainBundle] pathForResource:@"test.pdf" ofType:nil];
         //[self.navigationController pushViewController:dVC animated:YES];
         [self loadDocument:@"test.pdf" inView:nil];*/
        [self getImageFromServerWithNumber:@"3"];
    }
}
-(IBAction)cosultarMetarNotam:(id)sender{
    //[self getMetar];
    if (ordenDeVuelo) {
        [self actualizarTablaConPeticionDeString:mtTF.text];
    }
    else{
        NSString *message=@"Es necesario que primero valide la orden de vuelo.\nEn la esquina inferior derecha podrá realizar este proceso.";
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Orden De Vuelo" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //NSLog(@"No existe orden de vuelo");
    }
    [mtTF resignFirstResponder];
    //esta función ejecuta una reacción en cadena y llama a getNotam
}
-(IBAction)switcChangedNotamMetar:(id)sender{
    [rightTableView reloadData];
}
-(IBAction)consultarOrdenDeVuelo:(id)sender{
    [self ordenDeVuelo];
}
-(IBAction)actualizarTablaDeArchivos:(id)sender{
    [self obtenerArchivosYmostrar];
}
-(IBAction)irAOrdenDeVuelo:(id)sender{
    if (ordenDeVuelo) {
        OrdenDeVueloMenuViewController *ovmVC=[[OrdenDeVueloMenuViewController alloc]init];
        ovmVC=[self.storyboard instantiateViewControllerWithIdentifier:@"OrdenDeVueloMenu1"];
        ovmVC.ordenDeVuelo=ordenDeVuelo;
        [self.navigationController pushViewController:ovmVC animated:YES];
    }
    else{
        NSString *message=@"Es necesario que primero valide la orden de vuelo.\nEn la esquina inferior derecha podrá realizar este proceso.";
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Orden De Vuelo" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //NSLog(@"No existe orden de vuelo");
    }
    
}
-(IBAction)irARegistroDeVuelo:(id)sender{
    if (ordenDeVuelo) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=NSLocalizedString(@"Cargando Registro de Vuelo", nil);
        [self performSelector:@selector(delayedAction) withObject:sender afterDelay:0.01];
    }
     else{
     NSString *message=@"Es necesario que primero valide la orden de vuelo.\nEn la esquina inferior derecha podrá realizar este proceso.";
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Orden De Vuelo" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     //NSLog(@"No existe orden de vuelo");
     }
    
}
-(void)delayedAction{
    RegistroDeVueloViewController *rvmVC=[[RegistroDeVueloViewController alloc]init];
    rvmVC=[self.storyboard instantiateViewControllerWithIdentifier:@"RegistroDeVuelo"];
    rvmVC.ordenDeVuelo=ordenDeVuelo;
    rvmVC.arrayFaseVuelo=arrayFaseVuelo;
    rvmVC.arrayDepartamentos=arrayDepartamentos;
    rvmVC.arrayArmamentos=arrayArmamentos;
    rvmVC.lista=lista;
    [self.navigationController pushViewController:rvmVC animated:YES];
}
#pragma mark external request
-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView{
    //NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSString *path = documentName;
    
    NSURL *url = [NSURL fileURLWithPath:path];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[webView loadRequest:request];
    //[self loadDocument:@"test.pdf" inView:nil];
    //UIDocumentInteractionController *UIC=[self setupControllerWithURL:url usingDelegate:self];
    //[UIC presentOpenInMenuFromRect:CGRectMake(0, 0, 200, 200) inView:self.view animated:YES];
    [self previewDocumentWithURL:url];
}
-(void)loadLocalDocument:(NSString*)documentName inView:(UIWebView*)webView{
    //NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    //NSString *path = documentName;
    
    NSURL *url = [NSURL fileURLWithPath:documentName];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[webView loadRequest:request];
    //[self loadDocument:@"test.pdf" inView:nil];
    //UIDocumentInteractionController *UIC=[self setupControllerWithURL:url usingDelegate:self];
    //[UIC presentOpenInMenuFromRect:CGRectMake(0, 0, 200, 200) inView:self.view animated:YES];
    [self previewDocumentWithURL:url];
}
- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL
                                               usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    
    UIDocumentInteractionController *interactionController =
    [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
}
- (void)previewDocumentWithURL:(NSURL*)url
{
    UIDocumentInteractionController* preview = [UIDocumentInteractionController interactionControllerWithURL:url];
    preview.delegate = self;
    preview.name=@"";
    [preview presentPreviewAnimated:YES];
}
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}
#pragma mark Server requests
-(void)getImageFromServerWithNumber:(NSString*)number{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=[number intValue];
    NSString *params=[NSString stringWithFormat:@"<canal>%@</canal>",number];
    [server callServerWithMethod:@"getImage" andParameter:params];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Cargando imagen", nil);
}
-(void)getMetar{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=4;
    [server callServerWithMethod:@"Metar" andParameter:@""];
    //hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText=NSLocalizedString(@"Cargando Metars", nil);
}
-(void)getNotam{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=5;
    [server callServerWithMethod:@"Notam" andParameter:@""];
    //hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText=NSLocalizedString(@"Cargando datos", nil);
}
-(void)ordenDeVuelo{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=6;
    NSString *params=[NSString stringWithFormat:@"<consecutivo>%@</consecutivo><matricula>%@</matricula>",ovTF.text,matriTF.text];
    [server callServerWithMethod:@"ordenVuelo" andParameter:params];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Cargando Orden de Vuelo", nil);
}
-(void)obtenerArchivosYmostrar{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=10;
    [server callServerWithMethod:@"documentos" andParameter:@""];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Cargando archivos", nil);
}
-(void)obtenerEnemigos{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=20;
    [server callServerWithMethod:@"enemigos" andParameter:@""];
}
-(void)obtenerObjetivos{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=21;
    [server callServerWithMethod:@"objetivos" andParameter:@""];
}
-(void)obtenerOperaciones{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=22;
    [server callServerWithMethod:@"joaOperaciones" andParameter:@""];
}
-(void)obtenerMunicipios{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=24;
    [server callServerWithMethod:@"municipios" andParameter:@""];
}
-(void)obtenerListas{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=23;
    [server callServerWithMethod:@"listas" andParameter:@""];
}
#pragma mark server response
-(void)receivedDataFromServer:(ServerCommunicator*)sender{
    NSString *result=[sender.resDic objectForKey:@"url"];
    if (sender.tag==1) {
        NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:result yTipo:@"Vapor de Agua"];
        //NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        //dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        [self loadDocument:url inView:nil];
        //[self loadLocalDocument:@"vapordeagua.png" inView:nil];
        
    }
    else if(sender.tag==2){
        NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:result yTipo:@"Visual"];
        //NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        //dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        [self loadDocument:url inView:nil];
        //[self loadLocalDocument:@"visual.png" inView:nil];
        
    }
    else if(sender.tag==3){
        NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:result yTipo:@"Infrarojo"];
        //NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        //dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        [self loadDocument:url inView:nil];
        //[self loadLocalDocument:@"infrarojo.png" inView:nil];
        
    }
    else if (sender.tag==4){
        //NSLog(@"Metari %@",sender.resDic);
        [rightTableMetarArray removeAllObjects];
        NSArray *array=[sender.resDic objectForKey:@"metars"];
        for (NSDictionary * dictionary in array) {
            Metar *metar=[[Metar alloc]initWithDictionary:dictionary];
            [rightTableMetarArray addObject:[metar buildChain]];
        }
        FileSaver *save=[[FileSaver alloc]init];
        [save setDictionary:sender.resDic withName:@"metars"];
        [self getNotam];
        return;
    }
    else if (sender.tag==5){
        //NSLog(@"Metari %@",sender.resDic);
        [rightTableNotamArray removeAllObjects];
        NSArray *array=[sender.resDic objectForKey:@"Notams"];
        for (NSDictionary * dictionary in array) {
            Notam *notam=[[Notam alloc]initWithDictionary:dictionary];
            [rightTableNotamArray addObject:[notam buildChain]];
        }
        FileSaver *save=[[FileSaver alloc]init];
        [save setDictionary:sender.resDic withName:@"Notams"];
        [self actualizarTablaConPeticionDeString:mtTF.text];
        //[rightTableView reloadData];
        [self obtenerListas];
        return;
    }
    else if (sender.tag==6){
        if (ordenDeVuelo) {
            ordenDeVuelo=nil;
        }
        if ([[sender.resDic objectForKey:@"Success"]isEqualToString:@"false"]) {
            NSString *message=@"Por favor verifique el número de matrícula y consecutivo, y vuelva a intentarlo.";
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Información Incorrecta." message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            ordenDeVuelo=[[ModeladorDeOrdenDeVuelo alloc]initWithDictionary:sender.resDic];
            FileSaver *save=[[FileSaver alloc]init];
            [save setDictionary:sender.resDic withName:@"ordenDeVuelo"];
            //[self changeTextToHudAndHideWithDelay:@"Orden de vuelo validada correctamente"];
            [self getMetar];
            return;
        }
    }
    else if (sender.tag==10){
        Archivo *archivo=[[Archivo alloc]init];
        [archivo validarDiccionarioDeArchivos:sender.resDic];
        NSLog(@"Archivos :%@",sender.resDic);
        return;
    }
    else if (sender.tag==20){
        [lista agregarAlArregloRespectivo:sender.resDic];
        FileSaver *save=[[FileSaver alloc]init];
        [save setDictionary:sender.resDic withName:@"enemigos"];
        [self obtenerObjetivos];
        
        return;
    }
    else if (sender.tag==21){
        [lista agregarAlArregloRespectivo:sender.resDic];
        FileSaver *save=[[FileSaver alloc]init];
        [save setDictionary:sender.resDic withName:@"objetivos"];
        [self obtenerOperaciones];
        return;
    }
    else if (sender.tag==22){
        [lista agregarAlArregloRespectivo:sender.resDic];
        FileSaver *save=[[FileSaver alloc]init];
        [save setDictionary:sender.resDic withName:@"operaciones"];
        [self obtenerMunicipios];
        return;
    }
    else if (sender.tag==24){
        [lista agregarAlArregloRespectivo:sender.resDic];
        FileSaver *save=[[FileSaver alloc]init];
        [save setDictionary:sender.resDic withName:@"municipios"];
        [self changeTextToHudAndHideWithDelay:@"Orden de vuelo validada correctamente"];
        return;
    }
    else if (sender.tag==23){
        FileSaver *save=[[FileSaver alloc]init];
        [save setDictionary:sender.resDic withName:@"lista"];
        lista=[[Lista alloc]initWithDictionary:sender.resDic];
        [self obtenerEnemigos];
        return;
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)receivedDataFromServerWithError:(ServerCommunicator*)sender{
    NSString *result=[sender.resDic objectForKey:@"url"];
    if (sender.tag==1) {
        NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:result yTipo:@"Vapor de Agua"];
        //NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        //dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        [self loadDocument:url inView:nil];
        //[self loadLocalDocument:@"vapordeagua.png" inView:nil];
        
    }
    else if(sender.tag==2){
        NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:result yTipo:@"Visual"];
        //NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        //dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        [self loadDocument:url inView:nil];
        //[self loadLocalDocument:@"visual.png" inView:nil];
        
    }
    else if(sender.tag==3){
        NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:result yTipo:@"Infrarojo"];
        //NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        //dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        [self loadDocument:url inView:nil];
        //[self loadLocalDocument:@"infrarojo.png" inView:nil];
        
    }
    else if (sender.tag==4){
        //NSLog(@"Metari %@",sender.resDic);
        [rightTableMetarArray removeAllObjects];
        FileSaver *save=[[FileSaver alloc]init];
        NSDictionary *dic=[save getDictionary:@"metars"];
        NSArray *array=[dic objectForKey:@"metars"];
        for (NSDictionary * dictionary in array) {
            Metar *metar=[[Metar alloc]initWithDictionary:dictionary];
            [rightTableMetarArray addObject:[metar buildChain]];
        }
        
        [self getNotam];
        return;
    }
    else if (sender.tag==5){
        //NSLog(@"Metari %@",sender.resDic);
        [rightTableNotamArray removeAllObjects];
        FileSaver *save=[[FileSaver alloc]init];
        NSDictionary *dic=[save getDictionary:@"Notams"];
        NSArray *array=[dic objectForKey:@"Notams"];
        for (NSDictionary * dictionary in array) {
            Notam *notam=[[Notam alloc]initWithDictionary:dictionary];
            [rightTableNotamArray addObject:[notam buildChain]];
        }
        [self actualizarTablaConPeticionDeString:mtTF.text];
        [self obtenerListas];
        return;
    }
    else if (sender.tag==6){
        FileSaver *save=[[FileSaver alloc]init];
        NSDictionary *dic=[save getDictionary:@"ordenDeVuelo"];
        if (ordenDeVuelo) {
            ordenDeVuelo=nil;
        }
        ordenDeVuelo=[[ModeladorDeOrdenDeVuelo alloc]initWithDictionary:dic];
        if ([ordenDeVuelo.principal.matricula isEqualToString:matriTF.text]) {
            if ([ordenDeVuelo.principal.idConsecutivoUnidad isEqualToString:ovTF.text]) {
                [self changeTextToHudAndHideWithDelay:@"Orden de vuelo validada correctamente"];
                [self getMetar];
                return;
            }
            else{
                ordenDeVuelo=nil;
                NSString *message=@"No es posible validar la orden de vuelo.\nRevise su conexión a la red y vuelva a intentarlo.";
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error." message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else if (!ordenDeVuelo.principal.matricula){
            ordenDeVuelo=nil;
            NSString *message=@"No es posible validar la orden de vuelo.\nRevise su conexión a la red y vuelva a intentarlo.";
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error." message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (sender.tag==10){
        Archivo *archivo=[[Archivo alloc]init];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"true" forKey:@"Offline"];
        [archivo validarDiccionarioDeArchivos:dic];
    }
    else if (sender.tag==20){
        FileSaver *save=[[FileSaver alloc]init];
        NSDictionary *dic=[save getDictionary:@"enemigos"];
        [lista agregarAlArregloRespectivo:dic];
        [self obtenerObjetivos];
        return;
    }
    else if (sender.tag==21){
        FileSaver *save=[[FileSaver alloc]init];
        NSDictionary *dic=[save getDictionary:@"objetivos"];
        [lista agregarAlArregloRespectivo:dic];
        [self obtenerOperaciones];
        return;
    }
    else if (sender.tag==22){
        FileSaver *save=[[FileSaver alloc]init];
        NSDictionary *dic=[save getDictionary:@"operaciones"];
        [lista agregarAlArregloRespectivo:dic];
        [self obtenerMunicipios];
        return;
    }
    else if (sender.tag==24){
        FileSaver *save=[[FileSaver alloc]init];
        NSDictionary *dic=[save getDictionary:@"municipios"];
        [lista agregarAlArregloRespectivo:dic];
    }
    else if (sender.tag==23){
        FileSaver *save=[[FileSaver alloc]init];
        NSDictionary *dic=[save getDictionary:@"lista"];
        lista=[[Lista alloc]initWithDictionary:dic];
        [self obtenerEnemigos];
        return;
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag==10000) {
        return @"Archivos";
    }
    else if(tableView.tag==10001){
        if (metarSwitch.on && notamSwitch.on) {
            if (section==0) {
                //return [NSString stringWithFormat:@"%i Metar disponibles",rightTableMetarArray.count];
                return [NSString stringWithFormat:@"%i Metar disponibles",rightTableMetarArrayParcial.count];
            }
            else if(section==1){
                //return [NSString stringWithFormat:@"%i Notam disponibles",rightTableNotamArray.count];
                return [NSString stringWithFormat:@"%i Notam disponibles",rightTableNotamArrayParcial.count];
                
            }
        }
        else if (metarSwitch.on && !notamSwitch.on){
            //return [NSString stringWithFormat:@"%i Metar disponibles",rightTableMetarArray.count];
            return [NSString stringWithFormat:@"%i Metar disponibles",rightTableMetarArrayParcial.count];
            
        }
        else if (!metarSwitch.on && notamSwitch.on){
            //return [NSString stringWithFormat:@"%i Notam disponibles",rightTableNotamArray.count];
            return [NSString stringWithFormat:@"%i Notam disponibles",rightTableNotamArrayParcial.count];
            
        }
        else{
            return @"";
        }
    }
    else{
        return @"";
    }
    return @"";
}
- (UIView *) tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.6 alpha:0.8]];
    UILabel *titleHeader=[[UILabel alloc]initWithFrame:CGRectMake(10,0, 300, 20)];
    if (tableView.tag==10000) {
        titleHeader.text=@"Archivos";
    }
    else if(tableView.tag==10001){
        if (metarSwitch.on && notamSwitch.on) {
            if (section==0) {
                //titleHeader.text= [NSString stringWithFormat:@"%i Metar disponibles",rightTableMetarArray.count];
                titleHeader.text= [NSString stringWithFormat:@"%i Metar disponibles",rightTableMetarArrayParcial.count];
                
            }
            else if(section==1){
                //titleHeader.text= [NSString stringWithFormat:@"%i Notam disponibles",rightTableNotamArray.count];
                titleHeader.text= [NSString stringWithFormat:@"%i Notam disponibles",rightTableNotamArrayParcial.count];
                
            }
        }
        else if (metarSwitch.on && !notamSwitch.on){
            //titleHeader.text= [NSString stringWithFormat:@"%i Metar disponibles",rightTableMetarArray.count];
            titleHeader.text= [NSString stringWithFormat:@"%i Metar disponibles",rightTableMetarArrayParcial.count];
            
        }
        else if (!metarSwitch.on && notamSwitch.on){
            //titleHeader.text= [NSString stringWithFormat:@"%i Notam disponibles",rightTableNotamArray.count];
            titleHeader.text= [NSString stringWithFormat:@"%i Notam disponibles",rightTableNotamArrayParcial.count];
        }
        else{
            titleHeader.text=@"";
        }
    }
    else{
        titleHeader.text=@"";
    }
    
    titleHeader.textColor=[UIColor whiteColor];
    titleHeader.backgroundColor=[UIColor clearColor];
    [headerView addSubview:titleHeader];
    
    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (tableView.tag==10001) {
        if (notamSwitch.on && metarSwitch.on) {
            return 2;
        }
        else if(!notamSwitch.on && !metarSwitch.on){
            return 0;
        }
        else{
            return 1;
        }
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger rows=0;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        // if (tableView.tag==1002) {
        rows=[leftStaticArray count];
        //}
    }
    else{
        if (tableView.tag==10000) {
            rows= leftTableArray.count;
        }
        else if(tableView.tag==10001){
            if (metarSwitch.on && notamSwitch.on) {
                if (section==0) {
                    //rows= rightTableMetarArray.count;
                    rows= rightTableMetarArrayParcial.count;
                }
                else if (section==1){
                    //rows= rightTableNotamArray.count;
                    rows= rightTableNotamArrayParcial.count;
                }
            }
            else if (metarSwitch.on && !notamSwitch.on){
                if (section==0) {
                    //rows= rightTableMetarArray.count;
                    rows= rightTableMetarArrayParcial.count;
                }
            }
            else if (!metarSwitch.on && notamSwitch.on){
                if (section==0) {
                    //rows= rightTableNotamArray.count;
                    rows= rightTableNotamArrayParcial.count;
                }
            }
            
        }
    }
    
    return rows;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==10001) {
        if (metarSwitch.on && notamSwitch.on) {
            if (indexPath.section==0) {
                return 40;
            }
            else if (indexPath.section==1){
                return 60;
            }
        }
        else if (metarSwitch.on && !notamSwitch.on){
            if (indexPath.section==0) {
                return 40;
            }
        }
        else if (!metarSwitch.on && notamSwitch.on){
            if (indexPath.section==0) {
                return 60;
            }
        }
    }
    return 50;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (metarSwitch.on && notamSwitch.on) {
            if (indexPath.section==0) {
                //iaVC.delegatedString=[rightTableMetarArray objectAtIndex:indexPath.row];
                [rightTableMetarArrayParcial removeObjectAtIndex:indexPath.row];
                
            }
            else if (indexPath.section==1){
                //iaVC.delegatedString=[rightTableNotamArray objectAtIndex:indexPath.row];
                [rightTableNotamArrayParcial removeObjectAtIndex:indexPath.row];
            }
        }
        else if (metarSwitch.on && !notamSwitch.on){
            if (indexPath.section==0) {
                //iaVC.delegatedString=[rightTableMetarArray objectAtIndex:indexPath.row];
                [rightTableMetarArrayParcial removeObjectAtIndex:indexPath.row];
            }
        }
        else if(!metarSwitch.on && notamSwitch.on){
            if (indexPath.section==0) {
                //iaVC.delegatedString=[rightTableNotamArray objectAtIndex:indexPath.row];
                [rightTableNotamArrayParcial removeObjectAtIndex:indexPath.row];
            }
        }
        [tableView reloadData];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"id1";
    
    UITableViewCell *celda = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (celda == nil) {
        celda = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [celda setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        celda.textLabel.text=[[[[[[leftStaticArray objectAtIndex:indexPath.row]stringByReplacingOccurrencesOfString:@".doc" withString:@""]stringByReplacingOccurrencesOfString:@".pptx" withString:@""]stringByReplacingOccurrencesOfString:@".ppt" withString:@""]stringByReplacingOccurrencesOfString:@".pdf" withString:@""]stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
    }
    else{
        if (tableView.tag==10000) {
            celda.textLabel.textColor=[UIColor darkGrayColor];
            Archivo *archivo=[leftTableArray objectAtIndex:indexPath.row];
            NSString *tempStringTruncated=[[[[[archivo.nombre stringByReplacingOccurrencesOfString:@".doc" withString:@""]stringByReplacingOccurrencesOfString:@".pptx" withString:@""]stringByReplacingOccurrencesOfString:@".ppt" withString:@""]stringByReplacingOccurrencesOfString:@".pdf" withString:@""]stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
            celda.textLabel.text=tempStringTruncated;
            if ([archivo.mime isEqualToString:@".ppt"]) {
                celda.imageView.image=[UIImage imageNamed:@"ppticon.png"];
            }
            else if ([archivo.mime isEqualToString:@".jpg"]){
                celda.imageView.image=[UIImage imageNamed:@"jpg.png"];
            }
            else if ([archivo.mime isEqualToString:@".pptx"]){
                celda.imageView.image=[UIImage imageNamed:@"ppticon.png"];
            }
            else if ([archivo.mime isEqualToString:@".doc"]){
                celda.imageView.image=[UIImage imageNamed:@"docicon.png"];
            }
            else if ([archivo.mime isEqualToString:@".pdf"]){
                celda.imageView.image=[UIImage imageNamed:@"pdficon.png"];
            }
        }
        else if(tableView.tag==10001){
            if (metarSwitch.on && notamSwitch.on) {
                if (indexPath.section==0) {
                    //celda.textLabel.text=[rightTableMetarArray objectAtIndex:indexPath.row];
                    celda.textLabel.text=[rightTableMetarArrayParcial objectAtIndex:indexPath.row];
                    celda.textLabel.font=[UIFont systemFontOfSize:12];
                    celda.textLabel.numberOfLines=3;
                }
                else if(indexPath.section==1){
                    //celda.textLabel.text=[rightTableNotamArray objectAtIndex:indexPath.row];
                    celda.textLabel.text=[rightTableNotamArrayParcial objectAtIndex:indexPath.row];
                    celda.textLabel.font=[UIFont systemFontOfSize:12];
                    celda.textLabel.numberOfLines=3;
                }
            }
            else if (metarSwitch.on && !notamSwitch.on){
                if (indexPath.section==0) {
                    //celda.textLabel.text=[rightTableMetarArray objectAtIndex:indexPath.row];
                    celda.textLabel.text=[rightTableMetarArrayParcial objectAtIndex:indexPath.row];
                    
                    celda.textLabel.font=[UIFont systemFontOfSize:12];
                    celda.textLabel.numberOfLines=3;
                }
            }
            else if (!metarSwitch.on && notamSwitch.on)
                if (indexPath.section==0) {
                    //celda.textLabel.text=[rightTableNotamArray objectAtIndex:indexPath.row];
                    celda.textLabel.text=[rightTableNotamArrayParcial objectAtIndex:indexPath.row];
                    
                    celda.textLabel.font=[UIFont systemFontOfSize:12];
                    celda.textLabel.numberOfLines=3;
                }
        }
    }
    return celda;
}

- (void)filterContentForSearchText:(NSString*)searchText
                             scope:(NSString*)scope{
    NSPredicate *resultPredicate=[NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
    NSMutableArray *arraySearch=[[NSMutableArray alloc]init];
    for (Archivo *archivo in leftTableArray) {
        [arraySearch addObject:archivo.nombre];
    }
    leftStaticArray = [arraySearch filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark uisearchdisplay controller delegate
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:searchOption]];
    return YES;
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView  {
    searchDisplayController.searchResultsTableView.tag=10002;
    tableView.frame = leftTableView.frame;
}

#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==10000||tableView.tag==10002) {
        //NSLog(@"Touched cell in left tableview");
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //Archivo *archivo=[leftTableArray objectAtIndex:indexPath.row];
        NSString *path=@"";
        for (Archivo *archivo in leftTableArray) {
            NSString *tempStringTruncated=[[[[[archivo.nombre stringByReplacingOccurrencesOfString:@".doc" withString:@""]stringByReplacingOccurrencesOfString:@".pptx" withString:@""]stringByReplacingOccurrencesOfString:@".ppt" withString:@""]stringByReplacingOccurrencesOfString:@".pdf" withString:@""]stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
            //NSLog(@"Cell %@ vs archivo %@",cell.textLabel.text,tempStringTruncated);
            if ([tempStringTruncated isEqualToString:cell.textLabel.text]) {
                path=archivo.rutaLocal;
                //NSLog(@"Archivo ruta local %@",path);
                break;
            }
        }
        [self loadLocalDocument:path inView:nil];
    }
    else if(tableView.tag==10001){
        DetailViewController *iaVC=[[DetailViewController alloc]init];
        iaVC=[self.storyboard instantiateViewControllerWithIdentifier:@"InfoAero"];
        iaVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        //iaVC.modalPresentationStyle = UIModalPresentationCurrentContext;
        iaVC.modalPresentationStyle = UIModalPresentationFormSheet;
        
        if (metarSwitch.on && notamSwitch.on) {
            if (indexPath.section==0) {
                //iaVC.delegatedString=[rightTableMetarArray objectAtIndex:indexPath.row];
                iaVC.delegatedString=[rightTableMetarArrayParcial objectAtIndex:indexPath.row];
                
            }
            else if (indexPath.section==1){
                //iaVC.delegatedString=[rightTableNotamArray objectAtIndex:indexPath.row];
                iaVC.delegatedString=[rightTableNotamArrayParcial objectAtIndex:indexPath.row];
            }
        }
        else if (metarSwitch.on && !notamSwitch.on){
            if (indexPath.section==0) {
                //iaVC.delegatedString=[rightTableMetarArray objectAtIndex:indexPath.row];
                iaVC.delegatedString=[rightTableMetarArrayParcial objectAtIndex:indexPath.row];
            }
        }
        else if(!metarSwitch.on && notamSwitch.on){
            if (indexPath.section==0) {
                //iaVC.delegatedString=[rightTableNotamArray objectAtIndex:indexPath.row];
                iaVC.delegatedString=[rightTableNotamArrayParcial objectAtIndex:indexPath.row];
            }
        }
        [self.navigationController presentViewController:iaVC animated:YES completion:nil];
        //[self.navigationController pushViewController:iaVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark notification center receiver
-(void)archivoSuccess:(NSNotification*)notification{
    NSDictionary *diccionario=notification.object;
    [leftTableArray removeAllObjects];
    for (NSDictionary *dic in [diccionario objectForKey:@"ArregloDeArchivos"]) {
        Archivo *archivo=[[Archivo alloc]initWithDictionary:dic];
        [leftTableArray addObject:archivo];
        //NSLog(@"cantidad");
    }
    //NSLog(@"Left array %@",diccionario);
    [leftTableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)archivoError:(NSNotification*)notification{
    //NSLog(@"Error %@",notification.object);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark delayed hud
-(void)changeTextToHudAndHideWithDelay:(NSString*)text{
    hud.labelText=text;
    [self performSelector:@selector(hideHud) withObject:nil afterDelay:2.0];
}
-(void)hideHud{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark metarNotam verification
-(void)actualizarTablaConPeticionDeString:(NSString*)stringBusqueda{
    if (!conservarSwitch.on) {
        [rightTableMetarArrayParcial removeAllObjects];
        [rightTableNotamArrayParcial removeAllObjects];
    }
    for (NSString *string in rightTableMetarArray) {
        //NSLog(@"String es %@",string);
        if ([string rangeOfString:stringBusqueda].location != NSNotFound) {
            if (![rightTableMetarArrayParcial containsObject:string]) {
                [rightTableMetarArrayParcial addObject:string];
            }
        }
    }
    for (NSString *string in rightTableMetarArray) {
        for (Piernas *pierna in ordenDeVuelo.arregloDePiernas) {
            if ([string rangeOfString:pierna.de].location != NSNotFound) {
                if (![rightTableMetarArrayParcial containsObject:string]) {
                    [rightTableMetarArrayParcial addObject:string];
                }
            }
            if ([pierna.de isEqualToString:pierna.a]) {
                break;
            }
            if ([string rangeOfString:pierna.a].location != NSNotFound) {
                if (![rightTableMetarArrayParcial containsObject:string]) {
                    [rightTableMetarArrayParcial addObject:string];
                }
            }
        }
    }
    for (NSString *string in rightTableNotamArray) {
        if ([string rangeOfString:stringBusqueda].location !=NSNotFound) {
            if (![rightTableNotamArrayParcial containsObject:string]) {
                [rightTableNotamArrayParcial addObject:string];
            }
        }
    }
    for (NSString *string in rightTableNotamArray) {
        for (Piernas *pierna in ordenDeVuelo.arregloDePiernas) {
            if ([string rangeOfString:pierna.de].location != NSNotFound) {
                if (![rightTableNotamArrayParcial containsObject:string]) {
                    [rightTableNotamArrayParcial addObject:string];
                }
            }
            if ([pierna.de isEqualToString:pierna.a]) {
                break;
            }
            if ([string rangeOfString:pierna.a].location != NSNotFound) {
                if (![rightTableNotamArrayParcial containsObject:string]) {
                    [rightTableNotamArrayParcial addObject:string];
                }
            }
        }
    }
    [rightTableView reloadData];
    [ovTF resignFirstResponder];
    [matriTF resignFirstResponder];
}
@end
