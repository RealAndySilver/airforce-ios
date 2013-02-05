//
//  CeldaArmamento.m
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "CeldaArmamento.h"

@implementation CeldaArmamento
@synthesize armamentoTextField,cantidadFallidoTextField,cantidadTextiField,coordenadaTextField,departamentoTextfield,enemigoTextField,objetivoTextField;

- (id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 964, 34);
        self.backgroundColor=[UIColor clearColor];
        int margen=7;
        UIView *bordeSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        bordeSuperior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeSuperior];
        
        UIView *bordeInferior=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        bordeInferior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeInferior];
        
        UIFont *font=[UIFont fontWithName:@"Helvetica" size:10];
        
        armamentoTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 2, 130, 30)];
        armamentoTextField.borderStyle = UITextBorderStyleRoundedRect;
        armamentoTextField.delegate=self;
        armamentoTextField.textColor=[UIColor blackColor];
        armamentoTextField.font=font;
        armamentoTextField.tag=100;
        [self addSubview:armamentoTextField];
        
        cantidadTextiField=[[UITextField alloc]initWithFrame:CGRectMake(130+margen*2, 2, 50, 30)];
        cantidadTextiField.borderStyle = UITextBorderStyleRoundedRect;
        cantidadTextiField.delegate=self;
        cantidadTextiField.textColor=[UIColor blackColor];
        cantidadTextiField.font=font;
        cantidadTextiField.tag=100;
        [self addSubview:cantidadTextiField];
        
        cantidadFallidoTextField=[[UITextField alloc]initWithFrame:CGRectMake(177+margen*3, 2, 50, 30)];
        cantidadFallidoTextField.borderStyle = UITextBorderStyleRoundedRect;
        cantidadFallidoTextField.delegate=self;
        cantidadFallidoTextField.textColor=[UIColor blackColor];
        cantidadFallidoTextField.font=font;
        cantidadFallidoTextField.tag=100;
        [self addSubview:cantidadFallidoTextField];
        
        objetivoTextField=[[UITextField alloc]initWithFrame:CGRectMake(225+margen*4, 2, 150, 30)];
        objetivoTextField.borderStyle = UITextBorderStyleRoundedRect;
        objetivoTextField.delegate=self;
        objetivoTextField.textColor=[UIColor blackColor];
        objetivoTextField.font=font;
        objetivoTextField.tag=100;
        [self addSubview:objetivoTextField];
        
        coordenadaTextField=[[UITextField alloc]initWithFrame:CGRectMake(375+margen*5, 2, 140, 30)];
        coordenadaTextField.borderStyle = UITextBorderStyleRoundedRect;
        coordenadaTextField.delegate=self;
        coordenadaTextField.textColor=[UIColor blackColor];
        coordenadaTextField.font=font;
        coordenadaTextField.tag=100;
        [self addSubview:coordenadaTextField];
        
        departamentoTextfield=[[UITextField alloc]initWithFrame:CGRectMake(510+margen*6, 2, 140, 30)];
        departamentoTextfield.borderStyle = UITextBorderStyleRoundedRect;
        departamentoTextfield.delegate=self;
        departamentoTextfield.textColor=[UIColor blackColor];
        departamentoTextfield.font=font;
        departamentoTextfield.tag=100;
        [self addSubview:departamentoTextfield];
        
        enemigoTextField=[[UITextField alloc]initWithFrame:CGRectMake(650+margen*7, 2, 200, 30)];
        enemigoTextField.borderStyle = UITextBorderStyleRoundedRect;
        enemigoTextField.delegate=self;
        enemigoTextField.textColor=[UIColor blackColor];
        enemigoTextField.font=font;
        enemigoTextField.tag=100;
        [self addSubview:enemigoTextField];
        
        
    }
    return self;
}
- (id)initHeaderWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        int altura=33;
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 964, altura);
        UIColor *bgColor=[UIColor clearColor];
        UIColor *textColor=[UIColor blackColor];
        NSTextAlignment alignment=NSTextAlignmentCenter;
        self.backgroundColor=[UIColor clearColor];
        int margen=7;
        
        //UIFont *font=[UIFont fontWithName:@"Helvetica" size:8];
        UIFont *font=[UIFont boldSystemFontOfSize:10];
        //UIColor *fontColor=[UIColor blackColor];
        
        UILabel *armamentoLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 130, 30)];
        armamentoLabel.backgroundColor=bgColor;
        armamentoLabel.textColor=textColor;
        armamentoLabel.textAlignment=alignment;
        armamentoLabel.font=font;
        armamentoLabel.text=@"Armamento";
        [self addSubview:armamentoLabel];
        
        UILabel *cantidadLabel=[[UILabel alloc]initWithFrame:CGRectMake(130+margen*2, 2, 50, 30)];
        cantidadLabel.backgroundColor=bgColor;
        cantidadLabel.textColor=textColor;
        cantidadLabel.textAlignment=alignment;
        cantidadLabel.font=font;
        cantidadLabel.text=@"Cantidad";
        [self addSubview:cantidadLabel];
        
        UILabel *cantidadFallidaLabel=[[UILabel alloc]initWithFrame:CGRectMake(177+margen*3, 2, 50, 30)];
        cantidadFallidaLabel.backgroundColor=bgColor;
        cantidadFallidaLabel.textColor=textColor;
        cantidadFallidaLabel.textAlignment=alignment;
        cantidadLabel.numberOfLines=2;
        cantidadFallidaLabel.font=font;
        cantidadFallidaLabel.text=@"Cnt.\nFallida";
        
        [self addSubview:cantidadFallidaLabel];
        
        UILabel *objetivoLabel=[[UILabel alloc]initWithFrame:CGRectMake(225+margen*4, 2, 150, 30)];
        objetivoLabel.backgroundColor=bgColor;
        objetivoLabel.textColor=textColor;
        objetivoLabel.textAlignment=alignment;
        objetivoLabel.font=font;
        objetivoLabel.text=@"Objetivo";
        objetivoLabel.numberOfLines=2;
        [self addSubview:objetivoLabel];
        
        UILabel *coordenadaLabel=[[UILabel alloc]initWithFrame:CGRectMake(375+margen*5, 2, 140, 30)];
        coordenadaLabel.backgroundColor=bgColor;
        coordenadaLabel.textColor=textColor;
        coordenadaLabel.textAlignment=alignment;
        coordenadaLabel.font=font;
        coordenadaLabel.text=@"Coordenada";
        coordenadaLabel.numberOfLines=2;
        [self addSubview:coordenadaLabel];
        
        UILabel *departamentoLabel=[[UILabel alloc]initWithFrame:CGRectMake(510+margen*6, 2, 140, 30)];
        departamentoLabel.backgroundColor=bgColor;
        departamentoLabel.textColor=textColor;
        departamentoLabel.textAlignment=alignment;
        departamentoLabel.font=font;
        departamentoLabel.text=@"Departamento";
        departamentoLabel.numberOfLines=2;
        [self addSubview:departamentoLabel];
        
        UILabel *enemigoLabel=[[UILabel alloc]initWithFrame:CGRectMake(650+margen*7, 2, 200, 30)];
        enemigoLabel.backgroundColor=bgColor;
        enemigoLabel.textColor=textColor;
        enemigoLabel.textAlignment=alignment;
        enemigoLabel.font=font;
        enemigoLabel.text=@"Enemigo";
        enemigoLabel.numberOfLines=2;
        [self addSubview:enemigoLabel];
    }
    return self;
}

@end
