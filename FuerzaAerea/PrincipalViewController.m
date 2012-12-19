//
//  PrincipalViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "PrincipalViewController.h"

@interface PrincipalViewController ()

@end

@implementation PrincipalViewController
@synthesize ordenDeVuelo;


- (void)viewDidLoad
{
    [super viewDidLoad];
    unidadLabel.text=ordenDeVuelo.principal.unidad;
    unidadAsumeLabel.text=ordenDeVuelo.principal.unidadAsume;
    ordenLabel.text=ordenDeVuelo.principal.idOrdenVuelo;
    instruccionesTextView.text=ordenDeVuelo.principal.instrucciones;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark button actions
-(IBAction)buttonPressed:(UIButton*)sender{
    if (sender.tag==5) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSLog(@"Button %i pressed",sender.tag);
}
@end
