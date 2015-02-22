//
//  CeldaTeplasSanidad.h
//  FuerzaAerea
//
//  Created by Andres Abril on 17/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Lista.h"
@interface CeldaTeplasSanidad : UIView{
    Lista *lista;
}
@property(nonatomic,retain)UITextField *cargoTextField;
@property(nonatomic,retain)UITextField *nombreTextiField;
@property(nonatomic,retain)UITextField *codigoTextField;
@property(nonatomic,retain)UITextField *gradoTextField;
@property(nonatomic,retain)UITextField *maniobraTextField;
@property(nonatomic,retain)UITextField *cantidadTextfield;

@property(nonatomic,retain)NSString *idPersona;
@property(nonatomic,retain)NSString *idManiobra;


-(id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate withType:(NSString*)type;
-(id)initHeaderWithFrame:(CGRect)frame;
@end