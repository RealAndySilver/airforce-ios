//
//  VistaListadoArmamento.m
//  FuerzaAerea
//
//  Created by Andres Abril on 31/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "VistaListadoArmamento.h"

@implementation VistaListadoArmamento
@synthesize fila1,fila2,fila3,fila4,fila5,fila6,fila7,fila8,fila9,noVuelo,arregloDeFilasArmamento,stringNoVuelo;
- (id)initWithFrame:(CGRect)frame andDelegate:(id)myDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 964, 300);
        CeldaArmamento *armamentoHeader=[[CeldaArmamento alloc]initHeaderWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:armamentoHeader];
        float posFinalY=0;
        arregloDeFilasArmamento=[[NSMutableArray alloc]init];
        /*fila1=[[CeldaArmamento alloc]initWithFrame:CGRectMake(0, 33+33*0, 0,0) andDelegate:nil];
        [self addSubview:fila1];
        fila2=[[CeldaArmamento alloc]initWithFrame:CGRectMake(0, 33+33*1, 0,0) andDelegate:nil];
        [self addSubview:fila2];
        fila3=[[CeldaArmamento alloc]initWithFrame:CGRectMake(0, 33+33*2, 0,0) andDelegate:nil];
        [self addSubview:fila3];
        fila4=[[CeldaArmamento alloc]initWithFrame:CGRectMake(0, 33+33*3, 0,0) andDelegate:nil];
        [self addSubview:fila4];
        fila5=[[CeldaArmamento alloc]initWithFrame:CGRectMake(0, 33+33*4, 0,0) andDelegate:nil];
        [self addSubview:fila5];
        fila6=[[CeldaArmamento alloc]initWithFrame:CGRectMake(0, 33+33*5, 0,0) andDelegate:nil];
        [self addSubview:fila6];
        fila7=[[CeldaArmamento alloc]initWithFrame:CGRectMake(0, 33+33*6, 0,0) andDelegate:nil];
        [self addSubview:fila7];
        fila8=[[CeldaArmamento alloc]initWithFrame:CGRectMake(0, 33+33*7, 0,0) andDelegate:nil];
        [self addSubview:fila8];*/
        
        for (int i=0; i<8; i++) {
            CeldaArmamento *filaX=[[CeldaArmamento alloc]initWithFrame:CGRectMake(0, 33+33*i, 0,0) andDelegate:myDelegate];
            [self addSubview:filaX];
            posFinalY=filaX.frame.origin.y+33;
            [arregloDeFilasArmamento addObject:filaX];
        }
        //posFinalY=fila8.frame.origin.y+33;

        noVuelo=[[UILabel alloc]initWithFrame:CGRectMake(0, posFinalY, 964, 80)];
        noVuelo.backgroundColor=[UIColor clearColor];
        noVuelo.textAlignment=NSTextAlignmentCenter;
        noVuelo.font=[UIFont boldSystemFontOfSize:30];
        noVuelo.textColor=[UIColor darkGrayColor];
        //noVuelo.text=@"No. Vuelo = 1";
        [self addSubview:noVuelo];
    }
    return self;
}
@end
