//
//  CeldaTripulacion.h
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface CeldaTripulacion : UIView<UITextFieldDelegate>{
    
}
@property(nonatomic,retain)UITextField *cargoTextField;
@property(nonatomic,retain)UITextField *nombreTextiField;
@property(nonatomic,retain)UITextField *codigoTextField;
@property(nonatomic,retain)UITextField *gradoTextField;
@property(nonatomic,retain)UITextField *maniobraTextField;
@property(nonatomic,retain)UITextField *cantidadTextfield;

-(id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate;
-(id)initHeaderWithFrame:(CGRect)frame;
-(id)initEntrenamientoWithFrame:(CGRect)frame;
@end