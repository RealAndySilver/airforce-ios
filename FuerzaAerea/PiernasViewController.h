//
//  PiernasViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModeladorDeOrdenDeVuelo.h"
#import "PiernasCell.h"
#import "DetailViewController.h"
@interface PiernasViewController : UIViewController{
    IBOutlet UILabel *unidadLabel;
    IBOutlet UILabel *unidadAsumeLabel;
    IBOutlet UILabel *ordenLabel;
    IBOutlet UITextView *piernasTextView;
}
@property(nonatomic,retain)ModeladorDeOrdenDeVuelo *ordenDeVuelo;

@end
