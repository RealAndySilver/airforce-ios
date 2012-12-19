//
//  ArmamentoViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModeladorDeOrdenDeVuelo.h"
#import "PiernasCell.h"
@interface ArmamentoViewController : UIViewController{
    IBOutlet UILabel *unidadLabel;
    IBOutlet UILabel *unidadAsumeLabel;
    IBOutlet UILabel *ordenLabel;
}
@property(nonatomic,retain)ModeladorDeOrdenDeVuelo *ordenDeVuelo;

@end
