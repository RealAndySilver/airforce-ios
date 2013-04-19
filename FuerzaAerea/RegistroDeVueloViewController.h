//
//  RegistroDeVueloViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 21/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CeldaItinerario.h"
#import "CeldaCondiciones.h"
#import "ModeladorDeOrdenDeVuelo.h"
#import "CeldaArmamento.h"
#import "CeldaTripulacion.h"
#import "FaseVuelo.h"
#import "Departamentos.h"
#import "Armamentos.h"
#import "FileSaver.h"
#import "SBJSON.h"
#import "VistaListadoArmamento.h"
#import "Lista.h"
#import "ServerCommunicator.h"
#import "IAmCoder.h"
#import "MBProgressHud.h"

@interface RegistroDeVueloViewController : UIViewController<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    MBProgressHUD *hud;
    IBOutlet UIScrollView *pageScrollView;
    
    IBOutlet UIButton *botonItinerario;
    IBOutlet UIButton *botonCondiciones;
    IBOutlet UIButton *botonArmamento;
    IBOutlet UIButton *botonTripulacion;
    
    IBOutlet UISwitch *aeronaveImpactadaSwitch;
    IBOutlet UIView *containerAeronaveImpactada;
    IBOutlet UITextField *impactadaImpactosTextField;
    IBOutlet UITextField *impactadaDeptoTextField;
    IBOutlet UITextField *impactadaFaseTextField;
    IBOutlet UITextField *impactadaMunicipioTextField;
    IBOutlet UITextField *impactadaArmamentoTextField;
    IBOutlet UITextField *impactadaNoVueloTextField;
    IBOutlet UITextField *impactadaLatitud1TextField;
    IBOutlet UITextField *impactadaLatitud2TextField;
    IBOutlet UITextField *impactadaLatitud3TextField;
    IBOutlet UITextField *impactadaLatitud4TextField;
    IBOutlet UITextField *impactadaLongitud1TextField;
    IBOutlet UITextField *impactadaLongitud2TextField;
    IBOutlet UITextField *impactadaLongitud3TextField;
    IBOutlet UITextField *impactadaLongitud4TextField;


    IBOutlet UISwitch *vueloNacionalSwitch;
    IBOutlet UISwitch *vueloExtranjeroSwitch;
    
    IBOutlet UITextField *ordenDeVueloTextfield;
    IBOutlet UITextField *noRegistroTextfield;
    IBOutlet UITextField *fechaTextfield;
    IBOutlet UITextField *unidadAsumeTextfield;
    IBOutlet UITextField *aeronaveUnoTextfield;
    IBOutlet UITextField *aeronaveDosTextfield;
    IBOutlet UITextField *grupoTextfield;
    IBOutlet UITextField *unidadQueCreaTextfield;
    IBOutlet UITextField *observacionTextfield;
    IBOutlet UITextView *requerimientosTextfield;
    
    
    UIPickerView *pickerFaseVuelo;
    UIPickerView *pickerDepto;
    UIPickerView *pickerMunicipio;
    UIPickerView *pickerArmamentos;
    UIPickerView *pickerLatitud;
    UIPickerView *pickerLongitud;
    UIPickerView *pickerUnidad;
    UIPickerView *pickerGrupo;

    UIDatePicker *datePicker;

    
    UIScrollView *paginaItinerario;
    UILabel *totalAeronave;
    UILabel *totalTripulacion;
    
    UIScrollView *paginaCondicionesDeVuelo;
    UIScrollView *paginaArmamentoPierna;
    UIScrollView *paginaTripulacion;
    
    NSMutableArray *arregloParaSumarItinerario;
    NSMutableArray *arregloParaSumarCondiciones;
    NSMutableArray *arregloPaginasArmamento;
    NSMutableArray *arregloTripulacion;
    NSMutableArray *arregloEntrenamiento;

    NSString *idGrupo;
    NSString *idArmamentoImpactado;
    NSString *idMunicipio;
    NSString *idDepartamento;
    NSString *idUnidadAsume;
    NSString *idUnidad;
    
    NSString *idImpactadaFase;


    CeldaCondiciones *condicionesTotal;
    
}
@property(nonatomic,retain)ModeladorDeOrdenDeVuelo *ordenDeVuelo;
@property(nonatomic,retain)Lista *lista;
@property(nonatomic,retain)NSMutableArray *arrayFaseVuelo;
@property(nonatomic,retain)NSMutableArray *arrayDepartamentos;
@property(nonatomic,retain)NSMutableArray *arrayMunicipios;
@property(nonatomic,retain)NSMutableArray *arrayArmamentos;
@property(nonatomic,retain)NSMutableArray *arrayLatitud;
@property(nonatomic,retain)NSMutableArray *arrayLongitud;



@end
