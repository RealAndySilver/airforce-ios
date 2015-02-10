//
//  SanidadCell.h
//  FuerzaAerea
//
//  Created by Andres Abril on 9/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SanidadCell : UITableViewCell

@property(nonatomic,retain) UILabel *persona_id;
@property(nonatomic,retain) UILabel *orden_vuelo_id;
@property(nonatomic,retain) UILabel *cargo;
@property(nonatomic,retain) UILabel *grado;
@property(nonatomic,retain) UILabel *sanidad_orden_id;
@property(nonatomic,retain) UILabel *notificado;

@end