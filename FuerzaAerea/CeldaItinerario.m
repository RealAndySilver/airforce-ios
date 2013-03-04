//
//  CeldaItinerario.m
//  FuerzaAerea
//
//  Created by Andres Abril on 22/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "CeldaItinerario.h"

@implementation CeldaItinerario
@synthesize a,de,horaApagado,horaAterrizaje,horaDecolaje,horaEncendido,noVuelo,operacion,plan,tiempoAeronave,tiempoTripulacion,tipoOperacion;
@synthesize segundosApagado,segundosAterrizaje,segundosDecolaje,segundosEncendido,checkDefensa,idDe,idA;
@synthesize horaApagadoOverlay,horaAterrizajeOverlay,horaDecolajeOverlay,horaEncendidoOverlay,lista;
@synthesize idOperacion,idPlan,idTipoOperacion;
@synthesize horaApagadoFormateado,horaAterrizajeFormateado,horaDecolajeFormateado,horaEncendidoFormateado;
- (id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissPicker) name:@"esconderPicker" object:nil];
        lista=myDelegate;
        segundosAterrizaje=0;
        segundosApagado=0;
        segundosDecolaje=0;
        segundosEncendido=0;
        
        [horaApagado setHidden:YES];
        [horaEncendido setHidden:YES];
        
        [horaDecolaje setHidden:YES];
        [horaAterrizaje setHidden:YES];
        
        datePicker = [[UIDatePicker alloc]init];
        [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        [datePicker addTarget:self action:@selector(displayDate:) forControlEvents:UIControlEventValueChanged];
        
        datePicker2 = [[UIDatePicker alloc]init];
        [datePicker2 setDatePickerMode:UIDatePickerModeDateAndTime];
        [datePicker2 addTarget:self action:@selector(displayDate2:) forControlEvents:UIControlEventValueChanged];

        datePicker3 = [[UIDatePicker alloc]init];
        [datePicker3 setDatePickerMode:UIDatePickerModeDateAndTime];
        [datePicker3 addTarget:self action:@selector(displayDate3:) forControlEvents:UIControlEventValueChanged];

        datePicker4 = [[UIDatePicker alloc]init];
        [datePicker4 setDatePickerMode:UIDatePickerModeDateAndTime];
        [datePicker4 addTarget:self action:@selector(displayDate4:) forControlEvents:UIControlEventValueChanged];

        
        
        
        
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 964, 34);
        self.backgroundColor=[UIColor clearColor];
        int margen=7;
        UIView *bordeSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        bordeSuperior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeSuperior];
        
        UIView *bordeInferior=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        bordeInferior.backgroundColor=[UIColor blackColor];
        [self addSubview:bordeInferior];
        
        noVuelo=[[UITextField alloc]initWithFrame:CGRectMake(10, 2, 30, 30)];
        noVuelo.borderStyle = UITextBorderStyleLine;
        noVuelo.delegate=myDelegate;
        [noVuelo setUserInteractionEnabled:NO];
        noVuelo.textAlignment=NSTextAlignmentCenter;
        noVuelo.textColor=[UIColor blackColor];
        noVuelo.tag=100;
        [self addSubview:noVuelo];
        
        de=[[UITextField alloc]initWithFrame:CGRectMake(40+margen*1, 2, 50, 30)];
        de.borderStyle = UITextBorderStyleLine;
        [de setUserInteractionEnabled:NO];
        de.font=[UIFont fontWithName:@"Helvetica" size:13];
        de.delegate=myDelegate;
        [self addSubview:de];
        
        a=[[UITextField alloc]initWithFrame:CGRectMake(90+margen*2, 2, 50, 30)];
        a.borderStyle = UITextBorderStyleLine;
        [a setUserInteractionEnabled:NO];
        a.delegate=myDelegate;
        a.font=[UIFont fontWithName:@"Helvetica" size:13];
        [self addSubview:a];
        
        
        UIFont *fontHoras=[UIFont fontWithName:@"Helvetica" size:13];
        horaEncendido=[[UITextField alloc]initWithFrame:CGRectMake(140+margen*3, 2, 50, 30)];
        horaEncendido.borderStyle = UITextBorderStyleLine;
        horaEncendido.delegate=self;
        horaEncendido.inputView=datePicker;
        horaEncendido.font=fontHoras;
        horaEncendido.tag=1;
        [self addSubview:horaEncendido];
        
        horaEncendidoOverlay=[[UILabel alloc]initWithFrame:CGRectMake(140+margen*3, 2, 50, 30)];
        horaEncendidoOverlay.numberOfLines=3;
        [horaEncendidoOverlay setUserInteractionEnabled:YES];
        horaEncendidoOverlay.font=fontHoras;
        [self addSubview:horaEncendidoOverlay];
        UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(first)];
        [horaEncendidoOverlay addGestureRecognizer:tap1];
        
        horaApagado=[[UITextField alloc]initWithFrame:CGRectMake(190+margen*4, 2, 50, 30)];
        horaApagado.borderStyle = UITextBorderStyleRoundedRect;
        horaApagado.delegate=self;
        horaApagado.inputView=datePicker2;
        horaApagado.font=fontHoras;
        horaApagado.tag=2;
        [self addSubview:horaApagado];
        
        horaApagadoOverlay=[[UILabel alloc]initWithFrame:CGRectMake(197+margen*3, 2, 50, 30)];
        horaApagadoOverlay.numberOfLines=3;
        horaApagadoOverlay.font=fontHoras;
        [horaApagadoOverlay setUserInteractionEnabled:YES];
        [self addSubview:horaApagadoOverlay];
        UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(second)];
        [horaApagadoOverlay addGestureRecognizer:tap2];
        
        horaDecolaje=[[UITextField alloc]initWithFrame:CGRectMake(240+margen*5, 2, 50, 30)];
        horaDecolaje.borderStyle = UITextBorderStyleRoundedRect;
        horaDecolaje.delegate=self;
        horaDecolaje.inputView=datePicker3;
        horaDecolaje.font=fontHoras;
        horaDecolaje.tag=3;
        [self addSubview:horaDecolaje];
        
        horaDecolajeOverlay=[[UILabel alloc]initWithFrame:CGRectMake(254+margen*3, 2, 50, 30)];
        horaDecolajeOverlay.numberOfLines=3;
        horaDecolajeOverlay.font=fontHoras;
        [self addSubview:horaDecolajeOverlay];
        [horaDecolajeOverlay setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(third)];
        [horaDecolajeOverlay addGestureRecognizer:tap3];
        
        horaAterrizaje=[[UITextField alloc]initWithFrame:CGRectMake(290+margen*6, 2, 50, 30)];
        horaAterrizaje.borderStyle = UITextBorderStyleRoundedRect;
        horaAterrizaje.delegate=self;
        horaAterrizaje.inputView=datePicker4;
        horaAterrizaje.font=fontHoras;
        horaAterrizaje.tag=4;
        [self addSubview:horaAterrizaje];
        
        horaAterrizajeOverlay=[[UILabel alloc]initWithFrame:CGRectMake(311+margen*3, 2, 50, 30)];
        horaAterrizajeOverlay.numberOfLines=3;
        horaAterrizajeOverlay.font=fontHoras;
        [self addSubview:horaAterrizajeOverlay];
        [horaAterrizajeOverlay setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourth)];
        [horaAterrizajeOverlay addGestureRecognizer:tap4];
        
        tiempoAeronave=[[UILabel alloc]initWithFrame:CGRectMake(340+margen*7, 2, 60, 30)];
        //tiempoAeronave.borderStyle = UITextBorderStyleRoundedRect;
        //tiempoAeronave.delegate=myDelegate;
        tiempoAeronave.textAlignment=NSTextAlignmentCenter;
        tiempoAeronave.font=fontHoras;
        [tiempoAeronave setUserInteractionEnabled:NO];
        [self addSubview:tiempoAeronave];
        
        tiempoAeronaveOverlay=[[UILabel alloc]initWithFrame:CGRectMake(340+margen*7, 2, 60, 30)];
        tiempoAeronaveOverlay.textAlignment=NSTextAlignmentCenter;
        tiempoAeronaveOverlay.backgroundColor=[UIColor grayColor];
        tiempoAeronaveOverlay.font=fontHoras;
        [tiempoAeronaveOverlay setUserInteractionEnabled:NO];
        [self addSubview:tiempoAeronaveOverlay];
        
        tiempoTripulacion=[[UILabel alloc]initWithFrame:CGRectMake(400+margen*8, 2, 60, 30)];
        tiempoTripulacion.textAlignment=NSTextAlignmentCenter;
        tiempoTripulacion.font=fontHoras;
        [tiempoTripulacion setUserInteractionEnabled:NO];
        [self addSubview:tiempoTripulacion];
        
        tiempoTripulacionOverlay=[[UILabel alloc]initWithFrame:CGRectMake(400+margen*8, 2, 60, 30)];
        tiempoTripulacionOverlay.textAlignment=NSTextAlignmentCenter;
        tiempoTripulacionOverlay.backgroundColor=[UIColor grayColor];
        tiempoTripulacionOverlay.font=fontHoras;
        [tiempoTripulacionOverlay setUserInteractionEnabled:NO];
        [self addSubview:tiempoTripulacionOverlay];
        
        tipoOperacion=[[UITextField alloc]initWithFrame:CGRectMake(460+margen*9, 2, 100, 30)];
        tipoOperacion.borderStyle = UITextBorderStyleRoundedRect;
        tipoOperacion.delegate=self;
        tipoOperacion.font=[UIFont fontWithName:@"Helvetica" size:8];
        [self addSubview:tipoOperacion];
        
        plan=[[UITextField alloc]initWithFrame:CGRectMake(560+margen*10, 2, 100, 30)];
        plan.borderStyle = UITextBorderStyleRoundedRect;
        plan.delegate=self;
        plan.font=[UIFont fontWithName:@"Helvetica" size:8];
        [self addSubview:plan];
        
        operacion=[[UITextField alloc]initWithFrame:CGRectMake(660+margen*11, 2, 100, 30)];
        operacion.borderStyle = UITextBorderStyleRoundedRect;
        operacion.delegate=self;
        operacion.font=[UIFont fontWithName:@"Helvetica" size:8];
        [self addSubview:operacion];
        
        checkDefensa=[[CheckView alloc]initWithFrame:CGRectMake(770+margen*12, 2, 0,0)];
        [self addSubview:checkDefensa];
        
        UIButton *validateButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [validateButton setBackgroundImage:[UIImage imageNamed:@"atras.png"] forState:UIControlStateNormal];
        [validateButton setTitle:@"Validar" forState:UIControlStateNormal];
        validateButton.frame=CGRectMake(830+margen*11, 2, 50, 30);
        validateButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:10];
        [validateButton addTarget:self action:@selector(validar) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:validateButton];
        
        
        pickerTipoOperacion=[[UIPickerView alloc]init];
        pickerTipoOperacion.dataSource=self;
        pickerTipoOperacion.delegate=self;
        pickerTipoOperacion.showsSelectionIndicator = YES;
        pickerTipoOperacion.tag=2001;
        if (lista.arregloDeTipoOperacion.count) {
            tipoOperacion.inputView=pickerTipoOperacion;
        }
        
        pickerPlan=[[UIPickerView alloc]init];
        pickerPlan.dataSource=self;
        pickerPlan.delegate=self;
        pickerPlan.showsSelectionIndicator = YES;
        pickerPlan.tag=2002;
        if (lista.arregloDePlan.count) {
            plan.inputView=pickerPlan;
        }
        
        pickerOperacion=[[UIPickerView alloc]init];
        pickerOperacion.dataSource=self;
        pickerOperacion.delegate=self;
        pickerOperacion.showsSelectionIndicator = YES;
        pickerOperacion.tag=2003;
        if (lista.arregloDeOperacion.count) {
            operacion.inputView=pickerOperacion;
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
        self.backgroundColor=bgColor;
        int margen=7;
        
        //UIFont *font=[UIFont fontWithName:@"Helvetica" size:10];
        UIFont *font=[UIFont boldSystemFontOfSize:10];

        UIColor *fontColor=[UIColor blackColor];
        
        UILabel *noVueloLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 30, altura)];
        noVueloLabel.text=@"No. Vuelo";
        noVueloLabel.numberOfLines=2;
        noVueloLabel.font=font;
        noVueloLabel.textAlignment=NSTextAlignmentCenter;
        noVueloLabel.backgroundColor=bgColor;
        noVueloLabel.textColor=fontColor;
        [self addSubview:noVueloLabel];
        
        UILabel *deLabel=[[UILabel alloc]initWithFrame:CGRectMake(40+margen*1, 2, 50, altura)];
        deLabel.text=@"De";
        deLabel.font=font;
        deLabel.numberOfLines=2;
        deLabel.backgroundColor=bgColor;
        deLabel.textAlignment=NSTextAlignmentCenter;
        deLabel.textColor=fontColor;
        [self addSubview:deLabel];
        
        UILabel *aLabel=[[UILabel alloc]initWithFrame:CGRectMake(90+margen*2, 2, 50, altura)];
        aLabel.text=@"A";
        aLabel.font=font;
        aLabel.numberOfLines=2;
        aLabel.backgroundColor=bgColor;
        aLabel.textAlignment=NSTextAlignmentCenter;
        aLabel.textColor=fontColor;
        [self addSubview:aLabel];
        
        UILabel *horaEncendidoLabel=[[UILabel alloc]initWithFrame:CGRectMake(140+margen*3, 2, 50, altura)];
        horaEncendidoLabel.text=@"Hora Encendido";
        horaEncendidoLabel.numberOfLines=2;
        horaEncendidoLabel.backgroundColor=bgColor;
        horaEncendidoLabel.font=font;
        horaEncendidoLabel.textAlignment=NSTextAlignmentCenter;
        horaEncendidoLabel.textColor=fontColor;
        [self addSubview:horaEncendidoLabel];
        
        UILabel *horaApagadoLabel=[[UILabel alloc]initWithFrame:CGRectMake(190+margen*4, 2, 50, altura)];
        horaApagadoLabel.text=@"Hora Apagado";
        horaApagadoLabel.numberOfLines=2;
        horaApagadoLabel.backgroundColor=bgColor;
        horaApagadoLabel.font=font;
        horaApagadoLabel.textAlignment=NSTextAlignmentCenter;
        horaApagadoLabel.textColor=fontColor;
        [self addSubview:horaApagadoLabel];
        
        UILabel *horaDecolajeLabel=[[UILabel alloc]initWithFrame:CGRectMake(240+margen*5, 2, 50, altura)];
        horaDecolajeLabel.text=@"Hora Decolaje";
        horaDecolajeLabel.numberOfLines=2;
        horaDecolajeLabel.backgroundColor=bgColor;
        horaDecolajeLabel.font=font;
        horaDecolajeLabel.textAlignment=NSTextAlignmentCenter;
        horaDecolajeLabel.textColor=fontColor;
        [self addSubview:horaDecolajeLabel];
        
        UILabel *horaAterrizajeLabel=[[UILabel alloc]initWithFrame:CGRectMake(290+margen*6, 2, 50, altura)];
        horaAterrizajeLabel.text=@"Hora Aterrizaje";
        horaAterrizajeLabel.numberOfLines=2;
        horaAterrizajeLabel.backgroundColor=bgColor;
        horaAterrizajeLabel.font=font;
        horaAterrizajeLabel.textAlignment=NSTextAlignmentCenter;
        horaAterrizajeLabel.textColor=fontColor;
        [self addSubview:horaAterrizajeLabel];
        
        UILabel *tiempoAeronaveLabel=[[UILabel alloc]initWithFrame:CGRectMake(340+margen*7, 2, 60, altura)];
        tiempoAeronaveLabel.text=@"Tiempo Tripulación";
        tiempoAeronaveLabel.numberOfLines=2;
        tiempoAeronaveLabel.backgroundColor=bgColor;
        tiempoAeronaveLabel.font=font;
        tiempoAeronaveLabel.textAlignment=NSTextAlignmentCenter;
        tiempoAeronaveLabel.textColor=fontColor;
        [self addSubview:tiempoAeronaveLabel];
        
        UILabel *tiempoTripulacionLabel=[[UILabel alloc]initWithFrame:CGRectMake(400+margen*8, 2, 60, altura)];
        tiempoTripulacionLabel.text=@"Tiempo Aeronave";
        tiempoTripulacionLabel.numberOfLines=2;
        tiempoTripulacionLabel.backgroundColor=bgColor;
        tiempoTripulacionLabel.font=font;
        tiempoTripulacionLabel.textAlignment=NSTextAlignmentCenter;
        tiempoTripulacionLabel.textColor=fontColor;
        [self addSubview:tiempoTripulacionLabel];
        
        UILabel *tipoOperacionLabel=[[UILabel alloc]initWithFrame:CGRectMake(460+margen*9, 2, 100, altura)];
        tipoOperacionLabel.text=@"Tipo Operación";
        tipoOperacionLabel.numberOfLines=2;
        tipoOperacionLabel.backgroundColor=bgColor;
        tipoOperacionLabel.font=font;
        tipoOperacionLabel.textAlignment=NSTextAlignmentCenter;
        tipoOperacionLabel.textColor=fontColor;
        [self addSubview:tipoOperacionLabel];
        
        UILabel *planLabel=[[UILabel alloc]initWithFrame:CGRectMake(560+margen*10, 2, 100, altura)];
        planLabel.text=@"Plan";
        planLabel.numberOfLines=2;
        planLabel.backgroundColor=bgColor;
        planLabel.font=font;
        planLabel.textAlignment=NSTextAlignmentCenter;
        planLabel.textColor=fontColor;
        [self addSubview:planLabel];
        
        UILabel *operacionLabel=[[UILabel alloc]initWithFrame:CGRectMake(660+margen*11, 2, 100, altura)];
        operacionLabel.text=@"Operación";
        operacionLabel.numberOfLines=2;
        operacionLabel.backgroundColor=bgColor;
        operacionLabel.font=font;
        operacionLabel.textAlignment=NSTextAlignmentCenter;
        operacionLabel.textColor=fontColor;
        [self addSubview:operacionLabel];
        
        UILabel *defensaLabel=[[UILabel alloc]initWithFrame:CGRectMake(750+margen*12, 2, 70, altura)];
        defensaLabel.text=@"Defensa población";
        defensaLabel.numberOfLines=2;
        defensaLabel.backgroundColor=bgColor;
        defensaLabel.font=font;
        defensaLabel.textAlignment=NSTextAlignmentCenter;
        defensaLabel.textColor=fontColor;
        [self addSubview:defensaLabel];
        
        UILabel *validarLabel=[[UILabel alloc]initWithFrame:CGRectMake(810+margen*12, 2, 70, altura)];
        validarLabel.text=@"Validar";
        validarLabel.numberOfLines=2;
        validarLabel.backgroundColor=bgColor;
        validarLabel.font=font;
        validarLabel.textAlignment=NSTextAlignmentCenter;
        validarLabel.textColor=fontColor;
        [self addSubview:validarLabel];
    }
    return self;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //tiempoAeronave.text=[NSString stringWithFormat:@"%i",[horaApagado.text intValue]+[horaEncendido.text intValue]];
    //tiempoTripulacion.text=[NSString stringWithFormat:@"%i",[horaDecolaje.text intValue]+[horaAterrizaje.text intValue]];
}

-(void)displayDate:(id)sender {
    if ([horaEncendido isEditing]) {
        NSDate * selected = [datePicker date];
        //NSString * dateString = [selected description];
        NSDate * selected2 = [datePicker2 date];
        NSTimeInterval interval1=[selected timeIntervalSince1970];
        NSTimeInterval interval2=[selected2 timeIntervalSince1970];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        
        NSString *strDate = [formatter stringFromDate:selected];
        strDate=[self formatearFechaConNombreCorto:strDate];
        
        [formatter setDateFormat:@"dd-MM-yy HH:mm"];
        horaEncendidoFormateado=[formatter stringFromDate:selected];
        
        segundosEncendido=interval1;
        segundosApagado=interval2;
        horaEncendidoOverlay.text = strDate;//[dateString stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
        horaEncendidoOverlay.textAlignment=NSTextAlignmentCenter;
        //NSLog(@"Date %.0f %.0f",interval1,interval2);
        [self textFieldDidEndEditing:horaEncendido];
    }
}
-(void)displayDate2:(id)sender{
    if ([horaApagado isEditing]){
        NSDate * selected = [datePicker date];
        NSDate * selected2 = [datePicker2 date];
        //NSString * date = [selected2 description];
        NSTimeInterval interval1=[selected timeIntervalSince1970];
        NSTimeInterval interval2=[selected2 timeIntervalSince1970];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        
        NSString *strDate = [formatter stringFromDate:selected2];

        strDate=[self formatearFechaConNombreCorto:strDate];

        [formatter setDateFormat:@"dd-MM-yy HH:mm"];
        horaApagadoFormateado=[formatter stringFromDate:selected2];
        
        segundosEncendido=interval1;
        segundosApagado=interval2;
        horaApagadoOverlay.text = strDate;//[date stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
        horaApagadoOverlay.textAlignment=NSTextAlignmentCenter;
        [self textFieldDidEndEditing:horaApagado];
    }
}
-(void)displayDate3:(id)sender{
    if ([horaDecolaje isEditing]){
        NSDate * selected = [datePicker3 date];
        //NSString * date = [selected description];
        NSDate * selected2 = [datePicker4 date];
        NSTimeInterval interval1=[selected timeIntervalSince1970];
        NSTimeInterval interval2=[selected2 timeIntervalSince1970];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        
        NSString *strDate = [formatter stringFromDate:selected];
        strDate=[self formatearFechaConNombreCorto:strDate];
        
        [formatter setDateFormat:@"dd-MM-yy HH:mm"];
        horaDecolajeFormateado=[formatter stringFromDate:selected];

        segundosDecolaje=interval1;
        segundosAterrizaje=interval2;
        horaDecolajeOverlay.text = strDate;//[date stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
        horaDecolajeOverlay.textAlignment=NSTextAlignmentCenter;
        [self textFieldDidEndEditing:horaDecolaje];
        //NSLog(@"Date %.0f %.0f",interval1,interval2);
    }
}
-(void)displayDate4:(id)sender{
    if ([horaAterrizaje isEditing]){
        NSDate * selected = [datePicker3 date];
        NSDate * selected2 = [datePicker4 date];
        //NSString * date = [selected2 description];
        NSTimeInterval interval1=[selected timeIntervalSince1970];
        NSTimeInterval interval2=[selected2 timeIntervalSince1970];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        
        NSString *strDate = [formatter stringFromDate:selected2];
        strDate=[self formatearFechaConNombreCorto:strDate];
        
        [formatter setDateFormat:@"dd-MM-yy HH:mm"];
        horaAterrizajeFormateado=[formatter stringFromDate:selected2];
        
        segundosDecolaje=interval1;
        segundosAterrizaje=interval2;
        horaAterrizajeOverlay.text = strDate;//[date stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
        horaAterrizajeOverlay.textAlignment=NSTextAlignmentCenter;
        [self textFieldDidEndEditing:horaAterrizaje];
        //NSLog(@"Date %@",date);
    }
}
-(NSString *)formatearFechaConNombreCorto:(NSString*)string{
    NSString *numeroExtraido=[string substringToIndex:2];
    NSString *nuevoString=[string substringFromIndex:2];
    int intMes=[numeroExtraido intValue];
    if (intMes==1) {nuevoString=[NSString stringWithFormat:@"ene%@",nuevoString];}
    else if (intMes==2) {nuevoString=[NSString stringWithFormat:@"feb%@",nuevoString];}
    else if (intMes==3) {nuevoString=[NSString stringWithFormat:@"mar%@",nuevoString];}
    else if (intMes==4) {nuevoString=[NSString stringWithFormat:@"abr%@",nuevoString];}
    else if (intMes==5) {nuevoString=[NSString stringWithFormat:@"may%@",nuevoString];}
    else if (intMes==6) {nuevoString=[NSString stringWithFormat:@"jun%@",nuevoString];}
    else if (intMes==7) {nuevoString=[NSString stringWithFormat:@"jul%@",nuevoString];}
    else if (intMes==8) {nuevoString=[NSString stringWithFormat:@"ago%@",nuevoString];}
    else if (intMes==9) {nuevoString=[NSString stringWithFormat:@"sep%@",nuevoString];}
    else if (intMes==10) {nuevoString=[NSString stringWithFormat:@"oct%@",nuevoString];}
    else if (intMes==11) {nuevoString=[NSString stringWithFormat:@"nov%@",nuevoString];}
    else if (intMes==12) {nuevoString=[NSString stringWithFormat:@"dic%@",nuevoString];}

    return nuevoString;
}
#pragma mark - validar
-(void)validar{
    /*NSDate * selected = [datePicker date];
    NSDate * selected2 = [datePicker2 date];
    NSDate * selected3 = [datePicker3 date];
    NSDate * selected4 = [datePicker4 date];*/
    
    NSDate * selected = [NSDate dateWithTimeIntervalSince1970:segundosEncendido];
    NSDate * selected2 = [NSDate dateWithTimeIntervalSince1970:segundosApagado];
    NSDate * selected3 = [NSDate dateWithTimeIntervalSince1970:segundosDecolaje];
    NSDate * selected4 = [NSDate dateWithTimeIntervalSince1970:segundosAterrizaje];
    
    double tiempo4menos3=[selected4 timeIntervalSinceReferenceDate] - [selected3 timeIntervalSinceReferenceDate];
    double tiempo2menos1=[selected2 timeIntervalSinceReferenceDate] - [selected timeIntervalSinceReferenceDate];
    
    int minutos43=(((int)tiempo4menos3/60)%60);
    int horas43=((int)tiempo4menos3/(3600));
    int minutos21=(((int)tiempo2menos1/60)%60);
    int horas21=((int)tiempo2menos1/(3600));
    NSString *horasMinutos43=[NSString stringWithFormat:@"%i:%.2i",horas43,minutos43];
    NSString *horasMinutos21=[NSString stringWithFormat:@"%i:%.2i",horas21,minutos21];
    
    if (segundosEncendido<segundosApagado) {
        if (segundosEncendido<segundosDecolaje) {
            if (segundosEncendido<segundosAterrizaje) {
                if (segundosApagado>segundosDecolaje) {
                    if (segundosApagado>segundosAterrizaje) {
                        if (segundosDecolaje<segundosAterrizaje) {
                            tiempoTripulacion.text = [NSString stringWithFormat:@"%.0f",(tiempo4menos3/60)];
                            tiempoAeronave.text = [NSString stringWithFormat:@"%.0f",(tiempo2menos1/60)];
                            tiempoTripulacionOverlay.text = horasMinutos43;
                            tiempoAeronaveOverlay.text = horasMinutos21;
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Validación de celda exitosa" message:@"La validación se ha realizado correctamente" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"validado" object:nil];
                        }
                        else{
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error de validación" message:@"El tiempo de decolaje debe ser menor al tiempo de aterrizaje" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                        
                    }
                    else{
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error de validación" message:@"El tiempo de apagado debe ser mayor al tiempo de aterrizaje" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
                else{
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error de validación" message:@"El tiempo de apagado debe ser mayor al tiempo de decolaje" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }
            else{
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error de validación" message:@"El tiempo de encendido debe ser menor al tiempo de aterrizaje" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error de validación" message:@"El tiempo de encendido debe ser menor al tiempo de decolaje" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error de validación" message:@"El tiempo de encendido debe ser menor al tiempo de apagado" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [self dismissPicker];
    
    
}
#pragma mark - label taps
-(void)first{
    //NSLog(@"taped 1");
    horaEncendidoOverlay.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    horaApagadoOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaDecolajeOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaAterrizajeOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [horaEncendido becomeFirstResponder];
}
-(void)second{
    //NSLog(@"taped 2");
    horaApagadoOverlay.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    horaEncendidoOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaDecolajeOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaAterrizajeOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [horaApagado becomeFirstResponder];
}
-(void)third{
    //NSLog(@"taped 3");
    horaDecolajeOverlay.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    horaApagadoOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaEncendidoOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaAterrizajeOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [horaDecolaje becomeFirstResponder];
}
-(void)fourth{
    //NSLog(@"taped 4");
    horaAterrizajeOverlay.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    horaApagadoOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaDecolajeOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaEncendidoOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [horaAterrizaje becomeFirstResponder];
}
#pragma mark - dismiss picker
-(void)dismissPicker{
    horaEncendidoOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaApagadoOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaDecolajeOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    horaAterrizajeOverlay.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [horaEncendido resignFirstResponder];
    [horaApagado resignFirstResponder];
    [horaDecolaje resignFirstResponder];
    [horaAterrizaje resignFirstResponder];
}


#pragma mark - picker delegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==2001) {
        return lista.arregloDeTipoOperacion.count;
    }
    else if (pickerView.tag==2002){
        return lista.arregloDePlan.count;
    }
    else if (pickerView.tag==2003){
        return lista.arregloDeOperacion.count;
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
            TipoOperacion *result=[lista.arregloDeTipoOperacion objectAtIndex:row];
            NSString *strRes=result.tipoOperacion;
            return strRes;
        }
        else if (pickerView.tag==2002){
            Plan *result=[lista.arregloDePlan objectAtIndex:row];
            NSString *strRes=result.descripcion;
            return strRes;
        }
        else if (pickerView.tag==2003){
            Operacion *result=[lista.arregloDeOperacion objectAtIndex:row];
            NSString *strRes=result.descripcion;
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
            TipoOperacion *result=[lista.arregloDeTipoOperacion objectAtIndex:row];
            NSString *strRes=result.tipoOperacion;
            tipoOperacion.text=strRes;
            idTipoOperacion=result.codigoNumerico;
            return;
        }
        else if (pickerView.tag==2002){
            Plan *result=[lista.arregloDePlan objectAtIndex:row];
            NSString *strRes=result.descripcion;
            plan.text=strRes;
            idPlan=result.idReferencia;
            return;
        }
        else if (pickerView.tag==2003){
            Operacion *result=[lista.arregloDeOperacion objectAtIndex:row];
            NSString *strRes=result.descripcion;
            operacion.text=strRes;
            idOperacion=result.codigo;
            return;
        }
    }
    return;
    
}

@end
