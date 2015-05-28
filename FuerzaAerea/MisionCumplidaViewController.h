//
//  MisionCumplidaViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 13/04/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CeldaItinerario.h"
#import "CeldaCondiciones.h"
#import "ModeladorDeOrdenDeVuelo.h"
#import "CeldaArmamento.h"
#import "CeldaTripulacion.h"
#import "CeldaTeplasSanidad.h"
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
#import "NSData+AES.h"
#import "UITextFieldDS.h"
@interface MisionCumplidaViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    MBProgressHUD *hud;
    IBOutlet UIScrollView *pageScrollView;
    
    IBOutlet UIButton *botonInforme;
    IBOutlet UIButton *botonInformacion;
    IBOutlet UIButton *botonPaxArmamento;
    IBOutlet UIButton *botonResultados;
    IBOutlet UIButton *botonMotivosRetardo;
    
    IBOutlet UITextField *consecutivoTF;
    IBOutlet UITextField *unidadAsumeTF;
    IBOutlet UITextField *unidadCreaTF;
    IBOutlet UITextField *fechaDigitadoTF;
    IBOutlet UITextField *registroVueloTF;
    IBOutlet UITextField *fechaTF;
    IBOutlet UITextField *horaTF;
    IBOutlet UITextField *ovTF;
    IBOutlet UITextField *aeronaveUnoTF;
    IBOutlet UITextField *aeronaveDosTF;
    IBOutlet UITextField *hDecolajeTF;
    IBOutlet UITextField *hAterrizajeTF;
    IBOutlet UITextField *horaBlancoTF;
    IBOutlet UITextField *firmaTF;
    IBOutlet UITextField *itinerarioTF;

    IBOutlet UITextView *requerimientosTextfield;
    
    
    UIScrollView *paginaInforme;
    UITextView *descripcionTV;
    UITextView *recomendacionesTV;
    UITextView *resultadosTV;
    UITextView *observacionesTV;
    UITextView *noSerieVideoTV;
    
    
    UIScrollView *paginaInformacion;
    UITextView *instruccionesTV;
    UISwitch *escoltaVIPSwitch;
    UISwitch *transporteVIPSwitch;
    
    NSMutableDictionary *masterDictionary;
    NSMutableDictionary *informeDictionary;
    NSMutableDictionary *infoGeneralDictionary;
    NSMutableDictionary *paxCargaDictionary;
    NSMutableDictionary *resultadosDictionary;
    NSMutableDictionary *motivosDictionary;

    UITextField *currentTextField;
    UIPickerView *currentPicker;
    UILabel *overlayLabel;
    
    UIScrollView *paginaPaxArmamento;
    
    UIScrollView *paginaResultados;
    
    UIScrollView *paginaMotivos;
    
    NSString *idGrupo;
    NSString *idArmamentoImpactado;
    NSString *idMunicipio;
    NSString *idDepartamento;
    NSString *idUnidadAsume;
    NSString *idUnidad;
    
    UITextField *totalPaxTF;
    UITextField *totalCargaTF;
    
    
    UIPickerView *pickerEntidad;
    UIPickerView *pickerRequerimiento;
    UIPickerView *pickerOperacion;
    UIPickerView *pickerOperacionTipo;
    UIPickerView *pickerPlan;
    
    UIPickerView *pickerTipoPax;
    UIPickerView *pickerEntidadPax;
    UIPickerView *pickerNumeros;
    UIPickerView *pickerCantidadCarga;
    UIPickerView *pickerEntidadCarga;
    UIPickerView *pickerTipoArmamento;
    UIPickerView *pickerCantidadArmamento;
    UIPickerView *pickerCantidadFallidoArmamento;
    UIPickerView *pickerEfectividadArmamento;
    
    UIPickerView *pickerResultadosTipoOperacion;
    UIPickerView *pickerResultadosMotivosIncumplimiento;
    UIPickerView *pickerResultadosConvenio;
    UIPickerView *pickerResultadosInmediatos;
    UIPickerView *pickerResultadosCantidad;
    
    UIDatePicker *fechaCompletaPicker;
    UIDatePicker *datePicker;
    UIDatePicker *hourPicker;
    
    UIPickerView *pickerRetardo;
    
    NSMutableArray *numbersArray;

    NSMutableArray *sumaPaxArray;
    NSMutableArray *sumaCargaArray;
    NSMutableArray *porcentajeArray;
    
    CeldaCondiciones *condicionesTotal;
    
}
@property(nonatomic,retain)ModeladorDeOrdenDeVuelo *ordenDeVuelo;




@end