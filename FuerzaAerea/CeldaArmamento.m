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
@synthesize idArmamento,idEnemigo,idObjetivo;

- (id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        lista=myDelegate;
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
        cantidadTextiField.keyboardType=UIKeyboardTypePhonePad;
        cantidadTextiField.textColor=[UIColor blackColor];
        cantidadTextiField.font=font;
        cantidadTextiField.tag=100;
        [self addSubview:cantidadTextiField];
        
        cantidadFallidoTextField=[[UITextField alloc]initWithFrame:CGRectMake(177+margen*3, 2, 50, 30)];
        cantidadFallidoTextField.borderStyle = UITextBorderStyleRoundedRect;
        cantidadFallidoTextField.delegate=self;
        cantidadFallidoTextField.keyboardType=UIKeyboardTypePhonePad;
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
        coordenadaTextField.backgroundColor=[UIColor lightGrayColor];
        coordenadaTextField.tag=100;
        [coordenadaTextField setUserInteractionEnabled:NO];
        [self addSubview:coordenadaTextField];
        
        departamentoTextfield=[[UITextField alloc]initWithFrame:CGRectMake(510+margen*6, 2, 140, 30)];
        departamentoTextfield.borderStyle = UITextBorderStyleRoundedRect;
        departamentoTextfield.delegate=self;
        departamentoTextfield.textColor=[UIColor blackColor];
        departamentoTextfield.font=font;
        departamentoTextfield.tag=100;
        departamentoTextfield.backgroundColor=[UIColor lightGrayColor];
        [departamentoTextfield setUserInteractionEnabled:NO];
        [self addSubview:departamentoTextfield];
        
        enemigoTextField=[[UITextField alloc]initWithFrame:CGRectMake(650+margen*7, 2, 200, 30)];
        enemigoTextField.borderStyle = UITextBorderStyleRoundedRect;
        enemigoTextField.delegate=self;
        enemigoTextField.textColor=[UIColor blackColor];
        enemigoTextField.font=font;
        enemigoTextField.tag=100;
        [self addSubview:enemigoTextField];
        
        UIButton *validateButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [validateButton setBackgroundImage:[UIImage imageNamed:@"atras.png"] forState:UIControlStateNormal];
        [validateButton setTitle:@"Borrar" forState:UIControlStateNormal];
        validateButton.frame=CGRectMake(830+margen*11, 2, 50, 30);
        validateButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:10];
        [validateButton addTarget:self action:@selector(borrar) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:validateButton];
        
        
        pickerArmamento=[[UIPickerView alloc]init];
        pickerArmamento.dataSource=self;
        pickerArmamento.delegate=self;
        pickerArmamento.showsSelectionIndicator = YES;
        pickerArmamento.tag=2001;
        if (lista.arregloDeArmamentos.count) {
            armamentoTextField.inputView=pickerArmamento;
        }
        
        
        pickerDepartamento=[[UIPickerView alloc]init];
        pickerDepartamento.dataSource=self;
        pickerDepartamento.delegate=self;
        pickerDepartamento.showsSelectionIndicator = YES;
        pickerDepartamento.tag=2002;
        if (lista.arregloDeDepartamentos.count) {
         departamentoTextfield.inputView=pickerDepartamento;
         }
        
        pickerEnemigo=[[UIPickerView alloc]init];
        pickerEnemigo.dataSource=self;
        pickerEnemigo.delegate=self;
        pickerEnemigo.showsSelectionIndicator = YES;
        pickerEnemigo.tag=2003;
        if (lista.arregloDeEnemigo.count) {
            enemigoTextField.inputView=pickerEnemigo;
        }
        
        pickerObjetivo=[[UIPickerView alloc]init];
        pickerObjetivo.dataSource=self;
        pickerObjetivo.delegate=self;
        pickerObjetivo.showsSelectionIndicator = YES;
        pickerObjetivo.tag=2004;
        if (lista.arregloDeObjetivo.count) {
         objetivoTextField.inputView=pickerObjetivo;
         }        
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

#pragma mark - picker delegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==2001) {
        return lista.arregloDeArmamentos.count;
    }
    else if (pickerView.tag==2002){
        return lista.arregloDeDepartamentos.count;
    }
    else if (pickerView.tag==2003){
        return lista.arregloDeEnemigo.count;
    }
    else if (pickerView.tag==2004){
        return lista.arregloDeObjetivo.count;
    }
    else{
        return 0;
    }
    return 0;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        if (pickerView.tag==2001) {
            Armamentos *result=[lista.arregloDeArmamentos objectAtIndex:row];
            NSString *strRes=result.armamento;
            return strRes;
        }
        else if (pickerView.tag==2002){
            Departamentos *result=[lista.arregloDeDepartamentos objectAtIndex:row];
            NSString *strRes=result.departamento;
            return strRes;
        }
        else if (pickerView.tag==2003){
            Enemigo *result=[lista.arregloDeEnemigo objectAtIndex:row];
             NSString *strRes=result.nombreOrganizacion;
             return strRes;
        }
        else if (pickerView.tag==2004){
            Objetivo *result=[lista.arregloDeObjetivo objectAtIndex:row];
             NSString *strRes=result.objetivo;
             return strRes;
        }
    }
    else{
        return nil;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        if (pickerView.tag==2001) {
            Armamentos *result=[lista.arregloDeArmamentos objectAtIndex:row];
            NSString *strRes=result.armamento;
            armamentoTextField.text=strRes;
            idArmamento=result.idArmamento;
            return;
        }
        else if (pickerView.tag==2002){
            Departamentos *result=[lista.arregloDeDepartamentos objectAtIndex:row];
            NSString *strRes=result.departamento;
            departamentoTextfield.text=strRes;
            return;
        }
        else if (pickerView.tag==2003){
            Enemigo *result=[lista.arregloDeEnemigo objectAtIndex:row];
            NSString *strRes=result.nombreOrganizacion;
            enemigoTextField.text=strRes;
            idEnemigo=result.idOrganizacion;
            return;
        }
        else if (pickerView.tag==2004){
            Objetivo *result=[lista.arregloDeObjetivo objectAtIndex:row];
            NSString *strRes=result.objetivo;
            objetivoTextField.text=strRes;
            departamentoTextfield.text=result.departamento;
            coordenadaTextField.text=result.coordenadas;
            idObjetivo=result.idBlanco;
            return;
        }
    }
    return;
    
}
#pragma mark - borrar
-(void)borrar{
    armamentoTextField.text=@"";
    cantidadFallidoTextField.text=@"";
    cantidadTextiField.text=@"";
    objetivoTextField.text=@"";
    coordenadaTextField.text=@"";
    departamentoTextfield.text=@"";
    enemigoTextField.text=@"";
    idArmamento=@"";
    idEnemigo=@"";
    idObjetivo=@"";
}
@end
