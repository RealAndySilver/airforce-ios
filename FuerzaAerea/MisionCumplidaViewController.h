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
@interface MisionCumplidaViewController : UIViewController<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
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
    
    
    UIPickerView *pickerFaseVuelo;
    UIPickerView *pickerDepto;
    UIPickerView *pickerMunicipio;
    UIPickerView *pickerArmamentos;
    UIPickerView *pickerLatitud;
    UIPickerView *pickerLongitud;
    UIPickerView *pickerUnidad;
    UIPickerView *pickerGrupo;
    
    UIDatePicker *datePicker;
    
    
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
    
    
    UIScrollView *paginaPaxArmamento;
    UITextFieldDS *tipoPax0;
    UITextFieldDS *entidadPax0;
    UITextFieldDS *cantidadPax0;
    UITextFieldDS *tipoPax1;
    UITextFieldDS *entidadPax1;
    UITextFieldDS *cantidadPax1;
    UITextFieldDS *tipoPax2;
    UITextFieldDS *entidadPax2;
    UITextFieldDS *cantidadPax2;
    UITextFieldDS *tipoPax3;
    UITextFieldDS *entidadPax3;
    UITextFieldDS *cantidadPax3;
    UITextFieldDS *tipoPax4;
    UITextFieldDS *entidadPax4;
    UITextFieldDS *cantidadPax4;
    UITextFieldDS *tipoPax5;
    UITextFieldDS *entidadPax5;
    UITextFieldDS *cantidadPax5;
    UITextFieldDS *tipoPax6;
    UITextFieldDS *entidadPax6;
    UITextFieldDS *cantidadPax6;
    UITextFieldDS *tipoPax7;
    UITextFieldDS *entidadPax7;
    UITextFieldDS *cantidadPax7;
    
    UITextFieldDS *entidadCarga0;
    UITextFieldDS *cantidadCarga0;
    UITextFieldDS *entidadCarga1;
    UITextFieldDS *cantidadCarga1;
    UITextFieldDS *entidadCarga2;
    UITextFieldDS *cantidadCarga2;
    UITextFieldDS *entidadCarga3;
    UITextFieldDS *cantidadCarga3;
    UITextFieldDS *entidadCarga4;
    UITextFieldDS *cantidadCarga4;
    UITextFieldDS *entidadCarga5;
    UITextFieldDS *cantidadCarga5;
    UITextFieldDS *entidadCarga6;
    UITextFieldDS *cantidadCarga6;
    UITextFieldDS *entidadCarga7;
    UITextFieldDS *cantidadCarga7;
    
    UITextFieldDS *tipoArmamento0;
    UITextFieldDS *cantidadArmamento0;
    UITextFieldDS *cantidadFallidoArmamento0;
    UITextFieldDS *efectividadArmamento0;
    UITextFieldDS *tipoArmamento1;
    UITextFieldDS *cantidadArmamento1;
    UITextFieldDS *cantidadFallidoArmamento1;
    UITextFieldDS *efectividadArmamento1;
    UITextFieldDS *tipoArmamento2;
    UITextFieldDS *cantidadArmamento2;
    UITextFieldDS *cantidadFallidoArmamento2;
    UITextFieldDS *efectividadArmamento2;
    UITextFieldDS *tipoArmamento3;
    UITextFieldDS *cantidadArmamento3;
    UITextFieldDS *cantidadFallidoArmamento3;
    UITextFieldDS *efectividadArmamento3;
    UITextFieldDS *tipoArmamento4;
    UITextFieldDS *cantidadArmamento4;
    UITextFieldDS *cantidadFallidoArmamento4;
    UITextFieldDS *efectividadArmamento4;
    UITextFieldDS *tipoArmamento5;
    UITextFieldDS *cantidadArmamento5;
    UITextFieldDS *cantidadFallidoArmamento5;
    UITextFieldDS *efectividadArmamento5;
    UITextFieldDS *tipoArmamento6;
    UITextFieldDS *cantidadArmamento6;
    UITextFieldDS *cantidadFallidoArmamento6;
    UITextFieldDS *efectividadArmamento6;
    UITextFieldDS *tipoArmamento7;
    UITextFieldDS *cantidadArmamento7;
    UITextFieldDS *cantidadFallidoArmamento7;
    UITextFieldDS *efectividadArmamento7;
    UITextFieldDS *tipoArmamento8;
    UITextFieldDS *cantidadArmamento8;
    UITextFieldDS *cantidadFallidoArmamento8;
    UITextFieldDS *efectividadArmamento8;
    
    UIScrollView *paginaResultados;
    
    UIScrollView *paginaMotivos;
    UITextField *retardo1;
    UITextField *retardo2;
    UITextField *retardo3;
    UITextField *retardo4;
    UITextField *retardo5;
    UITextField *retardo6;
    UITextField *retardo7;
    UITextField *retardo8;
    
    NSString *idGrupo;
    NSString *idArmamentoImpactado;
    NSString *idMunicipio;
    NSString *idDepartamento;
    NSString *idUnidadAsume;
    NSString *idUnidad;
    
    CeldaCondiciones *condicionesTotal;
    
}
@property(nonatomic,retain)ModeladorDeOrdenDeVuelo *ordenDeVuelo;




@end