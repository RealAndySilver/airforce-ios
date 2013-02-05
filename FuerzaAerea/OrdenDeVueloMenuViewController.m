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

@end
