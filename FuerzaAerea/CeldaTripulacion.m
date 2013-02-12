//
//  CeldaTripulacion.m
//  FuerzaAerea
//
//  Created by Andres Abril on 30/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "CeldaTripulacion.h"

@implementation CeldaTripulacion
@synthesize cantidadTextfield,cargoTextField,codigoTextField,gradoTextField,maniobraTextField,nombreTextiField;
- (id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 480, 34);
        self.backgroundColor=[UIColor clearColor];
        self.layer.borderWidth=1.0;
        int margen=7;
        UIView *bordeSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        bordeSuperior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeSuperior];
        
        UIView *bordeInferior=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        bordeInferior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeInferior];
        
        UIFont *font=[UIFont fontWithName:@"Helvetica" size:10];
        
        cargoTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 2, 80, 30)];
        cargoTextField.borderStyle = UITextBorderStyleRoundedRect;
        cargoTextField.delegate=self;
        cargoTextField.textColor=[UIColor blackColor];
        cargoTextField.font=font;
        [cargoTextField setUserInteractionEnabled:NO];
        cargoTextField.tag=100;
        cargoTextField.textAlignment=NSTextAlignmentCenter;
        [self addSubview:cargoTextField];
        
        nombreTextiField=[[UITextField alloc]initWithFrame:CGRectMake(80+margen*2, 2, 250, 30)];
        nombreTextiField.borderStyle = UITextBorderStyleRoundedRect;
        nombreTextiField.delegate=self;
        nombreTextiField.textColor=[UIColor blackColor];
        nombreTextiField.font=font;
        [nombreTextiField setUserInteractionEnabled:NO];
        nombreTextiField.tag=100;
        [self addSubview:nombreTextiField];
        
        codigoTextField=[[UITextField alloc]initWithFrame:CGRectMake(325+margen*3, 2, 70, 30)];
        codigoTextField.borderStyle = UITextBorderStyleRoundedRect;
        codigoTextField.delegate=self;
        codigoTextField.textColor=[UIColor blackColor];
        codigoTextField.font=font;
        [codigoTextField setUserInteractionEnabled:NO];
        codigoTextField.tag=100;
        [self addSubview:codigoTextField];
        
        gradoTextField=[[UITextField alloc]initWithFrame:CGRectMake(390+margen*4, 2, 50, 30)];
        gradoTextField.borderStyle = UITextBorderStyleRoundedRect;
        gradoTextField.delegate=self;
        gradoTextField.textColor=[UIColor blackColor];
        gradoTextField.font=font;
        [gradoTextField setUserInteractionEnabled:NO];
        gradoTextField.tag=100;
        gradoTextField.textAlignment=NSTextAlignmentCenter;
        [self addSubview:gradoTextField];
        
        
        
    }
    return self;
}
-(id)initEntrenamientoWithFrame:(CGRect)frame andDelegate:(id)myDelegate{
    self = [super initWithFrame:frame];
    if (self) {
        lista=myDelegate;
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 380, 34);
        self.backgroundColor=[UIColor clearColor];
        self.layer.borderWidth=1.0;
        int margen=7;
        UIView *bordeSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        bordeSuperior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeSuperior];
        
        UIView *bordeInferior=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        bordeInferior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeInferior];
        
        UIFont *font=[UIFont fontWithName:@"Helvetica" size:10];
        
        maniobraTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 2, 200, 30)];
        maniobraTextField.borderStyle = UITextBorderStyleRoundedRect;
        maniobraTextField.delegate=self;
        maniobraTextField.textColor=[UIColor blackColor];
        maniobraTextField.font=font;
        maniobraTextField.tag=100;
        maniobraTextField.textAlignment=NSTextAlignmentCenter;
        [self addSubview:maniobraTextField];
        
        cantidadTextfield=[[UITextField alloc]initWithFrame:CGRectMake(210+margen*2, 2, 150, 30)];
        cantidadTextfield.borderStyle = UITextBorderStyleRoundedRect;
        cantidadTextfield.delegate=self;
        cantidadTextfield.textColor=[UIColor blackColor];
        cantidadTextfield.font=font;
        cantidadTextfield.tag=100;
        [self addSubview:cantidadTextfield];
        
        pickerManiobra=[[UIPickerView alloc]init];
        pickerManiobra.dataSource=self;
        pickerManiobra.delegate=self;
        pickerManiobra.showsSelectionIndicator = YES;
        pickerManiobra.tag=2001;
        if (lista.arregloDeManiobra.count) {
        maniobraTextField.inputView=pickerManiobra;
        }
        
    }
    return self;
}
-(id)initHeaderWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        int altura=33;
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 964, altura);
        UIColor *bgColor=[UIColor clearColor];
        self.backgroundColor=bgColor;
        int margen=7;
        
        //UIFont *font=[UIFont fontWithName:@"Helvetica" size:10];
        UIFont *font=[UIFont boldSystemFontOfSize:10];
        UIColor *fontColor=[UIColor blackColor];
        
        UILabel *tripulacionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, -8, 85, 30)];
        tripulacionLabel.text=@"Tripulacion";
        tripulacionLabel.numberOfLines=2;
        tripulacionLabel.font=[UIFont boldSystemFontOfSize:10];
        tripulacionLabel.textAlignment=NSTextAlignmentCenter;
        tripulacionLabel.backgroundColor=bgColor;
        tripulacionLabel.textColor=[UIColor grayColor];
        [self addSubview:tripulacionLabel];
        
        UILabel *cargoLabel=[[UILabel alloc]initWithFrame:CGRectMake(margen*1, 2, 85, 30)];
        cargoLabel.text=@"Cargo";
        cargoLabel.numberOfLines=2;
        cargoLabel.font=font;
        cargoLabel.textAlignment=NSTextAlignmentCenter;
        cargoLabel.backgroundColor=bgColor;
        cargoLabel.textColor=fontColor;
        [self addSubview:cargoLabel];
        
        UILabel *nombreLabel=[[UILabel alloc]initWithFrame:CGRectMake(80+margen*2, 2, 250, altura)];
        nombreLabel.text=@"Nombre";
        nombreLabel.font=font;
        nombreLabel.numberOfLines=2;
        nombreLabel.backgroundColor=bgColor;
        nombreLabel.textAlignment=NSTextAlignmentCenter;
        nombreLabel.textColor=fontColor;
        [self addSubview:nombreLabel];
        
        UILabel *codigoLabel=[[UILabel alloc]initWithFrame:CGRectMake(325+margen*3, 2, 70, 30)];
        codigoLabel.text=@"Código";
        codigoLabel.font=font;
        codigoLabel.numberOfLines=2;
        codigoLabel.backgroundColor=bgColor;
        codigoLabel.textAlignment=NSTextAlignmentCenter;
        codigoLabel.textColor=fontColor;
        [self addSubview:codigoLabel];
        
        
        UILabel *gradoLabel=[[UILabel alloc]initWithFrame:CGRectMake(388+margen*4, 2, 50, altura)];
        gradoLabel.text=@"Grado";
        gradoLabel.numberOfLines=2;
        gradoLabel.backgroundColor=bgColor;
        gradoLabel.font=font;
        gradoLabel.textAlignment=NSTextAlignmentCenter;
        gradoLabel.textColor=fontColor;
        [self addSubview:gradoLabel];
        
        UILabel *entrenamientoLabel=[[UILabel alloc]initWithFrame:CGRectMake(450+margen*5, -8, 200, altura)];
        entrenamientoLabel.text=@"Entrenamiento Continuado";
        entrenamientoLabel.numberOfLines=1;
        entrenamientoLabel.backgroundColor=bgColor;
        entrenamientoLabel.font=font;
        entrenamientoLabel.textAlignment=NSTextAlignmentCenter;
        entrenamientoLabel.textColor=[UIColor grayColor];
        [self addSubview:entrenamientoLabel];
        
        UILabel *maniobraLabel=[[UILabel alloc]initWithFrame:CGRectMake(550+margen*5, 2, 50, altura)];
        maniobraLabel.text=@"Maniobra";
        maniobraLabel.numberOfLines=2;
        maniobraLabel.backgroundColor=bgColor;
        maniobraLabel.font=font;
        maniobraLabel.textAlignment=NSTextAlignmentCenter;
        maniobraLabel.textColor=fontColor;
        [self addSubview:maniobraLabel];
        
        UILabel *cantidadLabel=[[UILabel alloc]initWithFrame:CGRectMake(730+margen*6, 2, 50, altura)];
        cantidadLabel.text=@"Cantidad";
        cantidadLabel.numberOfLines=2;
        cantidadLabel.backgroundColor=bgColor;
        cantidadLabel.font=font;
        cantidadLabel.textAlignment=NSTextAlignmentCenter;
        cantidadLabel.textColor=fontColor;
        [self addSubview:cantidadLabel];
    }
    return self;
}

#pragma mark - picker delegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==2001) {
        return lista.arregloDeManiobra.count;
    }
    /*else if (pickerView.tag==2002){
        return lista.arregloDeDepartamentos.count;
    }
    else if (pickerView.tag==2003){
        //return lista.arregloDeTipoOperacion.count;
    }
    else if (pickerView.tag==2004){
        //return lista.arregloDeTipoOperacion.count;
    }*/
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
            Maniobra *result=[lista.arregloDeManiobra objectAtIndex:row];
            NSString *strRes=result.maniobra;
            return strRes;
        }
        /*else if (pickerView.tag==2002){
            Departamentos *result=[lista.arregloDeDepartamentos objectAtIndex:row];
            NSString *strRes=result.departamento;
            return strRes;
        }
        else if (pickerView.tag==2003){
            ArmamentosImpactados *result=[lista.arregloDeArmamentosImpactados objectAtIndex:row];
             NSString *strRes=result.nombre;
             return strRes;
        }
        else if (pickerView.tag==2004){
            ArmamentosImpactados *result=[lista.arregloDeArmamentosImpactados objectAtIndex:row];
             NSString *strRes=result.nombre;
             return strRes;
        }*/
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
            Maniobra *result=[lista.arregloDeManiobra objectAtIndex:row];
            NSString *strRes=result.maniobra;
            maniobraTextField.text=strRes;
            return;
        }
        /*else if (pickerView.tag==2002){
            Departamentos *result=[lista.arregloDeDepartamentos objectAtIndex:row];
            NSString *strRes=result.departamento;
            departamentoTextfield.text=strRes;
            return;
        }
        else if (pickerView.tag==2003){
            ArmamentosImpactados *result=[lista.arregloDeArmamentosImpactados objectAtIndex:row];
             NSString *strRes=result.nombre;
             impactadaArmamentoTextField.text=strRes;
             return;
        }
        else if (pickerView.tag==2004){
            ArmamentosImpactados *result=[lista.arregloDeArmamentosImpactados objectAtIndex:row];
             NSString *strRes=result.nombre;
             impactadaArmamentoTextField.text=strRes;
             return;
        }*/
    }
    return;
    
}
@end
