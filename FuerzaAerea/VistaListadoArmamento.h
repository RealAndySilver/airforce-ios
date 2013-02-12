//
//  VistaListadoArmamento.h
//  FuerzaAerea
//
//  Created by Andres Abril on 31/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CeldaArmamento.h"

@interface VistaListadoArmamento : UIView
@property(nonatomic,retain)CeldaArmamento *fila1;
@property(nonatomic,retain)CeldaArmamento *fila2;
@property(nonatomic,retain)CeldaArmamento *fila3;
@property(nonatomic,retain)CeldaArmamento *fila4;
@property(nonatomic,retain)CeldaArmamento *fila5;
@property(nonatomic,retain)CeldaArmamento *fila6;
@property(nonatomic,retain)CeldaArmamento *fila7;
@property(nonatomic,retain)CeldaArmamento *fila8;
@property(nonatomic,retain)CeldaArmamento *fila9;
@property(nonatomic,retain)UILabel *noVuelo;
@property(nonatomic,retain)NSString *stringNoVuelo;

@property(nonatomic,retain)NSMutableArray *arregloDeFilasArmamento;

- (id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate;

@end
