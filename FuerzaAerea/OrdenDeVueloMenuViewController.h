//
//  OrdenDeVueloMenuViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModeladorDeOrdenDeVuelo.h"
#import "ArmamentoViewController.h"
#import "PiernasViewController.h"
#import "PrincipalViewController.h"
#import "TripulacionViewController.h"
#import "PiernasTableSubView.h"
#import "ArmamentoTableSubView.h"
#import "TripulacionTableSubView.h"
#import "TeplasTableSubView.h"
#import "SanidadSubView.h"
@interface OrdenDeVueloMenuViewController : UIViewController<UIScrollViewDelegate>{
    IBOutlet UILabel *unidadLabel;
    IBOutlet UILabel *unidadAsumeLabel;
    IBOutlet UILabel *ordenLabel;
    IBOutlet UILabel *fechaLabel;
    IBOutlet UILabel *horaDespegueLabel;
    IBOutlet UILabel *noFacLabel;
    IBOutlet UILabel *equipoLabel;
    IBOutlet UILabel *colaLabel;
    IBOutlet UILabel *itinerarioLabel;
    IBOutlet UILabel *combustibleLabel;
    IBOutlet UILabel *consecutivoLabel;
    
    IBOutlet UIButton *armamentoButton;
    IBOutlet UIButton *piernasButton;
    IBOutlet UIButton *principalButton;
    IBOutlet UIButton *tripulacionButton;
    IBOutlet UIButton *teplasButton;
    IBOutlet UIButton *sanidadButton;
    
    IBOutlet UIScrollView *pageScrollView;


}
@property(nonatomic,retain)ModeladorDeOrdenDeVuelo *ordenDeVuelo;
@end
