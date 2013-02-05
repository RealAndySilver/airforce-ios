//
//  CeldaCondiciones.h
//  FuerzaAerea
//
//  Created by Andres Abril on 27/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CeldaCondiciones :UIView<UITextFieldDelegate>{
    
    UILabel *vfrHhOverlay;
    UILabel *vfrMiOverlay;
    UILabel *ifrHhOverlay;
    UILabel *ifrMiOverlay;
    UILabel *nocHhOverlay;
    UILabel *nocMiOverlay;
    UILabel *nvgHhOverlay;
    UILabel *nvgMiOverlay;
    UILabel *aterrizajesOverlay;
    UILabel *heridosOverlay;
    UILabel *muertosOverlay;
    UILabel *paxSubenOverlay;
    UILabel *paxBajanOverlay;
    //UILabel *paxTransitoOverlay;
    UILabel *cargaSubenOverlay;
    UILabel *cargaBajanOverlay;
    //UILabel *cargaTransitoOverlay;
    UILabel *entidadOverlay;
    
    UILabel *vfrHhHeader;
    UILabel *vfrMiHeader;
    UILabel *ifrHhHeader;
    UILabel *ifrMiHeader;
    UILabel *nocHhHeader;
    UILabel *nocMiHeader;
    UILabel *nvgHhHeader;
    UILabel *nvgMiHeader;
    UILabel *aterrizajesHeader;
    UILabel *heridosHeader;
    UILabel *muertosHeader;
    UILabel *paxSubenHeader;
    UILabel *paxBajanHeader;
    UILabel *paxTransitoHeader;
    UILabel *cargaSubenHeader;
    UILabel *cargaBajanHeader;
    UILabel *cargaTransitoHeader;
    UILabel *entidadHeader;
    
}
@property(nonatomic,retain)UITextField *vfrHhTextfield;
@property(nonatomic,retain)UITextField *vfrMiTextfield;
@property(nonatomic,retain)UITextField *ifrHhTextfield;
@property(nonatomic,retain)UITextField *ifrMiTextfield;
@property(nonatomic,retain)UITextField *nocHhTextfield;
@property(nonatomic,retain)UITextField *nocMiTextfield;
@property(nonatomic,retain)UITextField *nvgHhTextfield;
@property(nonatomic,retain)UITextField *nvgMiTextfield;
@property(nonatomic,retain)UITextField *aterrizajesTextfield;
@property(nonatomic,retain)UITextField *heridosTextfield;
@property(nonatomic,retain)UITextField *muertosTextfield;
@property(nonatomic,retain)UITextField *paxSubenTextfield;
@property(nonatomic,retain)UITextField *paxBajanTextfield;
@property(nonatomic,retain)UITextField *paxTransitoTextfield;
@property(nonatomic,retain)UILabel *paxTransitoOverlay;
@property(nonatomic,retain)UILabel *cargaTransitoOverlay;

@property(nonatomic,retain)UITextField *cargaSubenTextfield;
@property(nonatomic,retain)UITextField *cargaBajanTextfield;
@property(nonatomic,retain)UITextField *cargaTransitoTextfield;
@property(nonatomic,retain)UITextField *entidadTextfield;

@property(nonatomic,retain)UITextField *vfrHhTotal;
@property(nonatomic,retain)UITextField *vfrMiTotal;
@property(nonatomic,retain)UITextField *ifrHhTotal;
@property(nonatomic,retain)UITextField *ifrMiTotal;
@property(nonatomic,retain)UITextField *nocHhTotal;
@property(nonatomic,retain)UITextField *nocMiTotal;
@property(nonatomic,retain)UITextField *nvgHhTotal;
@property(nonatomic,retain)UITextField *nvgMiTotal;
@property(nonatomic,retain)UITextField *aterrizajesTotal;
@property(nonatomic,retain)UITextField *heridosTotal;
@property(nonatomic,retain)UITextField *muertosTotal;
@property(nonatomic,retain)UITextField *paxSubenTotal;
@property(nonatomic,retain)UITextField *paxBajanTotal;
@property(nonatomic,retain)UITextField *paxTransitoTotal;
@property(nonatomic,retain)UITextField *cargaSubenTotal;
@property(nonatomic,retain)UITextField *cargaBajanTotal;
@property(nonatomic,retain)UITextField *cargaTransitoTotal;


@property(nonatomic)double segundosEncendido;
@property(nonatomic)double segundosApagado;
@property(nonatomic)double segundosDecolaje;
@property(nonatomic)double segundosAterrizaje;

-(id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate;
-(id)initHeaderWithFrame:(CGRect)frame;
-(id)initTotalWithFrame:(CGRect)frame;
@end
