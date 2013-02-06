//
//  OrdenDeVueloMenuViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "OrdenDeVueloMenuViewController.h"

@interface OrdenDeVueloMenuViewController ()

@end

@implementation OrdenDeVueloMenuViewController
@synthesize ordenDeVuelo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    unidadLabel.text=ordenDeVuelo.principal.unidad;
    unidadAsumeLabel.text=ordenDeVuelo.principal.unidadAsume;
    ordenLabel.text=ordenDeVuelo.principal.idConsecutivoUnidad;
    fechaLabel.text=ordenDeVuelo.principal.fecha;
    horaDespegueLabel.text=ordenDeVuelo.principal.horaDespegue;
    noFacLabel.text=ordenDeVuelo.principal.matricula;
    equipoLabel.text=ordenDeVuelo.principal.equipo;
    colaLabel.text=ordenDeVuelo.principal.imprimirCola;
    itinerarioLabel.text=ordenDeVuelo.principal.itinerario;
    [itinerarioLabel setAdjustsFontSizeToFitWidth:YES];
    combustibleLabel.text=ordenDeVuelo.principal.combustible;
    consecutivoLabel.text=ordenDeVuelo.principal.idConsecutivoUnidad;
    [self crearPaginas];
    [self seleccionarBoton:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark button actions
-(IBAction)buttonPressed:(UIButton*)sender{
    if (sender.tag==1) {
        ArmamentoViewController *aVC=[[ArmamentoViewController alloc]init];
        aVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Armamento"];
        aVC.ordenDeVuelo=ordenDeVuelo;
        [self.navigationController pushViewController:aVC animated:YES];
    }
    else if (sender.tag==2) {
        PiernasViewController *pVC=[[PiernasViewController alloc]init];
        pVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Piernas"];
        pVC.ordenDeVuelo=ordenDeVuelo;
        [self.navigationController pushViewController:pVC animated:YES];
    }
    else if (sender.tag==3) {
        PrincipalViewController *pVC=[[PrincipalViewController alloc]init];
        pVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Principal"];
        pVC.ordenDeVuelo=ordenDeVuelo;
        [self.navigationController pushViewController:pVC animated:YES];
    }
    else if (sender.tag==4) {
        TripulacionViewController *tVC=[[TripulacionViewController alloc]init];
        tVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Tripulacion"];
        tVC.ordenDeVuelo=ordenDeVuelo;
        [self.navigationController pushViewController:tVC animated:YES];
    }
    else if (sender.tag==5) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    //NSLog(@"Button %i pressed",sender.tag);
}
#pragma mark - crear paginas
-(void)crearPaginas{
    int numeroPaginas=4;
    [pageScrollView setPagingEnabled:YES];
    pageScrollView.delegate=self;
    pageScrollView.contentSize=CGSizeMake(pageScrollView.frame.size.width*numeroPaginas, pageScrollView.frame.size.height);
    [pageScrollView setShowsHorizontalScrollIndicator:NO];
    
    [self crearPaginaUno];
    [self crearPaginaDos];
    [self crearPaginaTres];
    [self crearPaginaCuatro];
}
-(void)crearPaginaUno{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*0, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    view.backgroundColor=[UIColor clearColor];
    [pageScrollView addSubview:view];
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, 30)];
    header.backgroundColor=[UIColor colorWithRed:0.4 green:0.8 blue:0.9 alpha:1];
    [view addSubview:header];

    UITextView *tf=[[UITextView alloc]initWithFrame:CGRectMake(0, 30, pageScrollView.frame.size.width-0, pageScrollView.frame.size.height-30)];
    //tf.text=@"Ahjkdsflkj fdshjklf hfd lfhds hjklsadf lkjhsdf hjkdsf hjksdlf lksjdhf hsdjf hjkasldfkjhdf ";
    tf.font=[UIFont fontWithName:@"Helvetica" size:20];
    [tf setEditable:NO];
    [tf setAlwaysBounceVertical:YES];
    tf.backgroundColor=[UIColor darkGrayColor];
    tf.textColor=[UIColor whiteColor];
    tf.text=ordenDeVuelo.principal.instrucciones;
    [view addSubview:tf];
}
-(void)crearPaginaDos{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*1, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [pageScrollView addSubview:view];
    PiernasTableSubView *piernasSubView=[[PiernasTableSubView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*1, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height) ordenDeVuelo:ordenDeVuelo yCaller:self];
    [pageScrollView addSubview:piernasSubView];

}
-(void)crearPaginaTres{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*2, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [pageScrollView addSubview:view];
    ArmamentoTableSubView *armamentoSubView=[[ArmamentoTableSubView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*2, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height) ordenDeVuelo:ordenDeVuelo yCaller:self];
    [pageScrollView addSubview:armamentoSubView];

}
-(void)crearPaginaCuatro{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*3, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [pageScrollView addSubview:view];
    TripulacionTableSubView *tripulacionSubView=[[TripulacionTableSubView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*3, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height) ordenDeVuelo:ordenDeVuelo yCaller:self];
    [pageScrollView addSubview:tripulacionSubView];
}
-(UIView*)containerCreatorInPosition:(int)position{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(pageScrollView.frame.size.width*position, 0, pageScrollView.frame.size.width, pageScrollView.frame.size.height)];
    view.backgroundColor=[UIColor yellowColor];
    [pageScrollView addSubview:view];
    return view;
}
#pragma mark - hilight method
-(void)seleccionarBoton:(int)numeroDeBoton{
    UIColor *colorNormal=[UIColor grayColor];
    UIColor *colorHilight=[UIColor blueColor];
    switch (numeroDeBoton) {
        case 1:
            [principalButton setBackgroundColor:colorHilight];
            [piernasButton setBackgroundColor:colorNormal];
            [armamentoButton setBackgroundColor:colorNormal];
            [tripulacionButton setBackgroundColor:colorNormal];
            [principalButton setHighlighted:YES];
            [piernasButton setHighlighted:NO];
            [armamentoButton setHighlighted:NO];
            [tripulacionButton setHighlighted:NO];
            break;
        case 2:
            [principalButton setBackgroundColor:colorNormal];
            [piernasButton setBackgroundColor:colorHilight];
            [armamentoButton setBackgroundColor:colorNormal];
            [tripulacionButton setBackgroundColor:colorNormal];
            [principalButton setHighlighted:NO];
            [piernasButton setHighlighted:YES];
            [armamentoButton setHighlighted:NO];
            [tripulacionButton setHighlighted:NO];
            break;
        case 3:
            [principalButton setBackgroundColor:colorNormal];
            [piernasButton setBackgroundColor:colorNormal];
            [armamentoButton setBackgroundColor:colorHilight];
            [tripulacionButton setBackgroundColor:colorNormal];
            [principalButton setHighlighted:NO];
            [piernasButton setHighlighted:NO];
            [armamentoButton setHighlighted:YES];
            [tripulacionButton setHighlighted:NO];
            break;
        case 4:
            [principalButton setBackgroundColor:colorNormal];
            [piernasButton setBackgroundColor:colorNormal];
            [armamentoButton setBackgroundColor:colorNormal];
            [tripulacionButton setBackgroundColor:colorHilight];
            [principalButton setHighlighted:NO];
            [piernasButton setHighlighted:NO];
            [armamentoButton setHighlighted:NO];
            [tripulacionButton setHighlighted:YES];
            break;
            
        default:
            break;
    }
    
    
}
#pragma mark - scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGRect frame=[[UIScreen mainScreen] applicationFrame];
    float roundedValue = round(pageScrollView.contentOffset.x / frame.size.height);
    [self seleccionarBoton:roundedValue+1];
}
#pragma mark - ibactions

-(IBAction)instrucciones:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 0, 0.0f) animated:YES];
    [self seleccionarBoton:1];
}
-(IBAction)piernas:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 1, 0.0f) animated:YES];
    [self seleccionarBoton:2];
}
-(IBAction)armamento:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 2, 0.0f) animated:YES];
    [self seleccionarBoton:3];
}
-(IBAction)tripulacion:(id)sender{
    [pageScrollView setContentOffset:CGPointMake(pageScrollView.frame.size.width * 3, 0.0f) animated:YES];
    [self seleccionarBoton:4];
}
@end
