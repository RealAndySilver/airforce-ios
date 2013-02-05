//
//  CeldaArmamento.h
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CeldaArmamento : UIView<UITextFieldDelegate>{
    
}
@property(nonatomic,retain)UITextField *armamentoTextField;
@property(nonatomic,retain)UITextField *cantidadTextiField;
@property(nonatomic,retain)UITextField *cantidadFallidoTextField;
@property(nonatomic,retain)UITextField *objetivoTextField;
@property(nonatomic,retain)UITextField *coordenadaTextField;
@property(nonatomic,retain)UITextField *departamentoTextfield;
@property(nonatomic,retain)UITextField *enemigoTextField;

-(id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate;
-(id)initHeaderWithFrame:(CGRect)frame;
@end