//
//  CeldaCondiciones.m
//  FuerzaAerea
//
//  Created by Andres Abril on 27/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "CeldaCondiciones.h"

@implementation CeldaCondiciones
@synthesize aterrizajesTextfield,cargaBajanTextfield,cargaSubenTextfield,cargaTransitoTextfield,entidadTextfield,heridosTextfield,ifrHhTextfield,ifrMiTextfield,muertosTextfield,nocHhTextfield,nocMiTextfield,nvgHhTextfield,nvgMiTextfield,paxBajanTextfield,paxSubenTextfield,paxTransitoTextfield,vfrMiTextfield,vfrHhTextfield;
@synthesize aterrizajesTotal,cargaBajanTotal,cargaSubenTotal,cargaTransitoTotal,heridosTotal,ifrHhTotal,ifrMiTotal,muertosTotal,nocHhTotal,nocMiTotal,nvgHhTotal,nvgMiTotal,paxBajanTotal,paxSubenTotal,paxTransitoTotal,segundosApagado,segundosAterrizaje,segundosDecolaje,segundosEncendido,vfrHhTotal,vfrMiTotal;
@synthesize paxTransitoOverlay,cargaTransitoOverlay,noPiernaCondiciones,idEntidad;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        lista=myDelegate;
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissPicker) name:@"esconderPicker" object:nil];
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 964, 34);
        self.backgroundColor=[UIColor clearColor];
        int margen=5;
        UIView *bordeSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        bordeSuperior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeSuperior];
        
        UIView *bordeInferior=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        bordeInferior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeInferior];
        
        UIFont *font=[UIFont fontWithName:@"Helvetica" size:14];
        
        vfrHhTextfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 2, 40, 30)];
        vfrHhTextfield.borderStyle = UITextBorderStyleRoundedRect;
        vfrHhTextfield.backgroundColor=[UIColor whiteColor];
        vfrHhTextfield.delegate=self;
        vfrHhTextfield.font=font;
        [vfrHhTextfield setUserInteractionEnabled:YES];
        vfrHhTextfield.keyboardType=UIKeyboardTypePhonePad;
        vfrHhTextfield.textAlignment=NSTextAlignmentCenter;
        vfrHhTextfield.textColor=[UIColor blackColor];
        vfrHhTextfield.tag=100;
        vfrHhTextfield.text=@"0";
        [self addSubview:vfrHhTextfield];
        
        vfrHhOverlay=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 40, 30)];
        vfrHhOverlay.numberOfLines=1;
        vfrHhOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [vfrHhOverlay setUserInteractionEnabled:YES];
        vfrHhOverlay.text=@"0";
        //[self addSubview:vfrHhOverlay];
        UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [vfrHhOverlay addGestureRecognizer:tap2];
        
        vfrMiTextfield=[[UITextField alloc]initWithFrame:CGRectMake(55, 2, 40, 30)];
        vfrMiTextfield.borderStyle = UITextBorderStyleRoundedRect;
        vfrMiTextfield.delegate=self;
        vfrMiTextfield.font=font;
        [vfrMiTextfield setUserInteractionEnabled:YES];
        vfrMiTextfield.keyboardType=UIKeyboardTypePhonePad;
        vfrMiTextfield.textAlignment=NSTextAlignmentCenter;
        vfrMiTextfield.textColor=[UIColor blackColor];
        vfrMiTextfield.tag=100;
        vfrMiTextfield.text=@"0";

        [self addSubview:vfrMiTextfield];
        
        vfrMiOverlay=[[UILabel alloc]initWithFrame:CGRectMake(55, 2, 40, 30)];
        vfrMiOverlay.numberOfLines=1;
        vfrMiOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [vfrMiOverlay setUserInteractionEnabled:YES];
        //[self addSubview:vfrMiOverlay];
        vfrMiOverlay.text=@"0";

        UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [vfrMiOverlay addGestureRecognizer:tap3];
        
        ifrHhTextfield=[[UITextField alloc]initWithFrame:CGRectMake(100, 2, 40, 30)];
        ifrHhTextfield.borderStyle = UITextBorderStyleRoundedRect;
        ifrHhTextfield.delegate=self;
        ifrHhTextfield.font=font;
        [ifrHhTextfield setUserInteractionEnabled:YES];
        ifrHhTextfield.keyboardType=UIKeyboardTypePhonePad;
        ifrHhTextfield.textAlignment=NSTextAlignmentCenter;
        ifrHhTextfield.textColor=[UIColor blackColor];
        ifrHhTextfield.tag=100;
        ifrHhTextfield.text=@"0";

        [self addSubview:ifrHhTextfield];
        
        ifrHhOverlay=[[UILabel alloc]initWithFrame:CGRectMake(100, 2, 40, 30)];
        ifrHhOverlay.numberOfLines=1;
        ifrHhOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [ifrHhOverlay setUserInteractionEnabled:YES];
        //[self addSubview:ifrHhOverlay];
        ifrHhOverlay.text=@"0";

        UITapGestureRecognizer *tap4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [ifrHhOverlay addGestureRecognizer:tap4];
        
        ifrMiTextfield=[[UITextField alloc]initWithFrame:CGRectMake(145, 2, 40, 30)];
        ifrMiTextfield.borderStyle = UITextBorderStyleRoundedRect;
        ifrMiTextfield.delegate=self;
        ifrMiTextfield.font=font;
        [ifrMiTextfield setUserInteractionEnabled:YES];
        ifrMiTextfield.keyboardType=UIKeyboardTypePhonePad;
        ifrMiTextfield.textAlignment=NSTextAlignmentCenter;
        ifrMiTextfield.textColor=[UIColor blackColor];
        ifrMiTextfield.tag=100;
        ifrMiTextfield.text=@"0";

        [self addSubview:ifrMiTextfield];
        
        ifrMiOverlay=[[UILabel alloc]initWithFrame:CGRectMake(145, 2, 40, 30)];
        ifrMiOverlay.numberOfLines=1;
        ifrMiOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [ifrMiOverlay setUserInteractionEnabled:YES];
        //[self addSubview:ifrMiOverlay];
        ifrMiOverlay.text=@"0";
        UITapGestureRecognizer *tap5=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [ifrHhOverlay addGestureRecognizer:tap5];
        
        nocHhTextfield=[[UITextField alloc]initWithFrame:CGRectMake(190, 2, 40, 30)];
        nocHhTextfield.borderStyle = UITextBorderStyleRoundedRect;
        nocHhTextfield.delegate=self;
        nocHhTextfield.font=font;
        [nocHhTextfield setUserInteractionEnabled:YES];
        nocHhTextfield.keyboardType=UIKeyboardTypePhonePad;
        nocHhTextfield.textAlignment=NSTextAlignmentCenter;
        nocHhTextfield.textColor=[UIColor blackColor];
        nocHhTextfield.tag=100;
        nocHhTextfield.text=@"0";

        [self addSubview:nocHhTextfield];
        
        nocHhOverlay=[[UILabel alloc]initWithFrame:CGRectMake(190, 2, 40, 30)];
        nocHhOverlay.numberOfLines=1;
        nocHhOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [nocHhOverlay setUserInteractionEnabled:YES];
        nocHhOverlay.text=@"0";

        //[self addSubview:nocHhOverlay];
        UITapGestureRecognizer *tap6=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [nocHhOverlay addGestureRecognizer:tap6];
        
        nocMiTextfield=[[UITextField alloc]initWithFrame:CGRectMake(235, 2, 40, 30)];
        nocMiTextfield.borderStyle = UITextBorderStyleRoundedRect;
        nocMiTextfield.delegate=self;
        nocMiTextfield.font=font;
        nocMiTextfield.text=@"0";
        [nocMiTextfield setUserInteractionEnabled:YES];
        nocMiTextfield.keyboardType=UIKeyboardTypePhonePad;
        nocMiTextfield.textAlignment=NSTextAlignmentCenter;
        nocMiTextfield.textColor=[UIColor blackColor];
        nocMiTextfield.tag=100;
        [self addSubview:nocMiTextfield];
        
        nocMiOverlay=[[UILabel alloc]initWithFrame:CGRectMake(235, 2, 40, 30)];
        nocMiOverlay.numberOfLines=1;
        nocMiOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [nocMiOverlay setUserInteractionEnabled:YES];
        nocMiOverlay.text=@"0";

        //[self addSubview:nocMiOverlay];
        UITapGestureRecognizer *tap7=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [nocHhOverlay addGestureRecognizer:tap7];
        
        nvgHhTextfield=[[UITextField alloc]initWithFrame:CGRectMake(280, 2, 40, 30)];
        nvgHhTextfield.borderStyle = UITextBorderStyleRoundedRect;
        nvgHhTextfield.delegate=self;
        nvgHhTextfield.font=font;
        nvgHhTextfield.text=@"0";

        [nvgHhTextfield setUserInteractionEnabled:YES];
        nvgHhTextfield.keyboardType=UIKeyboardTypePhonePad;
        nvgHhTextfield.textAlignment=NSTextAlignmentCenter;
        nvgHhTextfield.textColor=[UIColor blackColor];
        nvgHhTextfield.tag=100;
        [self addSubview:nvgHhTextfield];
        
        nvgHhOverlay=[[UILabel alloc]initWithFrame:CGRectMake(280, 2, 40, 30)];
        nvgHhOverlay.numberOfLines=1;
        nvgHhOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [nvgHhOverlay setUserInteractionEnabled:YES];
        nvgHhOverlay.text=@"0";

        //[self addSubview:nvgHhOverlay];
        UITapGestureRecognizer *tap8=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [nvgHhOverlay addGestureRecognizer:tap8];
        
        nvgMiTextfield=[[UITextField alloc]initWithFrame:CGRectMake(325, 2, 40, 30)];
        nvgMiTextfield.borderStyle = UITextBorderStyleRoundedRect;
        nvgMiTextfield.delegate=self;
        nvgMiTextfield.font=font;
        nvgMiTextfield.text=@"0";

        [nvgMiTextfield setUserInteractionEnabled:YES];
        nvgMiTextfield.keyboardType=UIKeyboardTypePhonePad;
        nvgMiTextfield.textAlignment=NSTextAlignmentCenter;
        nvgMiTextfield.textColor=[UIColor blackColor];
        nvgMiTextfield.tag=100;
        
        [self addSubview:nvgMiTextfield];
        
        nvgMiOverlay=[[UILabel alloc]initWithFrame:CGRectMake(325, 2, 40, 30)];
        nvgMiOverlay.numberOfLines=1;
        nvgMiOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [nvgMiOverlay setUserInteractionEnabled:YES];
        nvgMiOverlay.text=@"0";

        //[self addSubview:nvgMiOverlay];
        UITapGestureRecognizer *tap9=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [nvgMiOverlay addGestureRecognizer:tap9];
        
        aterrizajesTextfield=[[UITextField alloc]initWithFrame:CGRectMake(370, 2, 40, 30)];
        aterrizajesTextfield.borderStyle = UITextBorderStyleRoundedRect;
        aterrizajesTextfield.delegate=self;
        aterrizajesTextfield.font=font;
        aterrizajesTextfield.keyboardType=UIKeyboardTypePhonePad;
        [aterrizajesTextfield setUserInteractionEnabled:YES];
        aterrizajesTextfield.textAlignment=NSTextAlignmentCenter;
        aterrizajesTextfield.textColor=[UIColor blackColor];
        aterrizajesTextfield.tag=100;
        aterrizajesTextfield.text=@"1";

        [self addSubview:aterrizajesTextfield];
        
        aterrizajesOverlay=[[UILabel alloc]initWithFrame:CGRectMake(370, 2, 40, 30)];
        aterrizajesOverlay.numberOfLines=1;
        aterrizajesOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [aterrizajesOverlay setUserInteractionEnabled:YES];
        aterrizajesOverlay.text=@"1";
        //[self addSubview:aterrizajesOverlay];
        UITapGestureRecognizer *tap10=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [aterrizajesOverlay addGestureRecognizer:tap10];
        
        heridosTextfield=[[UITextField alloc]initWithFrame:CGRectMake(415, 2, 40, 30)];
        heridosTextfield.borderStyle = UITextBorderStyleRoundedRect;
        heridosTextfield.keyboardType=UIKeyboardTypePhonePad;
        heridosTextfield.delegate=self;
        heridosTextfield.font=font;
        heridosTextfield.text=@"0";
        [heridosTextfield setUserInteractionEnabled:YES];
        heridosTextfield.textAlignment=NSTextAlignmentCenter;
        heridosTextfield.textColor=[UIColor blackColor];
        heridosTextfield.tag=100;
        [self addSubview:heridosTextfield];
        
        heridosOverlay=[[UILabel alloc]initWithFrame:CGRectMake(415, 2, 40, 30)];
        heridosOverlay.numberOfLines=1;
        heridosOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [heridosOverlay setUserInteractionEnabled:YES];
        heridosOverlay.text=@"0";
        //[self addSubview:heridosOverlay];
        UITapGestureRecognizer *tap11=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [heridosOverlay addGestureRecognizer:tap11];
        
        muertosTextfield=[[UITextField alloc]initWithFrame:CGRectMake(460, 2, 40, 30)];
        muertosTextfield.borderStyle = UITextBorderStyleRoundedRect;
        muertosTextfield.delegate=self;
        muertosTextfield.font=font;
        muertosTextfield.keyboardType=UIKeyboardTypePhonePad;
        [muertosTextfield setUserInteractionEnabled:YES];
        muertosTextfield.textAlignment=NSTextAlignmentCenter;
        muertosTextfield.textColor=[UIColor blackColor];
        muertosTextfield.tag=100;
        muertosTextfield.text=@"0";

        [self addSubview:muertosTextfield];
        
        muertosOverlay=[[UILabel alloc]initWithFrame:CGRectMake(460, 2, 40, 30)];
        muertosOverlay.numberOfLines=1;
        muertosOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [muertosOverlay setUserInteractionEnabled:YES];
        //[self addSubview:muertosOverlay];
        muertosOverlay.text=@"0";
        UITapGestureRecognizer *tap12=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [muertosOverlay addGestureRecognizer:tap12];
        
        paxSubenTextfield=[[UITextField alloc]initWithFrame:CGRectMake(505, 2, 40, 30)];
        paxSubenTextfield.borderStyle = UITextBorderStyleRoundedRect;
        paxSubenTextfield.delegate=self;
        paxSubenTextfield.font=font;
        paxSubenTextfield.keyboardType=UIKeyboardTypePhonePad;
        [paxSubenTextfield setUserInteractionEnabled:YES];
        paxSubenTextfield.textAlignment=NSTextAlignmentCenter;
        paxSubenTextfield.textColor=[UIColor blackColor];
        paxSubenTextfield.tag=50;
        paxSubenTextfield.text=@"0";
        [self addSubview:paxSubenTextfield];
        
        paxSubenOverlay=[[UILabel alloc]initWithFrame:CGRectMake(505, 2, 40, 30)];
        paxSubenOverlay.numberOfLines=1;
        paxSubenOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [paxSubenOverlay setUserInteractionEnabled:YES];
        paxSubenOverlay.text=@"0";
        //[self addSubview:paxSubenOverlay];
        UITapGestureRecognizer *tap13=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [paxSubenOverlay addGestureRecognizer:tap13];
        
        paxBajanTextfield=[[UITextField alloc]initWithFrame:CGRectMake(550, 2, 40, 30)];
        paxBajanTextfield.borderStyle = UITextBorderStyleRoundedRect;
        paxBajanTextfield.delegate=self;
        paxBajanTextfield.font=font;
        paxBajanTextfield.keyboardType=UIKeyboardTypePhonePad;
        [paxBajanTextfield setUserInteractionEnabled:YES];
        paxBajanTextfield.textAlignment=NSTextAlignmentCenter;
        paxBajanTextfield.textColor=[UIColor blackColor];
        paxBajanTextfield.tag=51;
        paxBajanTextfield.text=@"0";
        [self addSubview:paxBajanTextfield];
        
        paxBajanOverlay=[[UILabel alloc]initWithFrame:CGRectMake(550, 2, 40, 30)];
        paxBajanOverlay.numberOfLines=1;
        paxBajanOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [paxBajanOverlay setUserInteractionEnabled:YES];
        paxBajanOverlay.text=@"0";
        //[self addSubview:paxBajanOverlay];
        UITapGestureRecognizer *tap14=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [paxBajanOverlay addGestureRecognizer:tap14];
        
        paxTransitoTextfield=[[UITextField alloc]initWithFrame:CGRectMake(595, 2, 40, 30)];
        paxTransitoTextfield.borderStyle = UITextBorderStyleLine;
        paxTransitoTextfield.delegate=self;
        paxTransitoTextfield.font=font;
        paxTransitoTextfield.keyboardType=UIKeyboardTypePhonePad;
        [paxTransitoTextfield setUserInteractionEnabled:YES];
        paxTransitoTextfield.textAlignment=NSTextAlignmentCenter;
        paxTransitoTextfield.textColor=[UIColor blackColor];
        paxTransitoTextfield.tag=52;
        [self addSubview:paxTransitoTextfield];
        
        paxTransitoOverlay=[[UILabel alloc]initWithFrame:CGRectMake(595, 2, 40, 30)];
        paxTransitoOverlay.numberOfLines=1;
        paxTransitoOverlay.font=[UIFont fontWithName:@"Helvetica" size:15];
        paxTransitoOverlay.backgroundColor=[UIColor colorWithWhite:0.8 alpha:1];
        [paxTransitoOverlay setUserInteractionEnabled:YES];
        paxTransitoOverlay.textAlignment=NSTextAlignmentCenter;
        [self addSubview:paxTransitoOverlay];
        
        cargaSubenTextfield=[[UITextField alloc]initWithFrame:CGRectMake(640, 2, 40, 30)];
        cargaSubenTextfield.borderStyle = UITextBorderStyleRoundedRect;
        cargaSubenTextfield.delegate=self;
        cargaSubenTextfield.font=font;
        cargaSubenTextfield.keyboardType=UIKeyboardTypePhonePad;
        [cargaSubenTextfield setUserInteractionEnabled:YES];
        cargaSubenTextfield.textAlignment=NSTextAlignmentCenter;
        cargaSubenTextfield.textColor=[UIColor blackColor];
        cargaSubenTextfield.tag=60;
        cargaSubenTextfield.text=@"0";

        [self addSubview:cargaSubenTextfield];
        
        cargaSubenOverlay=[[UILabel alloc]initWithFrame:CGRectMake(640, 2, 40, 30)];
        cargaSubenOverlay.numberOfLines=1;
        cargaSubenOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [cargaSubenOverlay setUserInteractionEnabled:YES];
        cargaSubenOverlay.text=@"0";
        //[self addSubview:cargaSubenOverlay];
        UITapGestureRecognizer *tap15=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [cargaSubenOverlay addGestureRecognizer:tap15];
        
        
        cargaBajanTextfield=[[UITextField alloc]initWithFrame:CGRectMake(685, 2, 40, 30)];
        cargaBajanTextfield.borderStyle = UITextBorderStyleRoundedRect;
        cargaBajanTextfield.delegate=self;
        cargaBajanTextfield.font=font;
        cargaBajanTextfield.keyboardType=UIKeyboardTypePhonePad;
        [cargaBajanTextfield setUserInteractionEnabled:YES];
        cargaBajanTextfield.textAlignment=NSTextAlignmentCenter;
        cargaBajanTextfield.textColor=[UIColor blackColor];
        cargaBajanTextfield.tag=61;
        cargaBajanTextfield.text=@"0";

        [self addSubview:cargaBajanTextfield];
        
        cargaBajanOverlay=[[UILabel alloc]initWithFrame:CGRectMake(685, 2, 40, 30)];
        cargaBajanOverlay.numberOfLines=1;
        cargaBajanOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [cargaBajanOverlay setUserInteractionEnabled:YES];
        cargaBajanOverlay.text=@"0";
        //[self addSubview:cargaBajanOverlay];
        UITapGestureRecognizer *tap16=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [cargaBajanOverlay addGestureRecognizer:tap16];
        
        cargaTransitoTextfield=[[UITextField alloc]initWithFrame:CGRectMake(730, 2, 40, 30)];
        cargaTransitoTextfield.delegate=self;
        cargaTransitoTextfield.font=font;
        cargaTransitoTextfield.backgroundColor=[UIColor whiteColor];
        cargaTransitoTextfield.keyboardType=UIKeyboardTypePhonePad;
        [cargaTransitoTextfield setUserInteractionEnabled:YES];
        cargaTransitoTextfield.textAlignment=NSTextAlignmentCenter;
        cargaTransitoTextfield.textColor=[UIColor blackColor];
        cargaTransitoTextfield.tag=62;
        [self addSubview:cargaTransitoTextfield];
        
        cargaTransitoOverlay=[[UILabel alloc]initWithFrame:CGRectMake(730, 2, 40, 30)];
        cargaTransitoOverlay.numberOfLines=1;
        cargaTransitoOverlay.font=[UIFont fontWithName:@"Helvetica" size:15];
        cargaTransitoOverlay.backgroundColor=[UIColor colorWithWhite:0.8 alpha:1];
        cargaTransitoOverlay.textAlignment=NSTextAlignmentCenter;
        [cargaTransitoOverlay setUserInteractionEnabled:YES];
        [self addSubview:cargaTransitoOverlay];
        
        
        entidadOverlay=[[UILabel alloc]initWithFrame:CGRectMake(775, 2, 180, 30)];
        entidadOverlay.numberOfLines=1;
        entidadOverlay.font=[UIFont fontWithName:@"Helvetica" size:10];
        [entidadOverlay setUserInteractionEnabled:NO];
        //[self addSubview:entidadOverlay];
        UITapGestureRecognizer *tap17=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [entidadOverlay addGestureRecognizer:tap17];
        
        entidadTextfield=[[UITextField alloc]initWithFrame:CGRectMake(775, 2, 180, 30)];
        entidadTextfield.borderStyle = UITextBorderStyleRoundedRect;
        entidadTextfield.delegate=self;
        entidadTextfield.font=font;
        entidadTextfield.font=[UIFont fontWithName:@"Helvetica" size:8];
        entidadTextfield.keyboardType=UIKeyboardTypePhonePad;
        [entidadTextfield setUserInteractionEnabled:YES];
        entidadTextfield.textAlignment=NSTextAlignmentCenter;
        entidadTextfield.textColor=[UIColor blackColor];
        entidadTextfield.tag=100;
        [self addSubview:entidadTextfield];
        
        UIButton *validateButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [validateButton setBackgroundImage:[UIImage imageNamed:@"atras.png"] forState:UIControlStateNormal];
        [validateButton setTitle:@"Validar" forState:UIControlStateNormal];
        validateButton.frame=CGRectMake(830+margen*11, 2, 50, 30);
        validateButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:10];
        [validateButton addTarget:self action:@selector(validar) forControlEvents:UIControlEventTouchUpInside];
        //[self addSubview:validateButton];
        
        pickerEntidad=[[UIPickerView alloc]init];
        pickerEntidad.dataSource=self;
        pickerEntidad.delegate=self;
        pickerEntidad.showsSelectionIndicator = YES;
        pickerEntidad.tag=2001;
        if (lista.arregloDeEntidades.count) {
            entidadTextfield.inputView=pickerEntidad;
        }
    }
    return self;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateCondiciones" object:nil];
    if (textField.tag==50 || textField.tag==51) {
        paxTransitoOverlay.text=[NSString stringWithFormat:@"%i",[paxSubenTextfield.text intValue]-[paxBajanTextfield.text intValue]];
        paxTransitoTextfield.text=[NSString stringWithFormat:@"%i",[paxSubenTextfield.text intValue]-[paxBajanTextfield.text intValue]];
        return;
    }
    if (textField.tag==60 || textField.tag==61) {
        cargaTransitoOverlay.text=[NSString stringWithFormat:@"%i",[cargaSubenTextfield.text intValue]-[cargaBajanTextfield.text intValue]];
        cargaTransitoTextfield.text=[NSString stringWithFormat:@"%i",[cargaSubenTextfield.text intValue]-[cargaBajanTextfield.text intValue]];

        return;
    }
    
}
- (id)initHeaderWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        int altura=33;
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 964, altura);
        UIColor *bgColor=[UIColor clearColor];
        UIColor *textColor=[UIColor blackColor];
        NSTextAlignment alignment=NSTextAlignmentCenter;
        self.backgroundColor=bgColor;
        int margen=7;
        
        //UIFont *font=[UIFont fontWithName:@"Helvetica" size:10];
        UIFont *font=[UIFont boldSystemFontOfSize:9];

        UIColor *fontColor=[UIColor blackColor];
        
        vfrHhHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 40, 30)];
        vfrHhHeader.numberOfLines=2;
        vfrHhHeader.textAlignment=alignment;
        vfrHhHeader.font=font;
        vfrHhHeader.textColor=textColor;
        vfrHhHeader.backgroundColor=bgColor;
        vfrHhHeader.text=@"Vfr \nHh";
        [self addSubview:vfrHhHeader];
        
        vfrMiHeader=[[UILabel alloc]initWithFrame:CGRectMake(55, 2, 40, 30)];
        vfrMiHeader.numberOfLines=2;
        vfrMiHeader.text=@"Vfr \nMi";
        vfrMiHeader.textAlignment=alignment;
        vfrMiHeader.font=font;
        vfrMiHeader.textColor=textColor;
        vfrMiHeader.backgroundColor=bgColor;
        [self addSubview:vfrMiHeader];
        
        ifrHhHeader=[[UILabel alloc]initWithFrame:CGRectMake(100, 2, 40, 30)];
        ifrHhHeader.numberOfLines=2;
        ifrHhHeader.text=@"Ifr \nHh";
        ifrHhHeader.textAlignment=alignment;
        ifrHhHeader.font=font;
        ifrHhHeader.textColor=textColor;
        ifrHhHeader.backgroundColor=bgColor;
        [self addSubview:ifrHhHeader];
        
        ifrMiHeader=[[UILabel alloc]initWithFrame:CGRectMake(145, 2, 40, 30)];
        ifrMiHeader.numberOfLines=2;
        ifrMiHeader.text=@"Ifr \nMi";
        ifrMiHeader.textAlignment=alignment;
        ifrMiHeader.font=font;
        ifrMiHeader.textColor=textColor;
        ifrMiHeader.backgroundColor=bgColor;
        [self addSubview:ifrMiHeader];
        
        nocHhHeader=[[UILabel alloc]initWithFrame:CGRectMake(190, 2, 40, 30)];
        nocHhHeader.numberOfLines=2;
        nocHhHeader.text=@"Noc \nHh";
        nocHhHeader.textAlignment=alignment;
        nocHhHeader.font=font;
        nocHhHeader.textColor=textColor;
        nocHhHeader.backgroundColor=bgColor;
        [self addSubview:nocHhHeader];
                
        nocMiHeader=[[UILabel alloc]initWithFrame:CGRectMake(235, 2, 40, 30)];
        nocMiHeader.numberOfLines=2;
        nocMiHeader.text=@"Noc \nMi";
        nocMiHeader.textAlignment=alignment;
        nocMiHeader.font=font;
        nocMiHeader.textColor=textColor;
        nocMiHeader.backgroundColor=bgColor;
        [self addSubview:nocMiHeader];
        
        nvgHhHeader=[[UILabel alloc]initWithFrame:CGRectMake(280, 2, 40, 30)];
        nvgHhHeader.numberOfLines=2;
        nvgHhHeader.text=@"Nvg \nHh";
        nvgHhHeader.textAlignment=alignment;
        nvgHhHeader.font=font;
        nvgHhHeader.textColor=textColor;
        nvgHhHeader.backgroundColor=bgColor;
        [self addSubview:nvgHhHeader];
        
        nvgMiHeader=[[UILabel alloc]initWithFrame:CGRectMake(325, 2, 40, 30)];
        nvgMiHeader.numberOfLines=2;
        nvgMiHeader.text=@"Nvg \nMi";
        nvgMiHeader.textAlignment=alignment;
        nvgMiHeader.font=font;
        nvgMiHeader.textColor=textColor;
        nvgMiHeader.backgroundColor=bgColor;
        [self addSubview:nvgMiHeader];
        
        aterrizajesHeader=[[UILabel alloc]initWithFrame:CGRectMake(365, 2, 50, 30)];
        aterrizajesHeader.numberOfLines=1;
        aterrizajesHeader.text=@"Aterrizajes";
        aterrizajesHeader.textAlignment=alignment;
        aterrizajesHeader.font=font;
        aterrizajesHeader.textColor=textColor;
        aterrizajesHeader.backgroundColor=bgColor;
        [self addSubview:aterrizajesHeader];
        
        heridosHeader=[[UILabel alloc]initWithFrame:CGRectMake(415, 2, 40, 30)];
        heridosHeader.numberOfLines=2;
        heridosHeader.text=@"No. Heridos";
        heridosHeader.textAlignment=alignment;
        heridosHeader.font=font;
        heridosHeader.textColor=textColor;
        heridosHeader.backgroundColor=bgColor;
        [self addSubview:heridosHeader];
        
        muertosHeader=[[UILabel alloc]initWithFrame:CGRectMake(460, 2, 40, 30)];
        muertosHeader.numberOfLines=2;
        muertosHeader.text=@"No. muertos";
        muertosHeader.textAlignment=alignment;
        muertosHeader.font=font;
        muertosHeader.textColor=textColor;
        muertosHeader.backgroundColor=bgColor;
        [self addSubview:muertosHeader];
        
        UILabel *paxHeader=[[UILabel alloc]initWithFrame:CGRectMake(505, -8, 40, 30)];
        paxHeader.numberOfLines=1;
        paxHeader.text=@"Pax";
        paxHeader.textAlignment=alignment;
        paxHeader.font=[UIFont boldSystemFontOfSize:10];
        paxHeader.textColor=[UIColor grayColor];
        paxHeader.backgroundColor=bgColor;
        [self addSubview:paxHeader];
        
        paxSubenHeader=[[UILabel alloc]initWithFrame:CGRectMake(505, 2, 40, 30)];
        paxSubenHeader.numberOfLines=1;
        paxSubenHeader.text=@"Suben";
        paxSubenHeader.textAlignment=alignment;
        paxSubenHeader.font=font;
        paxSubenHeader.textColor=textColor;
        paxSubenHeader.backgroundColor=bgColor;
        [self addSubview:paxSubenHeader];
        
        paxBajanHeader=[[UILabel alloc]initWithFrame:CGRectMake(550, 2, 40, 30)];
        paxBajanHeader.numberOfLines=1;
        paxBajanHeader.text=@"Bajan";
        paxBajanHeader.textAlignment=alignment;
        paxBajanHeader.font=font;
        paxBajanHeader.textColor=textColor;
        paxBajanHeader.backgroundColor=bgColor;
        [self addSubview:paxBajanHeader];
        
        paxTransitoHeader=[[UILabel alloc]initWithFrame:CGRectMake(595, 2, 40, 30)];
        paxTransitoHeader.numberOfLines=1;
        paxTransitoHeader.text=@"Tránsito";
        paxTransitoHeader.textAlignment=alignment;
        paxTransitoHeader.font=font;
        paxTransitoHeader.textColor=textColor;
        paxTransitoHeader.backgroundColor=bgColor;
        [self addSubview:paxTransitoHeader];
        
        UILabel *cargaHeader=[[UILabel alloc]initWithFrame:CGRectMake(640, -8, 40, 30)];
        cargaHeader.numberOfLines=1;
        cargaHeader.text=@"Carga";
        cargaHeader.textAlignment=alignment;
        cargaHeader.font=[UIFont boldSystemFontOfSize:10];
        cargaHeader.textColor=[UIColor grayColor];
        cargaHeader.backgroundColor=bgColor;
        [self addSubview:cargaHeader];
        
        cargaSubenHeader=[[UILabel alloc]initWithFrame:CGRectMake(640, 2, 40, 30)];
        cargaSubenHeader.numberOfLines=1;
        cargaSubenHeader.text=@"Sube";
        cargaSubenHeader.textAlignment=alignment;
        cargaSubenHeader.font=font;
        cargaSubenHeader.textColor=textColor;
        cargaSubenHeader.backgroundColor=bgColor;
        [self addSubview:cargaSubenHeader];
        
        cargaBajanHeader=[[UILabel alloc]initWithFrame:CGRectMake(685, 2, 40, 30)];
        cargaBajanHeader.numberOfLines=1;
        cargaBajanHeader.text=@"Baja";
        cargaBajanHeader.textAlignment=alignment;
        cargaBajanHeader.font=font;
        cargaBajanHeader.textColor=textColor;
        cargaBajanHeader.backgroundColor=bgColor;
        [self addSubview:cargaBajanHeader];
        
        cargaTransitoHeader=[[UILabel alloc]initWithFrame:CGRectMake(730, 2, 40, 30)];
        cargaTransitoHeader.numberOfLines=1;
        cargaTransitoHeader.text=@"Tránsito";
        cargaTransitoHeader.textAlignment=alignment;
        cargaTransitoHeader.font=font;
        cargaTransitoHeader.textColor=textColor;
        cargaTransitoHeader.backgroundColor=bgColor;
        [self addSubview:cargaTransitoHeader];
        
        entidadHeader=[[UILabel alloc]initWithFrame:CGRectMake(775, 2, 180, 30)];
        entidadHeader.numberOfLines=1;
        entidadHeader.text=@"Entidad";
        entidadHeader.textAlignment=alignment;
        entidadHeader.font=font;
        entidadHeader.textColor=textColor;
        entidadHeader.backgroundColor=bgColor;
        [self addSubview:entidadHeader];
                
        UILabel *validarLabel=[[UILabel alloc]initWithFrame:CGRectMake(790+margen*12, 2, 70, altura)];
        validarLabel.text=@"Validar";
        validarLabel.numberOfLines=2;
        validarLabel.backgroundColor=bgColor;
        validarLabel.font=font;
        validarLabel.textAlignment=NSTextAlignmentCenter;
        validarLabel.textColor=fontColor;
        //[self addSubview:validarLabel];
    }
    return self;
}
-(id)initTotalWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 964, 34);
        self.backgroundColor=[UIColor clearColor];
        //int margen=5;
        UIView *bordeSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        bordeSuperior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeSuperior];
        
        UIView *bordeInferior=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        bordeInferior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeInferior];
        
        UIFont *font=[UIFont fontWithName:@"Helvetica" size:15];
        
        vfrHhTotal=[[UITextField alloc]initWithFrame:CGRectMake(10, 2, 40, 30)];
        vfrHhTotal.borderStyle = UITextBorderStyleBezel;
        vfrHhTotal.backgroundColor=[UIColor whiteColor];
        vfrHhTotal.delegate=self;
        vfrHhTotal.font=font;
        [vfrHhTotal setUserInteractionEnabled:NO];
        vfrHhTotal.textAlignment=NSTextAlignmentCenter;
        vfrHhTotal.textColor=[UIColor blackColor];
        vfrHhTotal.tag=100;
        [self addSubview:vfrHhTotal];
        
                
        vfrMiTotal=[[UITextField alloc]initWithFrame:CGRectMake(55, 2, 40, 30)];
        vfrMiTotal.borderStyle = UITextBorderStyleBezel;
        vfrMiTotal.backgroundColor=[UIColor whiteColor];
        vfrMiTotal.delegate=self;
        vfrMiTotal.font=font;
        [vfrMiTotal setUserInteractionEnabled:NO];
        vfrMiTotal.keyboardType=UIKeyboardTypePhonePad;
        vfrMiTotal.textAlignment=NSTextAlignmentCenter;
        vfrMiTotal.textColor=[UIColor blackColor];
        vfrMiTotal.tag=100;
        [self addSubview:vfrMiTotal];
        
                
        ifrHhTotal=[[UITextField alloc]initWithFrame:CGRectMake(100, 2, 40, 30)];
        ifrHhTotal.borderStyle = UITextBorderStyleBezel;
        ifrHhTotal.backgroundColor=[UIColor whiteColor];
        ifrHhTotal.delegate=self;
        ifrHhTotal.font=font;
        [ifrHhTotal setUserInteractionEnabled:NO];
        ifrHhTotal.keyboardType=UIKeyboardTypePhonePad;
        ifrHhTotal.textAlignment=NSTextAlignmentCenter;
        ifrHhTotal.textColor=[UIColor blackColor];
        ifrHhTotal.tag=100;
        [self addSubview:ifrHhTotal];
        
                
        ifrMiTotal=[[UITextField alloc]initWithFrame:CGRectMake(145, 2, 40, 30)];
        ifrMiTotal.borderStyle = UITextBorderStyleBezel;
        ifrMiTotal.backgroundColor=[UIColor whiteColor];
        ifrMiTotal.delegate=self;
        ifrMiTotal.font=font;
        [ifrMiTotal setUserInteractionEnabled:NO];
        ifrMiTotal.keyboardType=UIKeyboardTypePhonePad;
        ifrMiTotal.textAlignment=NSTextAlignmentCenter;
        ifrMiTotal.textColor=[UIColor blackColor];
        ifrMiTotal.tag=100;
        [self addSubview:ifrMiTotal];
        
                
        nocHhTotal=[[UITextField alloc]initWithFrame:CGRectMake(190, 2, 40, 30)];
        nocHhTotal.borderStyle = UITextBorderStyleBezel;
        nocHhTotal.backgroundColor=[UIColor whiteColor];
        nocHhTotal.delegate=self;
        nocHhTotal.font=font;
        [nocHhTotal setUserInteractionEnabled:NO];
        nocHhTotal.keyboardType=UIKeyboardTypePhonePad;
        nocHhTotal.textAlignment=NSTextAlignmentCenter;
        nocHhTotal.textColor=[UIColor blackColor];
        nocHhTotal.tag=100;
        [self addSubview:nocHhTotal];
        
                
        nocMiTotal=[[UITextField alloc]initWithFrame:CGRectMake(235, 2, 40, 30)];
        nocMiTotal.borderStyle = UITextBorderStyleBezel;
        nocMiTotal.backgroundColor=[UIColor whiteColor];
        nocMiTotal.delegate=self;
        nocMiTotal.font=font;
        [nocMiTotal setUserInteractionEnabled:NO];
        nocMiTotal.keyboardType=UIKeyboardTypePhonePad;
        nocMiTotal.textAlignment=NSTextAlignmentCenter;
        nocMiTotal.textColor=[UIColor blackColor];
        nocMiTotal.tag=100;
        [self addSubview:nocMiTotal];
        
                
        nvgHhTotal=[[UITextField alloc]initWithFrame:CGRectMake(280, 2, 40, 30)];
        nvgHhTotal.borderStyle = UITextBorderStyleBezel;
        nvgHhTotal.backgroundColor=[UIColor whiteColor];
        nvgHhTotal.delegate=self;
        nvgHhTotal.font=font;
        [nvgHhTotal setUserInteractionEnabled:NO];
        nvgHhTotal.keyboardType=UIKeyboardTypePhonePad;
        nvgHhTotal.textAlignment=NSTextAlignmentCenter;
        nvgHhTotal.textColor=[UIColor blackColor];
        nvgHhTotal.tag=100;
        [self addSubview:nvgHhTotal];
        
                
        nvgMiTotal=[[UITextField alloc]initWithFrame:CGRectMake(325, 2, 40, 30)];
        nvgMiTotal.borderStyle = UITextBorderStyleBezel;
        nvgMiTotal.backgroundColor=[UIColor whiteColor];
        nvgMiTotal.delegate=self;
        nvgMiTotal.font=font;
        [nvgMiTotal setUserInteractionEnabled:NO];
        nvgMiTotal.keyboardType=UIKeyboardTypePhonePad;
        nvgMiTotal.textAlignment=NSTextAlignmentCenter;
        nvgMiTotal.textColor=[UIColor blackColor];
        nvgMiTotal.tag=100;
        [self addSubview:nvgMiTotal];
        
                
        aterrizajesTotal=[[UITextField alloc]initWithFrame:CGRectMake(370, 2, 40, 30)];
        aterrizajesTotal.borderStyle = UITextBorderStyleBezel;
        aterrizajesTotal.backgroundColor=[UIColor whiteColor];
        aterrizajesTotal.delegate=self;
        aterrizajesTotal.font=font;
        aterrizajesTotal.keyboardType=UIKeyboardTypePhonePad;
        [aterrizajesTotal setUserInteractionEnabled:NO];
        aterrizajesTotal.textAlignment=NSTextAlignmentCenter;
        aterrizajesTotal.textColor=[UIColor blackColor];
        aterrizajesTotal.tag=100;
        [self addSubview:aterrizajesTotal];
        
                
        heridosTotal=[[UITextField alloc]initWithFrame:CGRectMake(415, 2, 40, 30)];
        heridosTotal.borderStyle = UITextBorderStyleBezel;
        heridosTotal.backgroundColor=[UIColor whiteColor];
        heridosTotal.keyboardType=UIKeyboardTypePhonePad;
        heridosTotal.delegate=self;
        heridosTotal.font=font;
        [heridosTotal setUserInteractionEnabled:NO];
        heridosTotal.textAlignment=NSTextAlignmentCenter;
        heridosTotal.textColor=[UIColor blackColor];
        heridosTotal.tag=100;
        [self addSubview:heridosTotal];
        
                
        muertosTotal=[[UITextField alloc]initWithFrame:CGRectMake(460, 2, 40, 30)];
        muertosTotal.borderStyle = UITextBorderStyleBezel;
        muertosTotal.backgroundColor=[UIColor whiteColor];
        muertosTotal.delegate=self;
        muertosTotal.font=font;
        muertosTotal.keyboardType=UIKeyboardTypePhonePad;
        [muertosTotal setUserInteractionEnabled:NO];
        muertosTotal.textAlignment=NSTextAlignmentCenter;
        muertosTotal.textColor=[UIColor blackColor];
        muertosTotal.tag=100;
        [self addSubview:muertosTotal];
        
                
        paxSubenTotal=[[UITextField alloc]initWithFrame:CGRectMake(505, 2, 40, 30)];
        paxSubenTotal.borderStyle = UITextBorderStyleBezel;
        paxSubenTotal.backgroundColor=[UIColor whiteColor];
        paxSubenTotal.delegate=self;
        paxSubenTotal.font=font;
        paxSubenTotal.keyboardType=UIKeyboardTypePhonePad;
        [paxSubenTotal setUserInteractionEnabled:NO];
        paxSubenTotal.textAlignment=NSTextAlignmentCenter;
        paxSubenTotal.textColor=[UIColor blackColor];
        paxSubenTotal.tag=100;
        [self addSubview:paxSubenTotal];
        
                
        paxBajanTotal=[[UITextField alloc]initWithFrame:CGRectMake(550, 2, 40, 30)];
        paxBajanTotal.borderStyle = UITextBorderStyleBezel;
        paxBajanTotal.backgroundColor=[UIColor whiteColor];
        paxBajanTotal.delegate=self;
        paxBajanTotal.font=font;
        paxBajanTotal.keyboardType=UIKeyboardTypePhonePad;
        [paxBajanTotal setUserInteractionEnabled:NO];
        paxBajanTotal.textAlignment=NSTextAlignmentCenter;
        paxBajanTotal.textColor=[UIColor blackColor];
        paxBajanTotal.tag=100;
        [self addSubview:paxBajanTotal];
        
                
        paxTransitoTotal=[[UITextField alloc]initWithFrame:CGRectMake(595, 2, 40, 30)];
        paxTransitoTotal.borderStyle = UITextBorderStyleBezel;
        paxTransitoTotal.backgroundColor=[UIColor whiteColor];
        paxTransitoTotal.delegate=self;
        paxTransitoTotal.font=font;
        paxTransitoTotal.keyboardType=UIKeyboardTypePhonePad;
        [paxTransitoTotal setUserInteractionEnabled:NO];
        paxTransitoTotal.textAlignment=NSTextAlignmentCenter;
        paxTransitoTotal.textColor=[UIColor blackColor];
        paxTransitoTotal.tag=100;
        [self addSubview:paxTransitoTotal];
        
                
        cargaSubenTotal=[[UITextField alloc]initWithFrame:CGRectMake(640, 2, 40, 30)];
        cargaSubenTotal.borderStyle = UITextBorderStyleBezel;
        cargaSubenTotal.backgroundColor=[UIColor whiteColor];
        cargaSubenTotal.delegate=self;
        cargaSubenTotal.font=font;
        cargaSubenTotal.keyboardType=UIKeyboardTypePhonePad;
        [cargaSubenTotal setUserInteractionEnabled:NO];
        cargaSubenTotal.textAlignment=NSTextAlignmentCenter;
        cargaSubenTotal.textColor=[UIColor blackColor];
        cargaSubenTotal.tag=100;
        [self addSubview:cargaSubenTotal];
        
                
        
        cargaBajanTotal=[[UITextField alloc]initWithFrame:CGRectMake(685, 2, 40, 30)];
        cargaBajanTotal.borderStyle = UITextBorderStyleBezel;
        cargaBajanTotal.backgroundColor=[UIColor whiteColor];
        cargaBajanTotal.delegate=self;
        cargaBajanTotal.font=font;
        cargaBajanTotal.keyboardType=UIKeyboardTypePhonePad;
        [cargaBajanTotal setUserInteractionEnabled:NO];
        cargaBajanTotal.textAlignment=NSTextAlignmentCenter;
        cargaBajanTotal.textColor=[UIColor blackColor];
        cargaBajanTotal.tag=100;
        [self addSubview:cargaBajanTotal];
        
                
        cargaTransitoTotal=[[UITextField alloc]initWithFrame:CGRectMake(730, 2, 40, 30)];
        cargaTransitoTotal.borderStyle = UITextBorderStyleBezel;
        cargaTransitoTotal.backgroundColor=[UIColor whiteColor];
        cargaTransitoTotal.delegate=self;
        cargaTransitoTotal.font=font;
        cargaTransitoTotal.keyboardType=UIKeyboardTypePhonePad;
        [cargaTransitoTotal setUserInteractionEnabled:NO];
        cargaTransitoTotal.textAlignment=NSTextAlignmentCenter;
        cargaTransitoTotal.textColor=[UIColor blackColor];
        cargaTransitoTotal.tag=100;
        [self addSubview:cargaTransitoTotal];
        
        
    }
    return self;
}

#pragma mark - picker delegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==2001) {
        return lista.arregloDeEntidades.count;
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
            Entidad *result=[lista.arregloDeEntidades objectAtIndex:row];
            NSString *strRes=result.nombreOrganizacion;
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
            Entidad *result=[lista.arregloDeEntidades objectAtIndex:row];
            NSString *strRes=result.nombreOrganizacion;
            entidadTextfield.text=strRes;
            idEntidad=result.idOrganizacion;
            return;
        }
    }
    return;
    
}

@end
