//
//  PiernasCell.h
//  FuerzaAerea
//
//  Created by Andres Abril on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiernasCell : UITableViewCell{
}
@property(nonatomic,retain)IBOutlet UILabel *plan;
@property(nonatomic,retain)IBOutlet UILabel *operacionTipo;
@property(nonatomic,retain)IBOutlet UILabel *operacion;
@property(nonatomic,retain)IBOutlet UILabel *desde;
@property(nonatomic,retain)IBOutlet UILabel *hasta;
@property(nonatomic,retain)IBOutlet UILabel *piernaNumero;


@property(nonatomic,retain)IBOutlet UILabel *cargo;
@property(nonatomic,retain)IBOutlet UILabel *grado;
@property(nonatomic,retain)IBOutlet UILabel *nombre;
@property(nonatomic,retain)IBOutlet UILabel *codigo;

@property(nonatomic,retain)IBOutlet UILabel *idArmamento;
@property(nonatomic,retain)IBOutlet UILabel *armamento;
@property(nonatomic,retain)IBOutlet UILabel *cantidad;


@end
