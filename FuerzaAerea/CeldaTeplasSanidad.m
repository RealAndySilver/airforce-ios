//
//  CeldaTeplasSanidad.m
//  FuerzaAerea
//
//  Created by Andres Abril on 17/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import "CeldaTeplasSanidad.h"

@implementation CeldaTeplasSanidad
@synthesize cargoTextField,codigoTextField,gradoTextField,nombreTextiField;
- (id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate withType:(NSString *)type
{
    self = [super initWithFrame:frame];
    if (self) {
        int positionWithType = [type isEqualToString:@"sanidad"] ? 0 : 0;

        self.frame=CGRectMake(frame.origin.x+positionWithType, frame.origin.y, 480, 34);
        self.backgroundColor=[UIColor clearColor];
        self.layer.borderWidth=1.0;
        int margen=7;
        
        
        UIView *bordeSuperior=[[UIView alloc]initWithFrame:CGRectMake((0)+positionWithType, 0, self.frame.size.width, 1)];
        bordeSuperior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeSuperior];
        
        UIView *bordeInferior=[[UIView alloc]initWithFrame:CGRectMake((0)+positionWithType, self.frame.size.height-1, self.frame.size.width, 1)];
        bordeInferior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeInferior];
        
        UIFont *font=[UIFont fontWithName:@"Helvetica" size:10];
        
        cargoTextField=[[UITextField alloc]initWithFrame:CGRectMake((10)+positionWithType, 2, 80, 30)];
        cargoTextField.borderStyle = UITextBorderStyleRoundedRect;
        cargoTextField.textColor=[UIColor blackColor];
        cargoTextField.font=font;
        [cargoTextField setUserInteractionEnabled:NO];
        cargoTextField.textAlignment=NSTextAlignmentCenter;
        [self addSubview:cargoTextField];
        
        nombreTextiField=[[UITextField alloc]initWithFrame:CGRectMake((80+margen*2)+positionWithType, 2, 250, 30)];
        nombreTextiField.borderStyle = UITextBorderStyleRoundedRect;
        nombreTextiField.textColor=[UIColor blackColor];
        nombreTextiField.font=font;
        [nombreTextiField setUserInteractionEnabled:NO];
        [self addSubview:nombreTextiField];
        
        codigoTextField=[[UITextField alloc]initWithFrame:CGRectMake((325+margen*3)+positionWithType, 2, 70, 30)];
        codigoTextField.borderStyle = UITextBorderStyleRoundedRect;
        codigoTextField.textColor=[UIColor blackColor];
        codigoTextField.font=font;
        [codigoTextField setUserInteractionEnabled:NO];
        [self addSubview:codigoTextField];
        
        gradoTextField=[[UITextField alloc]initWithFrame:CGRectMake((390+margen*4)+positionWithType, 2, 50, 30)];
        gradoTextField.borderStyle = UITextBorderStyleRoundedRect;
        gradoTextField.textColor=[UIColor blackColor];
        gradoTextField.font=font;
        [gradoTextField setUserInteractionEnabled:NO];
        gradoTextField.textAlignment=NSTextAlignmentCenter;
        [self addSubview:gradoTextField];
        
        
        
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
        int margen2=480;
        
        //UIFont *font=[UIFont fontWithName:@"Helvetica" size:10];
        UIFont *font=[UIFont boldSystemFontOfSize:10];
        UIColor *fontColor=[UIColor blackColor];
        
        UILabel *tripulacionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, -8, 85, 30)];
        tripulacionLabel.text=@"Teplas";
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
        
        UILabel *tripulacionLabel2=[[UILabel alloc]initWithFrame:CGRectMake(0+margen2, -8, 85, 30)];
        tripulacionLabel2.text=@"Sanidad";
        tripulacionLabel2.numberOfLines=2;
        tripulacionLabel2.font=[UIFont boldSystemFontOfSize:10];
        tripulacionLabel2.textAlignment=NSTextAlignmentCenter;
        tripulacionLabel2.backgroundColor=bgColor;
        tripulacionLabel2.textColor=[UIColor grayColor];
        [self addSubview:tripulacionLabel2];
        
        UILabel *cargoLabel2=[[UILabel alloc]initWithFrame:CGRectMake(margen*1+margen2, 2, 85, 30)];
        cargoLabel2.text=@"Cargo";
        cargoLabel2.numberOfLines=2;
        cargoLabel2.font=font;
        cargoLabel2.textAlignment=NSTextAlignmentCenter;
        cargoLabel2.backgroundColor=bgColor;
        cargoLabel2.textColor=fontColor;
        [self addSubview:cargoLabel2];
        
        UILabel *nombreLabel2=[[UILabel alloc]initWithFrame:CGRectMake(80+margen*2+margen2, 2, 250, altura)];
        nombreLabel2.text=@"Nombre";
        nombreLabel2.font=font;
        nombreLabel2.numberOfLines=2;
        nombreLabel2.backgroundColor=bgColor;
        nombreLabel2.textAlignment=NSTextAlignmentCenter;
        nombreLabel2.textColor=fontColor;
        [self addSubview:nombreLabel2];
        
        UILabel *codigoLabel2=[[UILabel alloc]initWithFrame:CGRectMake(325+margen*3+margen2, 2, 70, 30)];
        codigoLabel2.text=@"Código";
        codigoLabel2.font=font;
        codigoLabel2.numberOfLines=2;
        codigoLabel2.backgroundColor=bgColor;
        codigoLabel2.textAlignment=NSTextAlignmentCenter;
        codigoLabel2.textColor=fontColor;
        [self addSubview:codigoLabel2];
        
        UILabel *gradoLabel2=[[UILabel alloc]initWithFrame:CGRectMake(388+margen*4+margen2, 2, 50, altura)];
        gradoLabel2.text=@"Grado";
        gradoLabel2.numberOfLines=2;
        gradoLabel2.backgroundColor=bgColor;
        gradoLabel2.font=font;
        gradoLabel2.textAlignment=NSTextAlignmentCenter;
        gradoLabel2.textColor=fontColor;
        [self addSubview:gradoLabel2];
    }
    return self;
}
@end
