//
//  PrincipalViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModeladorDeOrdenDeVuelo.h"
@interface PrincipalViewController : UIViewController{
    IBOutlet UILabel *unidadLabel;
    IBOutlet UILabel *unidadAsumeLabel;
    IBOutlet UILabel *ordenLabel;
    
    IBOutlet UITextView *instruccionesTextView;

}
@property(nonatomic,retain)ModeladorDeOrdenDeVuelo *ordenDeVuelo;

@end
