//
//  CeldaItinerario.h
//  FuerzaAerea
//
//  Created by Andres Abril on 22/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckView.h"
#import "Lista.h"
@interface CeldaItinerario : UIView<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{

    UIDatePicker *datePicker;
    UIDatePicker *datePicker2;
    UIDatePicker *datePicker3;
    UIDatePicker *datePicker4;
    UILabel *tiempoAeronaveOverlay;
    UILabel *tiempoTripulacionOverlay;
    
    
    UIPickerView *pickerTipoOperacion;
    UIPickerView *pickerPlan;
    UIPickerView *pickerOperacion;
    
}
@property(nonatomic,retain)UITextField *noVuelo;
@property(nonatomic,retain)UITextField *de;
@property(nonatomic,retain)UITextField *a;
@property(nonatomic,retain)UITextField *horaEncendido;
@property(nonatomic,retain)UITextField *horaApagado;
@property(nonatomic,retain)UITextField *horaDecolaje;
@property(nonatomic,retain)UITextField *horaAterrizaje;
@property(nonatomic,retain)Lista *lista;

@property(nonatomic,retain)UILabel *horaEncendidoOverlay;
@property(nonatomic,retain)UILabel *horaApagadoOverlay;
@property(nonatomic,retain)UILabel *horaDecolajeOverlay;
@property(nonatomic,retain)UILabel *horaAterrizajeOverlay;

@property(nonatomic,retain)UILabel *tiempoAeronave;
@property(nonatomic,retain)UILabel *tiempoTripulacion;
@property(nonatomic,retain)UITextField *tipoOperacion;
@property(nonatomic,retain)UITextField *plan;
@property(nonatomic,retain)UITextField *operacion;
@property(nonatomic,retain)CheckView *checkDefensa;

@property(nonatomic)double segundosEncendido;
@property(nonatomic)double segundosApagado;
@property(nonatomic)double segundosDecolaje;
@property(nonatomic)double segundosAterrizaje;

-(id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate;
-(id)initHeaderWithFrame:(CGRect)frame;
@end
